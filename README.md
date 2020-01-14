#### Flixbus project

Flixbus.com is a page of a transport company that offers bus connection between big cities in Poland and Europe. It is known for reliable service and very interesting special pricing offers. Those promotions are extremely time-limited, so if the user wants to buy tickets cheaper, he/she needs to check the website daily. In this case, our project will be a useful tool, that allows to check connection and according prices automatically.

Our project is an advanced web-scraper of flixbus.com site. The purpose is to automatically download the data about trips between cities and at times that the app user is interested in. User will be able to define parameters of the search, and get the results in a form of a display table/xlsx download. This gives the end user ability to analyse the trends visible in the pricing of particular trip. This way user can also semi-automatically check whether the there is a drop in price and tickets are cheaper than usual (using the app user can run the scrapper for a given search parameters at any time). In the future releases the scrapper part of the app will be run periodically (e.g. once a day).

#### How to run:

To setup virtual environment type into anaconda prompt:
conda create --name flixbus_project --file requirements.txt
conda activate web_apps

And run the file webapp.py.

#### Files and folders description:

**Webapp part:**

- webapp.py - main file with website logic
- database_methods.py - functions for handling database connection and fetching tables
- views/ - contains templates for database
- resultFile/ - for saving temporary excel for download

**Scraper part:**

- crawler_usage.py - wrapper for scrapper for efficient working with the database
- crawl.py - one class for scraping - pass parameters and get pandas df
- fetch.py - make request to site and download raw html file
- parse.py - parse html to pandas dataframe
- setup_db.py - class for setup database object, add all tables and views and insert mock data 

**Misc:**

- db/ - folder containing the database and scripts to create one from scratch
- log.py - class for logging info about scraping
- tests/ - manual testing of various parts