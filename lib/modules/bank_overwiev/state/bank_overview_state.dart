import 'dart:collection';
import 'package:flutter/material.dart';

import '../models/Wallet.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';

class BankOverviewState extends ChangeNotifier {
  String hello = 'world';
  Wallet _currentWallet;
  List<Wallet> _wallets = [];
  List<Expense> _expenses = [];
  List<Participant> _participants = [];

  Wallet get currentWallet => _currentWallet;
  UnmodifiableListView<Wallet> get wallets => UnmodifiableListView(_wallets);
  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_expenses);
  UnmodifiableListView<Participant> get participants =>
      UnmodifiableListView(_participants);

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
}
