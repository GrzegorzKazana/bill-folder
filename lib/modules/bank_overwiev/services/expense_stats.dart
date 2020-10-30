import 'package:bill_folder/common/models/monetary.dart';

import '../models/Wallet.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';
import '../models/Currency.dart';

class ExpenseStatsService {
  Monetary sumExpenses(List<Expense> expenses) {
    return expenses.fold(Monetary.empty(), (sum, curr) => sum + curr.price);
  }

  ParticipantWithStats calculateStatsForParticipant(List<Expense> expenses,
      Participant participant, int numberOfParticipants) {
    final expensesByParticipant =
        expenses.where((e) => e.payerId == participant.id).toList();

    final total = this.sumExpenses(expenses);

    final moneySpent = this.sumExpenses(expensesByParticipant);

    final latestExpense = expensesByParticipant.isNotEmpty
        ? expensesByParticipant.reduce((a, b) => a.date.isAfter(b.date) ? a : b)
        : null;

    final balance = -((total ~/ numberOfParticipants) - moneySpent);

    return ParticipantWithStats(
        info: participant,
        stats: Stats(
          lastPaymentDate: latestExpense?.date,
          moneySpent: moneySpent,
          numberOfPayments: expensesByParticipant.length,
          balance: balance,
        ));
  }

  List<ParticipantWithStats> calculateStats(
      List<Expense> expenses, List<Participant> participants) {
    return participants
        .map((p) =>
            this.calculateStatsForParticipant(expenses, p, participants.length))
        .toList();
  }
}
