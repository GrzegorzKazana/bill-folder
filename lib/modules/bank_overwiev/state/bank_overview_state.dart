import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';

import '../services/expense_stats.dart';
import '../models/Wallet.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';
import '../models/Currency.dart';

import '_mocks.dart';

class BankOverviewState extends ChangeNotifier {
  final ExpenseStatsService _statsService;
  BankOverviewState(this._statsService);

  Wallet _currentWallet = mockWallets[1];
  List<Wallet> _wallets = mockWallets;
  List<Expense> _expenses = mockExpenses;
  List<Participant> _participants = mockParticipants;

  Wallet get currentWallet => _currentWallet;

  Currency get currentWalletCurrency =>
      _currentWallet?.currency ?? Currency.DOLLAR;

  UnmodifiableListView<Wallet> get wallets => UnmodifiableListView(_wallets);

  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_expenses);

  UnmodifiableListView<Participant> get participants =>
      UnmodifiableListView(_participants);

  UnmodifiableListView<ParticipantWithStats> get participantsWithStats =>
      UnmodifiableListView(
          _statsService.calculateStats(_expenses, _participants));

  Monetary get totalCostOfCurrentWallet => _currentWallet != null
      ? _statsService.sumExpenses(_expenses)
      : Monetary(unit: 0, cent: 0);

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

  void removeExpense(String expenseId) {
    _expenses = _expenses.where((e) => e.id != expenseId).toList();
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
