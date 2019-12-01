
# coding: utf-8

# In[1]:


from datetime import datetime
from requests import get 
from requests.exceptions import RequestException
class SinglePage():
    def __init__(self, params, url = "https://shop.flixbus.pl/search?"):
        self.params = params
        self.time_start = None
        self.time_end = None
        self.url = url
        self.errors = []
    def get(self):
        
        self.time_start = datetime.now()
        try:
            self._resp = get(self.url, params=self.params)
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
        self.errors.append(*args)
        self.correctly_get = False
        

    


# In[2]:


search_params = {
"departureCity": "7568",
"arrivalCity": "1915",
"route": "Warszawa-Kraków",
"rideDate": "20.11.2019",
"adult": "1",
"_locale": "pl",
}
a = SinglePage(params=search_params)


# In[3]:


a.get()


# In[4]:


a.page_content


# In[5]:


from fetch import SinglePage
search_params = {
"departureCity": "7568",
"arrivalCity": "1915",
"route": "Warszawa-Kraków",
"rideDate": "20.11.2019",
"adult": "1",
"_locale": "pl",
}
a = SinglePage(params=search_params)
a.get()
page = a.page_content


# In[6]:


from bs4 import BeautifulSoup


# In[7]:


site = BeautifulSoup(page, "html.parser")


# In[8]:


def find_safely(x, *args, **kwargs):
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


# In[9]:


class PageParser():
    def __init__(self, page):
        self._raw_page = page
        self._exec_log = []
        self._stop_exec = False
    
    def _convert_to_bs(self):
        try:
            self._bs_page = BeautifulSoup(self._raw_page, "html.parser")
        except: 
            self._bs_page = None
            self._stop_exec = True
        
    def _find_results_container(self):
        results_container = find_safely(self._bs_page, "div", id = "results-group-container-direct")
        
        if results_container is None:
            self._stop_exec = True
        else:
            self._results_container = results_container
    
    def _find_rows(self):
        rows = find_all_safely(self._results_container, "div", class_ = "ride-available")
        
        if rows is None:
            self._stop_exec = True
        
        else:
            self.rows = rows
    
    def extract_rows(self):
        
        funs_list = [
        self._convert_to_bs,
        self._find_results_container,
        self._find_rows,
        ]
        
        for fun in funs_list:
            fun()
            
            if self._stop_exec:
                self.rows = None 
                break
        
        return self.rows


# In[10]:


a = PageParser(page)


# In[11]:


rows = a.extract_rows()


# In[12]:


class Row():
    def __init__(self, row):
        self._full_row = row
        self._stop_exec = False
        self.extracted_content = {
            "departure_time": None,
            "arrival_time": None,
            "departure_station": None,
            "arrival_station": None,
            "price": None
        }
        self.fields_with_errors = []
        
    def _find_times(self):
        
        ride_times = find_safely(self._full_row, "div", class_ = "ride-times")
        
        if ride_times is None:
            self.fields_with_errors.append("departure_time", "arrival_time")
        
        else:
            departure_time = find_safely(ride_times, "div", class_ = "departure")
            arrival_time = find_safely(ride_times, "div", class_ = "arrival")
            
            if departure_time is None:
                self.fields_with_errors.append("departure_time")
            else:
                self.extracted_content["departure_time"] = departure_time.text
            
            if arrival_time is None:
                self.fields_with_errors.append("arrival_time")
            else:
                self.extracted_content["arrival_time"] = arrival_time.text
                
                
    def _find_stations(self):

            ride_stations = find_safely(self._full_row, "div", class_ = "ride-station-names")

            if ride_stations is None:
                self.fields_with_errors.append("departure_station", "arrival_station")

            else:
                departure_station = find_safely(ride_stations, "div", class_ = "departure-station-name")
                if departure_station is None:
                    self.fields_with_errors.append("departure_station")
                else:
                    self.extracted_content["departure_station"] = departure_station.text

                    
                arrival_station = find_safely(ride_stations, "div", class_ = "arrival-station-name")
                
                if arrival_station is None:
                    self.fields_with_errors.append("arrival_station")
                else:
                    self.extracted_content["arrival_station"] = arrival_station.text

    def _find_price(self):
        price = find_safely(self._full_row, "span", class_ = "num currency-small-cents")
        
        if price is None:
            self.fields_with_errors.append("price")
        else:
            self.extracted_content["price"] = self._sanitize_price(price.text)
            
    def _sanitize_price(self, price_text):
        # Funkcja do doprowadzenia ceny do sensownego rezultatu

        return price_text.split("\xa0zł")[0]
            
    def extract_fields(self):
        funs_list = [
            self._find_times,
            self._find_stations,
            self._find_price
        ]
        
        for fun in funs_list:
            fun()
        


# In[13]:


single_row = Row(rows[0])
single_row._find_times()
single_row._find_stations()
single_row._find_price()


# In[14]:


single_row.extracted_content


# In[15]:


single_row = Row(rows[0])

single_row.extract_fields()
single_row.extracted_content


# In[16]:


results = []
for i in rows:
    single_row = Row(i)

    single_row.extract_fields()
    results.append(single_row.extracted_content)
results


# Jeżeli zwraca coś innego niż none to podaj dalej
# Jeżeli zwraca none to zatrzymaj wykonanie

# - weź stronę
# - przekształć do BS
# - wyciągnij stronę
# - wyciągnij rows
# - dla każdego row
# - wyciągnij elementy które potrzeba
# - agreguj do data frama
# 

# Testy:
# - Zwykła strona (tak jak wyżej)
# - Error 404
# - Rezultaty z kolejnego dnia
# - Brak miejsc
# - Brak jazd w danym dniu
