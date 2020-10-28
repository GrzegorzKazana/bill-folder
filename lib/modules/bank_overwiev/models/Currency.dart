import 'package:bill_folder/common/utils/enum_from_string.dart';

enum Currency {
  DOLLAR,
  EURO,
  POUND,
  PLN,
}

String formatCurrency(Currency currency) {
  switch (currency) {
    case Currency.DOLLAR:
      return '\$';

    case Currency.EURO:
      return '€';

    case Currency.POUND:
      return '£';

    case Currency.PLN:
      return 'PLN';
  }

  return '';
}

String formatCurrencyValue(String value) {
  return formatCurrency(stringToCurrency(value));
}

final currencyToString = createEnumToString(Currency.values);
final stringToCurrency = createEnumFromString(Currency.values);
