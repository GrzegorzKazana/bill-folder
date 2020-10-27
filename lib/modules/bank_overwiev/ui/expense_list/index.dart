import 'package:flutter/material.dart';

import 'add_payment_dialog.dart';
import 'expense_delete_confirm_dialog.dart';
import 'expense_list_item.dart';
import 'expense_list_filter_header.dart';

class ExpenseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  String _dropdownValue;
  List<String> _dropdownOptions = ['Odd', 'Even'];
  List<String> _expenses = List<String>.generate(50, (index) => 'Item #$index');

  List<String> _getFilteredExpenses(
      List<String> expenses, String dropDownValue) {
    switch (dropDownValue) {
      case 'Odd':
        return expenses
            .where((expense) => _expenses.indexOf(expense) % 2 == 1)
            .toList();
      case 'Even':
        return expenses
            .where((expense) => _expenses.indexOf(expense) % 2 == 0)
            .toList();
      default:
        return expenses;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final filteredExpenses = _getFilteredExpenses(_expenses, _dropdownValue);

    return Column(
      children: [
        ExpenseListFilterHeader(
            expenses: _expenses,
            filteredExpenses: _getFilteredExpenses(_expenses, _dropdownValue),
            dropdownValue: _dropdownValue,
            dropdownOptions: _dropdownOptions,
            onDropdownValueChange: (val) =>
                setState(() => _dropdownValue = val)),
        ListView(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: filteredExpenses
              .map((expense) => ExpenseListItem(
                    expense: expense,
                    onEditPayment: () => _showEditExpenseEditForm(context),
                    onConfirmDelete: () => _showConfirmDeleteDialog(context),
                  ))
              .toList(),
        )
      ],
    );
  }
}
