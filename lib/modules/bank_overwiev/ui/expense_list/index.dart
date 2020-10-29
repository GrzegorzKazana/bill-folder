import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'add_payment_dialog.dart';
import 'expense_delete_confirm_dialog.dart';
import 'expense_list_item.dart';
import 'expense_list_filter_header.dart';

import '../../models/Expense.dart';
import '../../models/Participant.dart';
import '../../models/Currency.dart';
import '../../state/bank_overview_state.dart';

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
          walletCurrency: _walletCurrency,
          participants: _participants,
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
          children: filteredExpenses.map((expense) {
            final payer = _getParticipantById(expense.payerId, _participants);

            return ExpenseListItem(
              expense: expense,
              walletCurrency: _walletCurrency,
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
