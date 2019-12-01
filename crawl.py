from fetch import RequestSinglePage
from parse import Parser
import pandas as pd


class Crawler():
    def __init__(self, params):
        self.params = params
        self.log = {"fetching": None,
                    "crawling": None}
        self.results = None

    def get_all(self):
        request = RequestSinglePage(params=self.params)
        request.get()

        self.log["fetching"] = request.errors

        if not request.correctly_get:
            self.results = None
            return None

        parser = Parser(request.page_content)
        parser.extract_fields()
        self.results = parser.results
        self.log["crawling"] = parser._log

    def get_pandas_df(self):
        return pd.DataFrame(self.results)
