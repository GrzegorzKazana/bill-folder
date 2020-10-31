import 'dart:collection';

import 'package:bill_folder/common/state/async_state.dart';
import 'package:bill_folder/common/models/monetary.dart';

import '../services/expense_stats.dart';
import '../models/WalletDetails.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';

import '_mocks.dart';

class WalletDetailState extends AsyncState<WalletDetails> {
  String _currentWalletId;

  final ExpenseStatsService _statsService;
  WalletDetailState(this._statsService) : super(WalletDetails.empty());

  int get numberOfParticipants => data.participants.length;
  Monetary get totalCost => _statsService.sumExpenses(data.expenses);

  UnmodifiableListView<Expense> get expenses =>
      UnmodifiableListView(data.expenses);
  UnmodifiableListView<Participant> get participants =>
      UnmodifiableListView(data.participants);
  UnmodifiableListView<ParticipantWithStats> get participantsWithStats =>
      UnmodifiableListView(
          _statsService.calculateStats(data.expenses, data.participants));

  void loadDetails(String walletId) {
    if (_currentWalletId == walletId) return;
    _currentWalletId = walletId;

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
