import 'dart:math';
import 'package:flutter/material.dart';

import '../models/Wallet.dart';
import '../models/Expense.dart';
import '../models/ExpenseTag.dart';
import '../models/Participant.dart';
import '../models/Currency.dart';

import 'package:bill_folder/common/models/monetary.dart';

final rnd = Random();

DateTime randomReasonableDate() {
  return DateTime.now().subtract(Duration(days: rnd.nextInt(1000)));
}

Monetary randomMonetary() {
  return Monetary(unit: rnd.nextInt(99), cent: rnd.nextInt(99));
}

List<ExpenseTag> randomTags() {
  final numberOfTagsToSelect = rnd.nextInt(3);
  final numberOfTags = ExpenseTag.values.length;
  final tags = List<ExpenseTag>.generate(numberOfTagsToSelect,
      (_) => ExpenseTag.values[rnd.nextInt(numberOfTags - 1)]);

  return Set<ExpenseTag>.from(tags).toList();
}

Participant randomParticipant(List<Participant> participants) {
  return participants[rnd.nextInt(participants.length - 1)];
}

Stats randomStats() {
  return Stats(
      debt: randomMonetary(),
      moneySpent: randomMonetary(),
      lastPaymentDate: randomReasonableDate(),
      numberOfPayments: rnd.nextInt(10));
}

final mockWallets = [
  Wallet(name: 'Test wallet 1', currency: Currency.DOLLAR),
  Wallet(name: 'Another wallet', currency: Currency.POUND),
];

final mockParticipants = [
  Participant(name: 'John Doe', avatarColor: Colors.amber),
  Participant(name: 'Jan Kowalski', avatarColor: Colors.blue),
  Participant(name: 'Karen Smith', avatarColor: Colors.pink),
  Participant(name: 'Liam Williams', avatarColor: Colors.yellow),
  Participant(name: 'Alice Jones', avatarColor: Colors.red),
];

final mockExpenses = List.generate(
    10,
    (_) => Expense(
        payerId: randomParticipant(mockParticipants).id,
        price: randomMonetary(),
        date: randomReasonableDate(),
        tags: randomTags()));
