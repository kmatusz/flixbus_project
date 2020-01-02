import numpy as np
import pandas as pd
import re
from datetime import datetime


class dfSanitizer:
    def __init__(self, df=None):
        self.df = df
        self.sanitized_df = None
        self.init_vectorised_funs()
        self.df_to_db = None

#         self.sanitize_station_vec = np.vectorize(sanitize_station)

    def init_vectorised_funs(self):

        self.sanitize_station_vec = np.vectorize(self.sanitize_station)
        self.sanitize_price_vec = np.vectorize(self.sanitize_price)
        self.sanitize_time_vec = np.vectorize(self.sanitize_time)
#         self.sanitize_time_vec = np.vectorize(sanitize_time)

    def sanitize_price(self, x):
        if x is None:
            return None

        try:

            # remove all characters except numbers and commas
            stripped = re.sub("[^\d\,]", "", x)

            if len(stripped) > 10:
                return None

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

    def sanitize_df(self):
        self.sanitized_df = self.df.copy()
        self.sanitized_df.price = self.sanitize_price_vec(
            self.sanitized_df.price)
        self.sanitized_df.departure_station = self.sanitize_station_vec(
            self.sanitized_df.departure_station)
        self.sanitized_df.arrival_station = self.sanitize_station_vec(
            self.sanitized_df.arrival_station)
        self.sanitized_df.departure_time = self.sanitize_time_vec(
            self.sanitized_df.departure_time)
        self.sanitized_df.arrival_time = self.sanitize_time_vec(
            self.sanitized_df.arrival_time)
        self.sanitized_df["fully_booked"] = self.sanitized_df.price.isna()

    def insert_crawl_params(self, params, request_id):
        self.sanitized_df["departure_city"] = params["departureCity"]
        self.sanitized_df["arrival_city"] = params["arrivalCity"]
        self.sanitized_df["request_id"] = request_id
        self.sanitized_df["rideDate"] = params["rideDate"]
        self.sanitized_df["departure_datetime"] = self.sanitized_df.rideDate + \
            " " + self.sanitized_df.departure_time
        self.sanitized_df["departure_datetime"] = pd.to_datetime(
            self.sanitized_df["departure_datetime"])
        self.sanitized_df["arrival_datetime"] = self.sanitized_df.rideDate + \
            " " + self.sanitized_df.arrival_time
        self.sanitized_df["arrival_datetime"] = pd.to_datetime(
            self.sanitized_df["arrival_datetime"])
        self.sanitized_df["time_created"] = datetime.now()
        self.sanitized_df["changes_number"] = np.nan

        mask = self.sanitized_df["arrival_datetime"] < self.sanitized_df["departure_datetime"]
        masked_df = self.sanitized_df[mask]
        self.sanitized_df.loc[mask,
                              "arrival_datetime"] = masked_df.arrival_datetime + pd.DateOffset(days=1)

        self.sanitized_df["date"] = self.sanitized_df.departure_datetime.dt.date
        self.sanitized_df["time"] = self.sanitized_df.departure_datetime.dt.time
        self.sanitized_df["start_city"] = self.sanitized_df.departure_city
        self.sanitized_df["end_city"] = self.sanitized_df.arrival_city

    def prepare_for_db(self, simple_structure = True):

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
