import 'package:flutter/material.dart';

import 'add_payment_dialog.dart';
import 'expense_delete_confirm_dialog.dart';
import 'expense_list_item.dart';
import 'expense_list_filter_header.dart';

import '../../models/Expense.dart';
import '../../models/Participant.dart';
import '../../models/Currency.dart';

class ExpenseList extends StatefulWidget {
  final List<Expense> expenses;
  final List<Participant> participants;
  final Currency walletCurrency;

  ExpenseList({
    @required this.expenses,
    @required this.participants,
    @required this.walletCurrency,
  });

  @override
  State<StatefulWidget> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  Participant _selectedParticipant;

  List<Expense> get _expenses => widget.expenses;
  List<Participant> get _participants => widget.participants;
  Currency get _walletCurrency => widget.walletCurrency;

  Future<void> _showConfirmDeleteDialog(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        child: ExpenseDeleteConfirmDialog());
  }

  Future<void> _showEditExpenseEditForm(BuildContext context) async {
    showDialog(
        context: context, child: AddPaymentDialog(title: 'Edit payment'));
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

  @override
  Widget build(BuildContext context) {
    final filteredExpenses =
        _getFilteredExpenses(_selectedParticipant, _expenses);

    return Column(
      children: [
        ExpenseListFilterHeader(
            numberOfAllExpenses: _expenses.length,
            numberOfFilteredExpenses: filteredExpenses.length,
            selectedParticipant: _selectedParticipant,
            allParticipants: _participants,
            onParticipantChange: (val) =>
                setState(() => _selectedParticipant = val)),
        ListView(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: filteredExpenses
              .map((expense) => ExpenseListItem(
                    expense: expense,
                    walletCurrency: _walletCurrency,
                    payer: _getParticipantById(expense.payerId, _participants),
                    onEditPayment: () => _showEditExpenseEditForm(context),
                    onConfirmDelete: () => _showConfirmDeleteDialog(context),
                  ))
              .toList(),
        )
      ],
    );
  }
}
