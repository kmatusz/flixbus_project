from crawl import Crawler
from parse import find_all_safely
import pandas as pd
import numpy as np
import os
from setup_db import DB, setup_db, cursor_as_df, execute_to_df
from sanitizer import dfSanitizer


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

        self.parameters_from_db_query = '''SELECT 
        t2.request_id,
        strftime("%d.%m.%Y",t2.date) as rideDate,
        t2.start_city as departureCity,
        t2.end_city as arrivalCity
        FROM jobs as t1
        left join requests as t2 ON t1.job_id = t2.job_id
        WHERE t1.active = 1'''

    def obtain_params_from_db(self):
        params_from_db = self.db.c.execute(self.parameters_from_db_query)
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
    Class for crawling with single parameters (to remove?)
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


def run(db, idx):
    # Get parameters from db table (requests)
    params_handler = ParamsHandler(db)
    params_handler.obtain_params_from_db()

    # print(params_handler.values_in_db)
    # print(params_handler.params_list)
    # print(params_handler.get_params_for_crawler())
    print(idx)
    # Download the data
    crawler = SingleCrawlerWithDB(db, params_handler.params_list[idx])
    crawler.crawl()
    # print(crawler.log)
    # print(crawler.results_pd_raw)

    # Sanitize dataframe (remove wrong values, ensure correct format etc.)
    sanitizer = dfSanitizer(df=crawler.results_pd_raw)
    sanitizer.sanitize_df(
        params_handler.params_list[idx].variable_params, params_handler.params_list[idx].request_id)

    # Show sanitized df
    print(sanitizer.sanitized_df)

    # Commit crawling to the database table results
    sanitizer.prepare_for_db()
    df = sanitizer.df_to_db

    df.to_sql(con=db.conn,
              name="results",
              if_exists="append",
              index=False,
              dtype={
                  "request_id": "INT",
                  "time_created": "DATETIME",
                  "start_city": "INT",
                  "end_city": "INT",
                  "time": "INT",
                  "date": "DATE",
                  "price": "DOUBLE",
                  "changes_number": "INT"
              })

if __name__ == "__main__":

    path_to_db = "test_db.db"

    SETUP_NEEDED = True

    db = DB(path_to_db)

    if SETUP_NEEDED:
        db.run_setup_scripts()

    for i in range(15):
        run(db, i)

    # Check database working
    # print(db.show_tables())
    # print(db.select_all("jobs"))
    # print(db.select_all("results"))

    # Get parameters from db table (requests)
    params_handler = ParamsHandler(db)
    params_handler.obtain_params_from_db()

    # print(params_handler.values_in_db)
    # print(params_handler.params_list)
    # print(params_handler.get_params_for_crawler())
    idx = 0
    # Download the data
    crawler = SingleCrawlerWithDB(db, params_handler.params_list[idx])
    crawler.crawl()
    # print(crawler.log)
    # print(crawler.results_pd_raw)

    # Sanitize dataframe (remove wrong values, ensure correct format etc.)
    sanitizer = dfSanitizer(df=crawler.results_pd_raw)
    sanitizer.sanitize_df(
        params_handler.params_list[idx].variable_params, params_handler.params_list[idx].request_id)

    # Show sanitized df
    print(sanitizer.sanitized_df)

    # Commit crawling to the database table results
    sanitizer.prepare_for_db()
    df = sanitizer.df_to_db

    df.to_sql(con=db.conn,
              name="results",
              if_exists="append",
              index=False,
              dtype={
                  "request_id": "INT",
                  "time_created": "DATETIME",
                  "start_city": "INT",
                  "end_city": "INT",
                  "time": "INT",
                  "date": "DATE",
                  "price": "DOUBLE",
                  "changes_number": "INT"
              })

    # db._insert_from_data_frame("results", df)
    # db.select_all("results")

    with pd.option_context('display.max_rows', None, 'display.max_columns', None):
        # Do not truncate columns
        print(sanitizer.sanitized_df)
