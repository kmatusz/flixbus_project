from fetch import RequestSinglePage
from parse import InitialParser, RowParser, Parser
from bs4 import BeautifulSoup
from crawl import Crawler

search_params = {
    "departureCity": "7568",
    "arrivalCity": "1915",
    "rideDate": "02.01.2020",
    "adult": "1",
    "_locale": "pl",
}

print("Test w dobrym przypadku")
a = RequestSinglePage(params=search_params)
a.get()
print(len(a.page_content))
print(a.correctly_get)

parser = InitialParser(a.page_content)

print("--------Wyciąganie danych z 1 rezultatu--------------")
parser.extract_rows()
rows = parser.rows
print(f"Rows: {len(rows)}")

# print(parser)
single_row = RowParser(rows[0])
single_row.extract_fields()
print(single_row.fields_with_errors)
print("content:")
print(single_row.extracted_content)

