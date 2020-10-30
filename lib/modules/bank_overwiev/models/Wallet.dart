import 'package:nanoid/nanoid.dart';
import 'package:flutter/material.dart';

import 'Currency.dart';
import 'Expense.dart';
import 'Participant.dart';

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

@immutable
class WalletDetails {
  final List<Expense> expenses;
  final List<Participant> participants;
  WalletDetails({@required this.expenses, @required this.participants});

  WalletDetails addExpense(Expense expense) {
    return WalletDetails(
        expenses: [...expenses, expense], participants: participants);
  }

  WalletDetails removeExpense(String expenseId) {
    return WalletDetails(
        expenses: expenses.where((e) => e.id != expenseId).toList(),
        participants: participants);
  }

  WalletDetails updateExpense(String expenseId, Expense expense) {
    return WalletDetails(
        expenses: expenses
            .map((oldExpense) =>
                oldExpense.id == expenseId ? expense : oldExpense)
            .toList(),
        participants: participants);
  }

  WalletDetails addParticipant(Participant participant) {
    return WalletDetails(
        expenses: expenses, participants: [...participants, participant]);
  }
}
