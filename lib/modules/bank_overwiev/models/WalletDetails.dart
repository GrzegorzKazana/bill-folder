import 'package:flutter/material.dart';

import 'Expense.dart';
import 'Participant.dart';

@immutable
class WalletDetails {
  final List<Expense> expenses;
  final List<Participant> participants;
  WalletDetails({@required this.expenses, @required this.participants});

  WalletDetails.empty()
      : expenses = [],
        participants = [];

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
      participants: participants,
      expenses: expenses
          .map(
              (oldExpense) => oldExpense.id == expenseId ? expense : oldExpense)
          .toList(),
    );
  }

  WalletDetails addParticipant(Participant participant) {
    return WalletDetails(
        expenses: expenses, participants: [...participants, participant]);
  }
}
