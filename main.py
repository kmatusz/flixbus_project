from fetch import RequestSinglePage
from parse import InitialParser, RowParser, Parser
from bs4 import BeautifulSoup
from crawl import Crawler

search_params = {
    "departureCity": "7568",
    "arrivalCity": "1915",
    "rideDate": "22.11.2019",
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
print("aaa")
print(parser)
single_row = RowParser(rows[0])
single_row.extract_fields()
print(single_row.extracted_content)


print("--------Wyciąganie danych ze wszystkich rezultatów--------------")

results = []
for i in rows:
    single_row = RowParser(i)

    single_row.extract_fields()
    results.append(single_row.extracted_content)

print(results)
print(f"length of results: {len(results)}")


print("test nowej klasy")
parser_ = Parser(a.page_content)
parser_.extract_fields()
print(parser_.results)

print(parser_._log)

print("test master obiektu ")

crawler = Crawler(search_params)
crawler.get_all()

print(crawler.results)
print(crawler.log)
