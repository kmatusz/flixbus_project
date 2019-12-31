from bs4 import BeautifulSoup
from datetime import datetime
from collections import OrderedDict


def find_safely(x, *args, **kwargs):
    # Function as wrapper over requests.find
    # if there is more than one result, it returns none
    try:
        temp = x.find_all(*args, **kwargs)
        if temp is None:
            return None
        if len(temp) > 1:
            return None

        return temp[0]
    except:
        return None


def find_all_safely(x, *args, **kwargs):
    try:
        temp = x.find_all(*args, **kwargs)
        if temp is None or len(temp) == 0:
            return None
        return temp
    except:
        return None


class InitialParser():
    def __init__(self, page):
        self._raw_page = page
        self.exec_log = []
        self._stop_exec = False
        self._results_container = None

    def _convert_to_bs(self):
        try:
            self._bs_page = BeautifulSoup(self._raw_page, "html.parser")
        except:
            self._bs_page = None
            self._stop_exec = True

    def _find_results_container(self):
        results_container = find_safely(
            self._bs_page, "div", id="results-group-container-direct")

        if results_container is None:
            self._stop_exec = True
        else:
            self._results_container = results_container

    def _find_rows(self):

        rows = find_all_safely(self._results_container,
                               "div", class_="ride-available")

        if rows is None:
            self._stop_exec = True

        else:
            self.rows = rows

    def extract_rows(self):

        funs_list = [
            ("_convert_to_bs", self._convert_to_bs),
            ("_find_results_container", self._find_results_container),
            ("_find_rows", self._find_rows)
        ]

        for key, fun in funs_list:
            fun()
            if self._stop_exec:
                self.exec_log.append((key, "error"))
                self.rows = None
                break
            else:
                self.exec_log.append((key, "correct"))


class RowParser():
    def __init__(self, row):
        self._full_row = row
        self.extracted_content = {
            "departure_time": None,
            "arrival_time": None,
            "departure_station": None,
            "arrival_station": None,
            "price": None
        }
        self.fields_with_errors = []

    def _find_times(self):

        ride_times = find_all_safely(
            self._full_row, "div", class_="flix-connection__time")

        if ride_times is None:
            self.fields_with_errors.append(["departure_time", "arrival_time"])

        else:
            departure_time = ride_times[0]
            arrival_time = ride_times[1]

            if departure_time is None:
                self.fields_with_errors.append("departure_time")
            else:
                self.extracted_content["departure_time"] = departure_time.text.rstrip(
                ).lstrip()

            if arrival_time is None:
                self.fields_with_errors.append("arrival_time")
            else:
                self.extracted_content["arrival_time"] = arrival_time.text.rstrip(
                ).lstrip()

    def _find_stations(self):

        ride_stations = find_all_safely(
            self._full_row, "div", class_="station-name-label")

        if ride_stations is None:
            self.fields_with_errors.append(
                ["departure_station", "arrival_station"])

        else:
            departure_station = ride_stations[0]
            if departure_station is None:
                self.fields_with_errors.append("departure_station")
            else:
                self.extracted_content["departure_station"] = departure_station.text

            arrival_station = ride_stations[1]

            if arrival_station is None:
                self.fields_with_errors.append("arrival_station")
            else:
                self.extracted_content["arrival_station"] = arrival_station.text

    def _find_price(self):
        price = find_safely(self._full_row, "span",
                            class_="num currency-small-cents")

        if price is None:
            self.fields_with_errors.append("price")
        else:
            self.extracted_content["price"] = self._sanitize_price(price.text)

    def _sanitize_price(self, price_text):
        # Funkcja do doprowadzenia ceny do sensownego rezultatu

        return price_text.split("\xa0zł")[0].rstrip().lstrip()

    def extract_fields(self):
        funs_list = [
            self._find_times,
            self._find_stations,
            self._find_price
        ]

        for fun in funs_list:
            fun()


class Parser:
    def __init__(self, page):
        self._raw_page = page
        self._log = {}

    def extract_fields(self):
        parser = InitialParser(self._raw_page)
        parser.extract_rows()

        self._log["initial"] = parser.exec_log

        rows = parser.rows

        if rows is None:
            self._log["test_rows"] = ("There are no rows")
            self.results = []
            return None

        self._log["test_rows"] = ("Rows number", len(rows))
        self._log["rows_parsing_errors"] = []

        self.results = []
        for idx, row in enumerate(rows):

            single_row = RowParser(row)

            single_row.extract_fields()

            self.results.append(single_row.extracted_content)

            if len(single_row.fields_with_errors) > 0:
                self._log["rows_parsing_errors"].append(
                    ("Row {0}".format(idx), single_row.fields_with_errors))
