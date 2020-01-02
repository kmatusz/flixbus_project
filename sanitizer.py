import numpy as np
import pandas as pd
import re


class dfSanitizer:
    def __init__(self, df=None):
        self.df = df

#         self.sanitize_station_vec = np.vectorize(sanitize_station)

        def init_vectorised_funs(self):
            self.sanitize_price_vec = np.vectorize(sanitize_price)
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
