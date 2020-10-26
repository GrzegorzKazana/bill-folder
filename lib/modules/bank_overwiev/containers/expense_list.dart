import 'package:flutter/material.dart';

import '../components/expense_list_item.dart';

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

  @override
  Widget build(BuildContext context) {
    final filteredExpenses = _getFilteredExpenses(_expenses, _dropdownValue);

    return Column(
      children: [
        Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      '${filteredExpenses.length} out of ${_expenses.length}',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                        icon: Icon(Icons.filter_list_alt),
                        iconSize: 32,
                        style: TextStyle(fontSize: 24, color: Colors.black),
                        value: _dropdownValue,
                        onChanged: (newValue) =>
                            setState(() => _dropdownValue = newValue),
                        items: [
                          DropdownMenuItem<String>(
                              value: null, child: Text("All")),
                          ..._dropdownOptions
                              .map((value) => DropdownMenuItem<String>(
                                  value: value, child: Text(value)))
                              .toList()
                        ])),
              ],
            )),
        ListView(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: filteredExpenses
              .map((expense) => ExpenseListItem(expense: expense))
              .toList(),
        )
      ],
    );
  }
}
