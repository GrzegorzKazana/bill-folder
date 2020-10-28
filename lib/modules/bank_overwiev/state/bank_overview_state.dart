import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';

import '../models/Wallet.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';

class BankOverviewState extends ChangeNotifier {
  Wallet _currentWallet;
  List<Wallet> _wallets = [];
  List<Expense> _expenses = [];
  List<Participant> _participants = [];

  Wallet get currentWallet => _currentWallet;
  UnmodifiableListView<Wallet> get wallets => UnmodifiableListView(_wallets);
  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_expenses);
  UnmodifiableListView<Participant> get participants =>
      UnmodifiableListView(_participants);
  UnmodifiableListView<ParticipantWithStats> get participantsWithStats =>
      UnmodifiableListView(_participants
          .map((participant) => ParticipantWithStats(
              info: participant, stats: _calculateStats(participant)))
          .toList());

  Monetary get totalCostOfCurrentWallet => Monetary(unit: 42, cent: 14);
  int get numberOfParticipants => _participants.length;

  void addWallet(Wallet wallet) {
    _wallets.add(wallet);
    _currentWallet = wallet;
    notifyListeners();
  }

  void switchToWallet(String walletId) {
    if (currentWallet.id == walletId) return;

    final wallet = _wallets.firstWhere((wallet) => wallet.id == walletId,
        orElse: () => null);

    if (wallet == null) return;

    _currentWallet = wallet;
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void addParticipant(Participant participant) {
    _participants.add(participant);
    notifyListeners();
  }

  void updateExpense(String expenseId, Expense expense) {
    _expenses = _expenses
        .map((oldExpense) => oldExpense.id == expenseId ? expense : oldExpense)
        .toList();

    notifyListeners();
  }

  Stats _calculateStats(Participant _) {
    return Stats(
        debt: Monetary(unit: 1, cent: 2),
        moneySpent: Monetary(unit: 2, cent: 3),
        lastPaymentDate: DateTime.now(),
        numberOfPayments: 4);
  }
}
