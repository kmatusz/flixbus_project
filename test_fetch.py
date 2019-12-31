import unittest
from fetch import RequestSinglePage


class TestFetch(unittest.TestCase):

    def test_correct(self):
        search_params = {
            "departureCity": "7568",
            "arrivalCity": "1915",
            "rideDate": "20.11.2021",
            "adult": "1",
            "_locale": "pl"
        }
        a = RequestSinglePage(params=search_params)
        a.get()

        self.assertTrue(a.correctly_get, "Test if Something went wrong")

    def test_wrong_address(self):
        search_params = {
            "departureCity": "7568",
            "arrivalCity": "1915",
            "rideDate": "20.11.2021",
            "adult": "1",
            "_locale": "pl"
        }
        a = RequestSinglePage(params=search_params,
                              base_url="https://shop.flixbus.pl/se2222arch?")
        a.get()

        self.assertFalse(a.correctly_get, "Test if Something went wrong")


if __name__ == '__main__':
    unittest.main()
