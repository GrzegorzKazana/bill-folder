import 'dart:collection';

import 'package:bill_folder/common/state/async_state.dart';
import 'package:bill_folder/common/models/monetary.dart';

import '../services/expense_stats.dart';
import '../services/wallet_detail_repository.dart';
import '../models/WalletDetails.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';

class WalletDetailState extends AsyncState<WalletDetails> {
  final WalletDetailRepository repo;
  final ExpenseStatsService _statsService;
  WalletDetailState(this._statsService, this.repo)
      : super(WalletDetails.empty());

  String _currentWalletId;

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

    if (walletId == null) {
      dataLoaded(WalletDetails.empty());
      return;
    }

    initFetch();

    repo.getByWalletId(walletId).then(dataLoaded).catchError(requestError);
  }

  void addExpense(Expense expense) {
    repo.insertExpense(expense).then((_) {
      setData(data.addExpense(expense));
    }).catchError(requestError);
  }

  void removeExpense(String expenseId) {
    repo.deleteExpense(expenseId).then((_) {
      setData(data.removeExpense(expenseId));
    }).catchError(requestError);
  }

  void updateExpense(String expenseId, Expense expense) {
    repo.updateExpense(expense).then((_) {
      setData(data.updateExpense(expenseId, expense));
    }).catchError(requestError);
  }

  void addParticipant(Participant participant) {
    repo.insertParticipant(participant).then((_) {
      setData(data.addParticipant(participant));
    }).catchError(requestError);
  }
}
