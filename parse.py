from bs4 import BeautifulSoup
from datetime import datetime
from collections import OrderedDict
from log import Log
import pickle


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
        self.log = Log(context="InitialParser")
        self._stop_exec = False
        self._results_container = None

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

    def _convert_to_bs(self):
        # Function converts raw page obtained using requests to beautifulsoup
        try:
            self._bs_page = BeautifulSoup(self._raw_page, "html.parser")
        except:
            self._bs_page = None
            self._stop_exec = True

    def _find_results_container(self):
        # Function finds css results container 
        # containing rows, each row is one ride
        results_container = find_safely(
            self._bs_page, "div", id="results-group-container-direct")

        if results_container is None:
            self._stop_exec = True
        else:
            self._results_container = results_container

    def _find_rows(self):
        # Function finds all rows in results container.
        rows = find_all_safely(self._results_container,
                               "div", class_="ride-available")

        if rows is None:
            self._stop_exec = True

        else:
            self.rows = rows


class RowParser():
    '''
    Class for parsing single row of results (single ride)
    '''

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

    def extract_fields(self):
        self._find_stop_times()
        self._find_stations()
        self._find_price()

    def _find_stop_times(self):

        ride_times = find_all_safely(
            self._full_row, "div", class_="flix-connection__time")

        if ride_times is not None:
            self._process_stop_time(ride_times[0], "departure_time")
            self._process_stop_time(ride_times[1], "arrival_time")
        else:
            self.fields_with_errors.append(["departure_time", "arrival_time"])

    def _process_stop_time(self, ride_time, time_type):
        if ride_time is not None:
            self.extracted_content[time_type] = ride_time.text.rstrip(
            ).lstrip()
        else:
            self.fields_with_errors.append(time_type)

    def _find_stations(self):

        ride_stations = find_all_safely(
            self._full_row, "div", class_="station-name-label")

        if ride_stations is not None:

            self._process_station(ride_stations[0], "departure_station")
            self._process_station(ride_stations[1], "arrival_station")

        else:
            self.fields_with_errors.append(
                ["departure_station", "arrival_station"])

    def _process_station(self, station, station_type):
        if station is not None:
            self.extracted_content[station_type] = station.text
        else:
            self.fields_with_errors.append(station_type)

    def _find_price(self):
        price = find_safely(self._full_row, "span",
                            class_="num currency-small-cents")

        if price is not None:
            self.extracted_content["price"] = self._process_price(price.text)
        else:
            self.fields_with_errors.append("price")

    def _process_price(self, price_text):

        return price_text.split("\xa0zł")[0].rstrip().lstrip()


class Parser:
    def __init__(self, page):
        self._raw_page = page
        self._log = {}
        self.log = Log(context="Parser")

    def extract_fields(self):
        self.log.start()
        initial_parser = InitialParser(self._raw_page)
        initial_parser.extract_rows()

        self._log["initial"] = initial_parser.exec_log

        rows = initial_parser.rows

        if rows is None:
            self._log["test_rows"] = ("There are no rows")
            self.results = None
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


if __name__ == "__main__":
    with open("tests/page.pkl", 'rb') as file:
        page_content = pickle.load(file)

    parser = Parser(page_content)
    parser.extract_fields()
    print(parser.results)
    print(parser.log)
