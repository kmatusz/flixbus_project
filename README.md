#### Flixbus project

To setup virtual environment:
conda create --name web_apps --file requirements.txt
conda activate web_apps

Files:

- *crawl.py* - one class for scraping - pass parameters and get pandas df
- fetch.py - make request to site and download raw html file
- parse.py - parse html to dataframe
- manual_tests.py
- setup_db.py - class for setup database object, add all tables and views and insert mock data 
- *setup_db_testing.ipynb* - test database creation and insertion
- multiple_params_crawl_tests.ipynb
- db_crawler_integration.ipynb - test getting parameters from the database and passing to crawler 