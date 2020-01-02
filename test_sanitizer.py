from sanitizer import dfSanitizer
import unittest


class TestSum(unittest.TestCase):

    def test_sanitize_price_correct(self):
        a = dfSanitizer()
        sanitize_price = a.sanitize_price

        test_cases = [
            ("65,94", 65.94),
            ("65,a94", 65.94),
            ("65,94    ", 65.94),
            ("54,", 54),
            (",54", 0.54)
        ]

        for insert, expected in test_cases:

            self.assertEqual(sanitize_price(
                insert), expected, "Test correct")

    def test_sanitize_price_none(self):
        a = dfSanitizer()
        sanitize_price = a.sanitize_price

        test_cases = [None, "45,34,5", 43]

        for insert in test_cases:

            self.assertIsNone(sanitize_price(
                insert), "Test none")


if __name__ == '__main__':
    unittest.main()


a = dfSanitizer()
sanitize_price = a.sanitize_price

print(sanitize_price("65,94") == 65.94)
print(sanitize_price("65,a94") == 65.94)
print(sanitize_price("65,a94   ") == 65.94)
print(sanitize_price("65,56,4") is None)
print(sanitize_price(None) is None)
print(sanitize_price("54,") == 54.0)
print(sanitize_price(",54") == 0.54)
print(sanitize_price(43) is None)
