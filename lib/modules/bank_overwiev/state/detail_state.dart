import 'dart:collection';

import 'package:bill_folder/common/state/async_state.dart';
import 'package:bill_folder/common/models/monetary.dart';

import '../services/expense_stats.dart';
import '../models/Wallet.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';

import '_mocks.dart';

class WalletDetailState extends AsyncState<WalletDetails> {
  String _currentWalletId;
  final ExpenseStatsService _statsService;
  WalletDetailState(this._statsService);

  int get numberOfParticipants => data != null ? data.participants.length : 0;
  Monetary get totalCost => data != null
      ? _statsService.sumExpenses(data.expenses)
      : Monetary(unit: 0, cent: 0);

  UnmodifiableListView<Expense> get expenses =>
      data != null ? UnmodifiableListView(data.expenses) : [];
  UnmodifiableListView<Participant> get participants =>
      data != null ? UnmodifiableListView(data.participants) : [];
  UnmodifiableListView<ParticipantWithStats> get participantsWithStats =>
      data != null
          ? UnmodifiableListView(
              _statsService.calculateStats(data.expenses, data.participants))
          : [];

  void loadDetails(String walletId) {
    if (_currentWalletId == walletId) return;

    initFetch();
    Future.value(WalletDetails(
            expenses: mockExpenses, participants: mockParticipants))
        .then(dataLoaded)
        .catchError(requestError);
  }

  void addExpense(Expense expense) {
    setData(data.addExpense(expense));
  }

  void removeExpense(String expenseId) {
    setData(data.removeExpense(expenseId));
  }

  void updateExpense(String expenseId, Expense expense) {
    setData(data.updateExpense(expenseId, expense));
  }

  void addParticipant(Participant participant) {
    setData(data.addParticipant(participant));
  }
}
