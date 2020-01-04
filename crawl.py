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

        self.log["fetching"] = self._request.log

        if not self._request.log.successful:
            self.results = None
            return None

        self._parser = Parser(self._request.page_content)
        self._parser.extract_fields()
        self.results = self._parser.results
        self.log["crawling"] = self._parser._log
        self.results_df = pd.DataFrame(self.results)

    def get_pandas_df(self):
        return self.results_df


if __name__ == "__main__":
    search_params = {
        "departureCity": "7568",
        "arrivalCity": "1915",
        "rideDate": "20.06.2020",
        "adult": "1",
        "_locale": "pl"
    }
    crawler = Crawler(search_params)
    crawler.get_all()
    print(crawler._request._resp.url)

    print(crawler.results)
    print(crawler.log)
