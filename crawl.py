from fetch import RequestSinglePage
from parse import Parser
import pandas as pd


class Crawler():
    def __init__(self, params):
        self.params = params
        self.log = {"fetching": None,
                    "crawling": None}
        self.results = None
        self._request = None
        self._parser = None

    def get_all(self):
        self._request = RequestSinglePage(params=self.params)
        self._request.get()

        self.log["fetching"] = self._request.errors

        if not self._request.correctly_get:
            self.results = None
            return None

        self._parser = Parser(self._request.page_content)
        self._parser.extract_fields()
        self.results = self._parser.results
        self.log["crawling"] = self._parser._log
        self.results_df = pd.DataFrame(self.results)

    def get_pandas_df(self):
        return self.results_df
