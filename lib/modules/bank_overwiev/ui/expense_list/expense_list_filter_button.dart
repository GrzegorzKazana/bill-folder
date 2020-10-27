import 'package:flutter/material.dart';

class ExpenseListFilterButton extends StatelessWidget {
  final String value;
  final List<String> options;
  final void Function(String) onValueChange;

  ExpenseListFilterButton(
      {@required this.value,
      @required this.options,
      @required this.onValueChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        icon: Icon(Icons.filter_list_alt),
        iconSize: 32,
        style: TextStyle(fontSize: 24, color: Colors.black),
        value: value,
        onChanged: onValueChange,
        items: [
          DropdownMenuItem<String>(value: null, child: Text("All")),
          ...options
              .map((value) =>
                  DropdownMenuItem<String>(value: value, child: Text(value)))
              .toList()
        ]);
  }
}
