import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'participant_repository.dart';
import 'expense_repository.dart';
import '../models/WalletDetails.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';

@immutable
class WalletDetailRepository {
  final Database db;
  final ParticipantRepository participantRepo;
  final ExpenseRepository expenseRepo;

  WalletDetailRepository(this.db,
      {@required this.participantRepo, @required this.expenseRepo});

  Future<WalletDetails> getByWalletId(String walletId) async {
    return WalletDetails(
        expenses: await expenseRepo.getAllByWalletId(walletId),
        participants: await participantRepo.getByWalletId(walletId));
  }

  Future<Participant> insertParticipant(Participant participant) {
    return participantRepo.insert(participant);
  }

  Future<Expense> insertExpense(Expense expense) {
    return expenseRepo.insert(expense);
  }

  Future<Expense> update(Expense expense) {
    return expenseRepo.update(expense);
  }

  Future<String> deleteExpense(String expenseId) {
    return expenseRepo.delete(expenseId);
  }
}
