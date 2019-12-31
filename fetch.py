from datetime import datetime
from requests import get
from requests.exceptions import RequestException
from bs4 import BeautifulSoup


class RequestSinglePage():

    def __init__(self, params, base_url="https://shop.flixbus.pl/search?"):
        self.params = params
        self.time_start = None
        self.time_end = None
        self.base_url = base_url
        self.errors = []

    def get(self):

        self.time_start = datetime.now()
        try:
            self._resp = get(self.base_url, params=self.params)
            self.time_end = datetime.now()
            if self._is_good_response(self._resp):
                self.correctly_get = True
                self.page_content = self._resp.content
            else:
                self._log_error("Wrong response code", self._resp.status_code)
                self.page_content = None

        except RequestException as e:
            self._log_error("Error during request")
            return None

    def _is_good_response(self, resp):
        """
        Returns True if the response seems to be HTML, False otherwise.
        """
        content_type = resp.headers['Content-Type'].lower()
        return (resp.status_code == 200
                and content_type is not None
                and content_type.find('html') > -1)

    def _log_error(self, *args):
        """
        It is always a good idea to log errors.
        This function just prints them, but you can
        make it do anything.
        """
        self.errors.append([*args])
        self.correctly_get = False


if __name__ == "__main__":

    search_params = {
        "departureCity": "7568",
        "arrivalCity": "1915",
        "rideDate": "20.11.2021",
        "adult": "1",
        "_locale": "pl"
    }
    print("Test w dobrym przypadku")
    a = RequestSinglePage(params=search_params)
    a.get()
    print(a._resp.url)
    print(len(a.page_content))
    print(a.correctly_get)
