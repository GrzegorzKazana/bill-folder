import 'package:nanoid/nanoid.dart';
import 'package:flutter/material.dart';

import 'Currency.dart';

@immutable
class Wallet {
  final String id;
  final String name;
  final Currency currency;

  Wallet({
    @required this.name,
    @required this.currency,
    String id,
  }) : id = id ?? nanoid();
}
