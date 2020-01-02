import sqlite3
import pandas as pd
import os

class DB:
    def __init__(self, db_path):
        self.db_path = db_path
        self.conn = sqlite3.connect(self.db_path)
        self.c = self.conn.cursor()
        path = "db/scripts/"
        self.setup_scripts_paths = ["export_schema_data.sql"]
        self.setup_scripts_paths = [path + i for i in self.setup_scripts_paths]
        
    def close(self):
        self.conn.close()
    
    def remove_db_file(self):
        self.close()
        os.remove(self.db_path)

    def run_setup_scripts(self):
        
        for path in self.setup_scripts_paths:
            with open(path, encoding = "UTF-8") as f:
                query = f.readlines()
                self.c.executescript(''.join(query))
                
                
    def show_tables(self):
        results = self.c.execute("select name from sqlite_master where type = 'table';")
        return results.fetchall()
    
    def select_all(self, table_name):
        results = self.c.execute("select * from {0};".format((table_name)))
        columns = [i[0] for i in self.c.description]
        df = pd.DataFrame(columns=columns, data=results.fetchall())
        return df
    
    def _insert_from_data_frame(self, table_name, df):
        df.to_sql(table_name, self.conn, if_exists = "append", index=False)
        
    def _load_initial_data_from_file(self, initial_data_path = "db/initial_data/initial_data.xlsx"):
        initial_data_path = "db/initial_data/initial_data.xlsx"
        sheets_names = ["users", "jobs", "requests", "distances", "cities"]
        
        xls = pd.ExcelFile(initial_data_path)

        self._initial_data = {i: None for i in sheets_names}
        for sheet_name in sheets_names:
            self._initial_data[sheet_name] = xls.parse(sheet_name)
    
    def insert_initial_data(self):
        self._load_initial_data_from_file()
        
        for table_name, data in self._initial_data.items():
            self._insert_from_data_frame(table_name, data)



def setup_db(path = "test_db.db"):
    db = DB(path)
    db.run_setup_scripts()
    db.insert_initial_data()
    return db

def cursor_as_df(c):
    columns = [i[0] for i in c.description]
    df = pd.DataFrame(columns=columns, data=c.fetchall())
    return df


def execute_to_df(cursor, query):
    cursor.execute(query)
    return cursor_as_df(cursor)
