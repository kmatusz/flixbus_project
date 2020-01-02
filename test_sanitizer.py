from sanitizer import dfSanitizer
import unittest


# class TestSum(unittest.TestCase):

#     def test_sanitize_price_correct(self):
#         a = dfSanitizer()
#         sanitize_price = a.sanitize_price

#         test_cases = [
#             ("65,94", 65.94),
#             ("65,a94", 65.94),
#             ("65,94    ", 65.94),
#             ("54,", 54),
#             (",54", 0.54)
#         ]

#         for insert, expected in test_cases:

#             self.assertEqual(sanitize_price(
#                 insert), expected, "Test correct")

#     def test_sanitize_price_none(self):
#         a = dfSanitizer()
#         sanitize_price = a.sanitize_price

#         test_cases = [None, "45,34,5", 43]

#         for insert in test_cases:

#             self.assertIsNone(sanitize_price(
#                 insert), "Test none")


# if __name__ == '__main__':
#     unittest.main()


a = dfSanitizer()
sanitize_price = a.sanitize_price
sanitize_time = a.sanitize_time
sanitize_station = a.sanitize_station

print(sanitize_price("65,94") == 65.94)
print(sanitize_price("65,a94") == 65.94)
print(sanitize_price("65,a94   ") == 65.94)
print(sanitize_price("65,56,4") is None)
print(sanitize_price(None) is None)
print(sanitize_price("54,") == 54.0)
print(sanitize_price(",54") == 0.54)
print(sanitize_price(43) is None)


print(sanitize_time("09:50") == "09:50")
print(sanitize_time("09:50   ") == "09:50")
print(sanitize_time("09:50aa") == "09:50")
print(sanitize_time("9:50:") is None)
print(sanitize_time("950") is None)
print(sanitize_time(":") is None)
print(sanitize_time("9:50") is None)


print(sanitize_station("abc") == "abc")
print(sanitize_station("      abc") == "abc")
print(sanitize_station("abc   ") == "abc")
print(sanitize_station(1) is None)
print(sanitize_station(None) is None)



a.init_vectorised_funs()
