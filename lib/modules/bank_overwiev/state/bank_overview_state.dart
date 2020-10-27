import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';

import '../models/Wallet.dart';
import '../models/Expense.dart';
import '../models/ExpenseTag.dart';
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

  void addWallet({@required String name}) {
    if (_currentWallet == null) return;

    final wallet = Wallet(name: name, currency: _currentWallet.currency);

    _wallets.add(wallet);
    notifyListeners();
  }

  void addExpense(
      {@required String payerId,
      @required Monetary price,
      @required DateTime date,
      @required List<ExpenseTag> tags}) {
    final expense =
        Expense(payerId: payerId, price: price, date: date, tags: tags);

    _expenses.add(expense);
    notifyListeners();
  }

  void addParticipant({@required String name, @required Color avatarColor}) {
    final participant = Participant(name: name, avatarColor: avatarColor);

    _participants.add(participant);
    notifyListeners();
  }

  void updateExpense(String expenseId,
      {String payerId, Monetary price, DateTime date, List<ExpenseTag> tags}) {
    _expenses = _expenses.map((oldExpense) {
      if (oldExpense.id != expenseId) return oldExpense;

      return oldExpense.copyWith(
          payerId: payerId, price: price, date: date, tags: tags);
    }).toList();
    notifyListeners();
  }
}
