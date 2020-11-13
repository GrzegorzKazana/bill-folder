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
  final String photo;

  static final String idField = '_id';
  static final String payerIdField = 'payerId';
  static final String priceField = 'price';
  static final String dateField = 'date';
  static final String tagsField = 'tags';
  static final String photoField = 'photo';

  Expense(
      {@required this.payerId,
      @required this.price,
      @required this.date,
      @required this.tags,
      @required this.photo,
      String id})
      : id = id ?? nanoid();

  Expense.fromMap(Map<String, dynamic> data)
      : id = data[idField],
        payerId = data[payerIdField],
        price = Monetary.fromString(data[priceField]),
        date = DateTime.parse(data[dateField]),
        photo = data[photoField],
        tags = List<String>.from(data[tagsField].split(','))
            .map(stringToExpenseTag)
            .toList();

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      payerIdField: payerId,
      priceField: price.toString(),
      dateField: date.toIso8601String(),
      tagsField: tags.map(expenseTagToString).toList().join(','),
      photoField: photo,
    };
  }

  Expense copyWith(
      {String payerId,
      Monetary price,
      DateTime date,
      List<ExpenseTag> tags,
      String photo}) {
    return Expense(
        id: this.id,
        payerId: payerId ?? this.payerId,
        price: price ?? this.price,
        date: date ?? this.date,
        tags: tags ?? this.tags,
        photo: photo ?? this.photo);
  }
}
