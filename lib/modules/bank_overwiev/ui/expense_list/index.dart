import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/utils/immutable_sort.dart';

import 'add_payment_dialog.dart';
import 'expense_delete_confirm_dialog.dart';
import 'expense_list_item.dart';
import 'expense_list_filter_header.dart';

import '../../models/Expense.dart';
import '../../models/Participant.dart';
import '../../models/Currency.dart';
import '../../state/bank_overview_state.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final List<Participant> participants;
  final Participant selectedParticipant;
  final Currency walletCurrency;
  final void Function(Participant) onSelectedParticipantChange;

  ExpenseList({
    @required this.expenses,
    @required this.participants,
    @required this.walletCurrency,
    @required this.selectedParticipant,
    @required this.onSelectedParticipantChange,
  });

  Future<void> _showConfirmDeleteDialog(
      BuildContext context, String expenseId) async {
    final shouldDelete = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        child: ExpenseDeleteConfirmDialog());

    if (!shouldDelete) return;

    Provider.of<BankOverviewState>(context, listen: false)
        .removeExpense(expenseId);
  }

  Future<void> _showEditExpenseEditForm(BuildContext context,
      Participant initialPayer, Expense initialExpense) async {
    final data = await showDialog<Expense>(
        context: context,
        child: AddPaymentDialog(
          title: 'Edit payment',
          walletCurrency: walletCurrency,
          participants: participants,
          initialPayer: initialPayer,
          initialExpense: initialExpense,
        ));

    if (data == null) return;

    Provider.of<BankOverviewState>(context, listen: false)
        .updateExpense(initialExpense.id, data);
  }

  Participant _getParticipantById(String id, List<Participant> participants) {
    return participants.firstWhere((p) => p.id == id, orElse: () => null);
  }

  List<Expense> _getFilteredExpenses(
      Participant selectedParticipant, List<Expense> expenses) {
    return selectedParticipant != null
        ? expenses.where((e) => e.payerId == selectedParticipant.id).toList()
        : expenses;
  }

  List<Expense> _sortExpensesByDate(List<Expense> expenses) {
    return sort(expenses, (a, b) => a.date.isBefore(b.date));
  }

  @override
  Widget build(BuildContext context) {
    final filteredExpenses =
        _getFilteredExpenses(selectedParticipant, expenses);

    final sortedExpenses = _sortExpensesByDate(filteredExpenses);

    return Column(
      children: [
        ExpenseListFilterHeader(
            numberOfAllExpenses: expenses.length,
            numberOfFilteredExpenses: sortedExpenses.length,
            selectedParticipant: selectedParticipant,
            allParticipants: participants,
            onParticipantChange: onSelectedParticipantChange),
        ListView(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: sortedExpenses.map((expense) {
            final payer = _getParticipantById(expense.payerId, participants);

            return ExpenseListItem(
              expense: expense,
              walletCurrency: walletCurrency,
              payer: payer,
              onEditPayment: () => _showEditExpenseEditForm(
                context,
                payer,
                expense,
              ),
              onConfirmDelete: () =>
                  _showConfirmDeleteDialog(context, expense.id),
            );
          }).toList(),
        )
      ],
    );
  }
}
