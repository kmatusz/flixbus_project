from crawl import Crawler
from parse import find_all_safely
import pandas as pd
import numpy as np
import os
from setup_db import DB, setup_db, cursor_as_df, execute_to_df
from sanitizer import dfSanitizer

SETUP_NEEDED = False
path = "test_db.db"

db = DB(path)

if SETUP_NEEDED:
    db.run_setup_scripts()


class ParamsHandler:
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
    def __init__(self, db, param):
        self.db = db
        self.param = param
        self.results_pd_raw = None
        self.results_pd = None
        super().__init__(param.params_for_crawler)

    def crawl(self):
        self.get_all()
        self.results_pd_raw = self.results_df

    def sanitize(self):
        pass


if __name__ == "__main__":
    print(db.show_tables())
    # print(db.select_all("jobs"))
    # print(db.select_all("requests"))
    params_handler = ParamsHandler(db)
    params_handler.obtain_params_from_db()
    # print(params_handler.values_in_db)
    # print(params_handler.params_list)

    # print(params_handler.get_params_for_crawler())

    a = SingleCrawlerWithDB(db, params_handler.params_list[1])
    a.crawl()
    # print(a.log)
    # print(a.results_pd_raw)

    sanitizer = dfSanitizer(df=a.results_pd_raw)
    sanitizer.sanitize_df()
    # sanitizer.prepare_for_db()
    sanitizer.insert_crawl_params(
        params_handler.params_list[0].variable_params, params_handler.params_list[0].request_id)
    sanitizer.prepare_for_db()
    df = sanitizer.df_to_db

    db._insert_from_data_frame("results", df)
    db.select_all("results")

    # more options can be specified also
    with pd.option_context('display.max_rows', None, 'display.max_columns', None):
        print(df)
    

    # print(params_list[0])
    # print(obtain_params_from_db(db))
