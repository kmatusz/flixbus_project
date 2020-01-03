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
        df["departure_datetime"] = pd.to_datetime(df["departure_datetime"], format='%d.%m.%Y %H:%M')
        df["arrival_datetime"] = df.rideDate + " " + df.arrival_time
        df["arrival_datetime"] = pd.to_datetime(df["arrival_datetime"], format='%d.%m.%Y %H:%M')

        # If arrival is earlier than departure, 
        # shift arrival for 1 day (cases when travelling around 12 p.m.)
        mask = df["arrival_datetime"] < df["departure_datetime"]
        masked_df = df[mask]
        df.loc[mask, "arrival_datetime"] = masked_df.arrival_datetime + \
            pd.DateOffset(days=1)

        df["date"] = df.departure_datetime.dt.date
        df["time"] = df.departure_datetime.dt.time


    def prepare_for_db(self, simple_structure=True):

        if not simple_structure:
            raise NotImplementedError

        self.df_to_db = self.sanitized_df.copy()
        self.df_to_db = self.df_to_db[[
            "request_id",
            "time_created",
            "start_city",
            "end_city",
            "time",
            "date",
            "price",
            "changes_number"
        ]]
