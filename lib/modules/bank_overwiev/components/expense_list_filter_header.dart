import 'package:flutter/material.dart';

import './expense_list_filter_button.dart';

class ExpenseListFilterHeader extends StatelessWidget {
  final List<String> expenses;
  final List<String> filteredExpenses;

  final String dropdownValue;
  final List<String> dropdownOptions;
  final void Function(String) onDropdownValueChange;

  ExpenseListFilterHeader({
    @required this.expenses,
    @required this.filteredExpenses,
    @required this.dropdownValue,
    @required this.dropdownOptions,
    @required this.onDropdownValueChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  '${filteredExpenses.length} out of ${expenses.length}',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ExpenseListFilterButton(
                value: dropdownValue,
                options: dropdownOptions,
                onValueChange: onDropdownValueChange,
              ),
            )
          ],
        ));
  }
}
