import 'package:flutter/material.dart';
import 'package:test/test.dart';

import 'package:bill_folder/common/models/monetary.dart';
import 'package:bill_folder/modules/bank_overwiev/services/expense_stats.dart';
import 'package:bill_folder/modules/bank_overwiev/models/Expense.dart';
import 'package:bill_folder/modules/bank_overwiev/models/Participant.dart';
import 'package:bill_folder/modules/bank_overwiev/state/_mocks.dart';

void main() {
  group('ExpenseStatsService', () {
    final service = ExpenseStatsService();

    List<Expense> fromPrices(List<Monetary> prices) {
      return prices
          .map((p) => Expense(
              payerId: '', date: randomReasonableDate(), tags: [], price: p))
          .toList();
    }

    test('it calculates total of all expenses', () {
      final expenses = fromPrices([
        Monetary(unit: 10, cent: 24),
        Monetary(unit: 2, cent: 1),
        Monetary(unit: 11, cent: 73),
        Monetary(unit: 0, cent: 99),
      ]);

      final result = service.sumExpenses(expenses);

      expect(result, equals(Monetary(unit: 24, cent: 97)));
    });

    test('it calculates stats correctly for single participant', () {
      final participant = Participant(name: 'test', avatarColor: Colors.red);
      final otherParticipantId = '111';
      final someOtherParticipantId = '222';
      final expenses = [
        Expense(
            payerId: participant.id,
            price: Monetary(unit: 10, cent: 24),
            date: DateTime(2018),
            tags: []),
        Expense(
            payerId: participant.id,
            price: Monetary(unit: 2, cent: 1),
            date: DateTime(2019),
            tags: []),
        Expense(
            payerId: otherParticipantId,
            price: Monetary(unit: 11, cent: 73),
            date: DateTime(2020),
            tags: []),
        Expense(
            payerId: someOtherParticipantId,
            price: Monetary(unit: 0, cent: 99),
            date: DateTime(2017),
            tags: []),
      ];

      final result =
          service.calculateStatsForParticipant(expenses, participant, 3);

      expect(result.stats.balance, equals(Monetary(unit: 3, cent: 93)));
      expect(result.stats.lastPaymentDate, equals(DateTime(2019)));
      expect(result.stats.moneySpent, equals(Monetary(unit: 12, cent: 25)));
      expect(result.stats.numberOfPayments, equals(2));
    });
  });
}
