from datetime import datetime
from requests import get
from requests.exceptions import RequestException
from bs4 import BeautifulSoup
from log import Log
import pickle


class RequestSinglePage():

    def __init__(self, params, base_url="https://shop.flixbus.pl/search?"):
        self.params = params
        self.base_url = base_url
        self.log = Log(context="Request single page")

    def get(self):
        self.log.start()
        try:
            self._resp = get(self.base_url, params=self.params)

            if self._is_good_response(self._resp):
                self.page_content = self._resp.content

                self.log.end_successfully("Correctly get")
            else:
                self.page_content = None
                self.log.end_with_error(
                    f"Wrong response code: {self._resp.status_code}")

        except RequestException as e:
            self.log.end_with_error(f"Error during request. Error: {e}")

    def _is_good_response(self, resp):
        """
        Returns True if the response seems to be HTML, False otherwise.
        """
        content_type = resp.headers['Content-Type'].lower()
        return (resp.status_code == 200
                and content_type is not None
                and content_type.find('html') > -1)

    def dump_to_pickle(self, path = "tests/page.pkl"):
        
        with open(path,'wb') as file:
            pickle.dump(self.page_content, file)

if __name__ == "__main__":

    print("Correct case test")
    search_params = {
        "departureCity": "7568",
        "arrivalCity": "1915",
        "rideDate": "20.06.2020",
        "adult": "1",
        "_locale": "pl"
    }
    a = RequestSinglePage(params=search_params)
    a.get()
    print(a.log.successful)
    a.dump_to_pickle()

    print("Wrong parameters case test")
    search_params = {
        "departureCity": "7568",
        "arrivalCity": "1915",
        "rideDate": "20.11.2001",
        "adult": "1",
        "_locale": "pl"
    }
    a = RequestSinglePage(params=search_params)
    a.get()
    print(a.log.successful)

    print("Wrong url case test")
    search_params = {
        "departureCity": "7568",
        "arrivalCity": "1915",
        "rideDate": "20.11.2021",
        "adult": "1",
        "_locale": "pl"
    }
    a = RequestSinglePage(params=search_params, base_url="https://shop.flixbus.pl/search333?")
    a.get()
    # print(a._resp.url)
    print(a.log.successful)

