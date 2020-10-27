import 'package:nanoid/nanoid.dart';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';

import 'ExpenseTag.dart';

@immutable
class Expense {
  final String id;
  final String payerId;
  final Monetary price;
  final DateTime date;
  final List<ExpenseTag> tags;

  Expense(
      {@required this.payerId,
      @required this.price,
      @required this.date,
      @required this.tags,
      String id})
      : id = id ?? nanoid();

  Expense copyWith(
      {String payerId, Monetary price, DateTime date, List<ExpenseTag> tags}) {
    return Expense(
        id: this.id,
        payerId: payerId ?? this.payerId,
        price: price ?? this.price,
        date: date ?? this.date,
        tags: tags ?? this.tags);
  }
}
