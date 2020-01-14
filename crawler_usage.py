from crawl import Crawler
from parse import find_all_safely
import pandas as pd
import numpy as np
import os
import sys
from setup_db import DB, cursor_as_df, execute_to_df
from sanitizer import dfSanitizer, dbSanitizer

DB_PATH = 'db/database.db'

def runJob(jobID):
    # jobID is a key from a database
    # remember to update last_run column in jobs table
    job_runner = jobRunner()
    job_runner.run_job_from_job_id(jobID)
    print("scrapper run for " + str(jobID))
    return True


class ParamsHandler:
    '''
    Class used for getting parameters needed for scraper - 
    handling the database connection and keeping parameters for the crawler alongside with e.g. request_id
    '''

    def __init__(self, db):
        self.db = db
        self.params_names_from_db = None
        self.values_in_db = None
        self.request_id = None

    def fetch_requests_from_db(self):

        query_parameters = '''
        SELECT * FROM active_requests
        '''

        params_from_db = self.db.c.execute(query_parameters)
        self.params_names_from_db = [i[0] for i in params_from_db.description]
        self.values_in_db = params_from_db.fetchall()

        self.params_list = [SingleParam(param) for param in self.values_in_db]

        return None

    def get_params_for_crawler(self):
        return [param.params_for_crawler for param in self.params_list]


class SingleParam:
    '''
    Class containing info about single parameters set (with one request_id)
    '''

    def __init__(self, values_from_db):
        self._constant_params = {
            "adult": "1",
            "_locale": "pl"
        }

        self._raw_values_from_db = values_from_db
        self.variable_params = {"rideDate": self._raw_values_from_db[1],
                                "departureCity": self._raw_values_from_db[2],
                                "arrivalCity": self._raw_values_from_db[3]}
        self.request_id = self._raw_values_from_db[0]
        self.params_for_crawler = {
            **self.variable_params, ** self._constant_params}

    def __repr__(self):
        return str(self.params_for_crawler)


class SingleCrawlerWithDB(Crawler):
    '''
    Class for crawling with single parameters
    '''

    def __init__(self, db, param):
        self.db = db
        self.param = param
        self.results_pd_raw = None
        self.results_pd = None
        super().__init__(param.params_for_crawler)

    def crawl(self):
        self.get_all()
        self.results_pd_raw = self.results_df


class jobRunner:
    '''
        Class defining interface for running jobs - handles fetching requests from database, running the scraper
        logging and adding results to database
    '''
    def __init__(self, path_to_db=DB_PATH, reset_db=False):
        self.path_to_db = path_to_db
        self.reset_db = reset_db
        self.correctly_setup = False
        if not reset_db:
            self.db = DB(self.path_to_db)
        else:
            self.db = None

    def run_all_jobs(self):

        if not self.correctly_setup:
            self._setup_before_running()

        for params in self.params_handler.params_list:
            self._run_one_request(params)

    def run_request_from_request_id(self, request_id):
        if not self.correctly_setup:
            self._setup_before_running()

        # Filter parameters list and get first parameters
        # set with correct request_id
        params = next(params for params in
                      self.params_handler.params_list if
                      params.request_id == request_id)

        self._run_one_request(params)

    def run_job_from_job_id(self, job_id):
        if not self.correctly_setup:
            self._setup_before_running()

        request_ids = self._get_request_ids_for_job(job_id)
        print(request_ids)

        for request_id in request_ids:
            self.run_request_from_request_id(request_id)

    def _get_request_ids_for_job(self, job_id):
        self.db.c.execute('''SELECT 
            request_id 
            FROM requests 
            WHERE job_id = ?''', (job_id,))

        return [i[0] for i in self.db.c.fetchall()]

    def _setup_before_running(self):

        if self.reset_db and os.path.exists(self.path_to_db):
            # Clear database completely if needed (remove file)
            os.remove(self.path_to_db)

        self.db = DB(self.path_to_db)

        if self.reset_db:
            self.db.run_setup_scripts()

        self.params_handler = ParamsHandler(self.db)
        self.params_handler.fetch_requests_from_db()

        self.correctly_setup = True

    def _run_one_request(self, params):
        print(f"running request with params {params.request_id}")
        # Download the data from web
        crawler = SingleCrawlerWithDB(self.db, params)
        crawler.crawl()

        # Sanitize dataframe (remove wrong values, ensure correct format etc.)
        if crawler.results_pd_raw.empty:
            print("empty df")
            log = pd.DataFrame({
                "request_id": [params.request_id],
                "successful": [0],
                "time": [np.nan],
                "details": ["error"]})
            log.to_sql(con=self.db.conn,
                       name="execution_logs",
                       if_exists="append",
                       index=False)

            return None

        sanitizer = dfSanitizer(df=crawler.results_pd_raw)
        sanitizer.sanitize_df(
            params.variable_params, params.request_id)

        # Prepare for inserting into database - mainly to normalize stations names
        db_sanitizer = dbSanitizer(raw_df=sanitizer.sanitized_df, db=self.db)
        db_sanitizer.prepare_for_db()

        # Insert to database
        db_sanitizer.df_to_db.to_sql(con=self.db.conn,
                                     name="results",
                                     if_exists="append",
                                     index=False)

        # Insert log to database
        log = pd.DataFrame({
            "request_id": db_sanitizer.df_to_db.head(1).request_id,
            "successful": 1,
            "time": db_sanitizer.df_to_db.head(1).time_created,
            "details": np.nan})
        log.to_sql(con=self.db.conn,
                   name="execution_logs",
                   if_exists="append",
                   index=False)


if __name__ == "__main__":

    # Miscallenous tests

    job_runner = jobRunner(reset_db=False)
    # job_runner.run_job_from_request_id(4)
    job_runner.run_all_jobs()
    # job_runner.run_job_from_job_id(9)
    # job_runner.run_request_from_request_id()

    # if SETUP_NEEDED and os.path.exists(path_to_db):
    #     # Clear database completely if needed (remove file)
    #     os.remove(path_to_db)

    # db = DB(path_to_db)

    # if SETUP_NEEDED:
    #     db.run_setup_scripts()

    # # Get parameters from db table (requests)
    # params_handler = ParamsHandler(db)
    # params_handler.fetch_requests_from_db()

    # for params in params_handler.params_list:
    #     try:
    #         run_one_job(db, params)
    #     except:
    #         print("error")

    # Download the data from web
    # crawler = SingleCrawlerWithDB(db, params_handler.params_list[idx])
    # crawler.crawl()

    # # Sanitize dataframe (remove wrong values, ensure correct format etc.)
    # sanitizer = dfSanitizer(df=crawler.results_pd_raw)
    # sanitizer.sanitize_df(
    #     params_handler.params_list[idx].variable_params, params_handler.params_list[idx].request_id)

    # with pd.option_context('display.max_rows', None, 'display.max_columns', None):
    #     # Do not truncate columns
    #     print("sanitized_df")
    #     print(sanitizer.sanitized_df)

    # db_sanitizer = dbSanitizer(raw_df = sanitizer.sanitized_df, db = db)
    # db_sanitizer.prepare_for_db()

    # db_sanitizer.df_to_db.to_sql(con=db.conn,
    #                           name="results",
    #                           if_exists="append",
    #                           index=False)

    # print(db_sanitizer.df_to_db)
