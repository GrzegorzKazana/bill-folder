enum Currency {
  DOLLAR,
  EURO,
  POUND,
  PLN,
}

String currencyToString(Currency currency) {
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
