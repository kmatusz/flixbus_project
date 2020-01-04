import numpy as np
import pandas as pd
import re
from datetime import datetime


class dfSanitizer:
    '''
    Class for cleaning up the obtained data and preparation to a format required by the database.
    '''

    def __init__(self, df=None):
        self.df = df
        self.sanitized_df = None
        self.init_vectorised_funs()
        self.df_to_db = None

#         self.sanitize_station_vec = np.vectorize(sanitize_station)

    def init_vectorised_funs(self):
        # Create vectorised version of function sanitizing each obtained column (type of data)
        self.sanitize_station_vec = np.vectorize(self.sanitize_station)
        self.sanitize_price_vec = np.vectorize(self.sanitize_price)
        self.sanitize_time_vec = np.vectorize(self.sanitize_time)

    def sanitize_price(self, x):
        if x is None:
            return None

        try:

            # remove all characters except numbers and commas
            stripped = re.sub("[^\d\,]", "", x)

            if len(stripped) > 10:
                return None

            # Convert to non-polish notation
            stripped_comma = stripped.replace(",", ".")

            number = float(stripped_comma)

        except:
            return None

        return number

    def sanitize_station(self, station):
        try:
            return station.lstrip().rstrip()
        except:
            return None

    def sanitize_time(self, x):
        if x is None:
            return None

        try:
            # remove all characters except numbers and commas
            stripped = re.sub("[^\d\:]", "", x)

            if len(stripped) != 5:
                return None

            if sum([i == ":" for i in stripped]) != 1:
                return None

        except:
            return None

        return stripped

    def sanitize_df(self, params, request_id):
        self.sanitized_df = self.df.copy()
        df = self.sanitized_df

        self.sanitize_initial_columns()
        self.handle_constant_columns(params, request_id)
        self.handle_dates()

        df["fully_booked"] = df.price.isna()

    def sanitize_initial_columns(self):
        df = self.sanitized_df

        df.price = self.sanitize_price_vec(df.price)

        df.departure_station = self.sanitize_station_vec(df.departure_station)
        df.arrival_station = self.sanitize_station_vec(df.arrival_station)

        df.departure_time = self.sanitize_time_vec(df.departure_time)
        df.arrival_time = self.sanitize_time_vec(df.arrival_time)

    def handle_constant_columns(self, params, request_id):
        df = self.sanitized_df

        df["departure_city"] = params["departureCity"]
        df["arrival_city"] = params["arrivalCity"]
        df["request_id"] = request_id
        df["rideDate"] = params["rideDate"]
        df["time_created"] = datetime.now()
        df["changes_number"] = np.nan
        df["start_city"] = df.departure_city
        df["end_city"] = df.arrival_city

    def handle_dates(self):
        df = self.sanitized_df

        df["departure_datetime"] = df.rideDate + " " + df.departure_time
        df["departure_datetime"] = pd.to_datetime(
            df["departure_datetime"], format='%d.%m.%Y %H:%M')
        df["arrival_datetime"] = df.rideDate + " " + df.arrival_time
        df["arrival_datetime"] = pd.to_datetime(
            df["arrival_datetime"], format='%d.%m.%Y %H:%M')

        # If arrival is earlier than departure,
        # shift arrival for 1 day (cases when travelling around 12 p.m.)
        mask = df["arrival_datetime"] < df["departure_datetime"]
        masked_df = df[mask]
        df.loc[mask, "arrival_datetime"] = masked_df.arrival_datetime + \
            pd.DateOffset(days=1)

        df["date"] = df.departure_datetime.dt.date
        df["time"] = df.departure_datetime.dt.time


class dbSanitizer:
    def __init__(self, raw_df, db):
        self.raw_df = raw_df
        self.db = db

    def prepare_for_db(self):
        self.df_to_db = self.raw_df.copy()
        self._select_columns()
        self._get_unique_stations()
        self._insert_new_stations_to_db()
        self._normalize_stations()

    def _select_columns(self):
        self.df_to_db = self.df_to_db[[
            "request_id",
            "time_created",
            "departure_city",
            "arrival_city",
            "departure_station",
            "arrival_station",
            "departure_datetime",
            "arrival_datetime",
            "price",
            "changes_number",
            "fully_booked"
        ]]

    def _get_unique_stations(self):
        self.unique_stations = set(self.df_to_db["departure_station"].tolist() +
                                   self.df_to_db["arrival_station"].tolist())
        return None

    def _insert_new_stations_to_db(self):

        for station_name in self.unique_stations:

            self.db.conn.cursor().execute('''
            INSERT OR IGNORE INTO STATIONS (
                            station_name
                            )
            VALUES
            (?)


            ''', (station_name, ))

    def _normalize_stations(self):
        # Replace name of the station (e.g. Kraków Główny) with station_id
        df_stations = pd.read_sql_query("SELECT * FROM stations",self.db.conn)
        df_stations_to_join = df_stations.set_index("station_name")


        # Replace arrival

        arrival_joined = self.df_to_db.join(df_stations_to_join, on = "arrival_station")
        arrival_joined = arrival_joined.drop("arrival_station", axis = 1)
        self.df_to_db = arrival_joined.rename({"station_id": "arrival_station"}, axis = 1)


        # Replace departure
        departure_joined = self.df_to_db.join(df_stations_to_join, on = "departure_station")
        departure_joined = departure_joined.drop("departure_station", axis = 1)
        self.df_to_db = departure_joined.rename({"station_id": "departure_station"}, axis = 1)
