import 'package:nanoid/nanoid.dart';
import 'package:flutter/material.dart';

import 'Currency.dart';

@immutable
class Wallet {
  final String id;
  final String name;
  final Currency currency;

  static final String idField = '_id';
  static final String nameField = 'name';
  static final String currencyField = 'currency';

  Wallet({
    @required this.name,
    @required this.currency,
    String id,
  }) : id = id ?? nanoid();

  Wallet.fromMap(Map<String, dynamic> data)
      : id = data[idField],
        name = data[nameField],
        currency = stringToCurrency(data[currencyField]);

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      nameField: name,
      currencyField: currencyToString(currency),
    };
  }
}
