import 'package:flutter/material.dart';

class DropdownInput extends StatelessWidget {
  final String value;
  final List<String> possibleValues;
  final void Function(String) onValueChanged;
  final String Function(String) valueFormatter;
  final void Function() onTap;

  DropdownInput(
      {@required this.value,
      @required this.possibleValues,
      @required this.onValueChanged,
      this.valueFormatter,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        isExpanded: true,
        style: TextStyle(fontSize: 24, color: Colors.black),
        value: value,
        validator: (val) =>
            val == null || val.isEmpty ? 'Payer must be specified' : null,
        onChanged: onValueChanged,
        onTap: onTap,
        items: possibleValues
            .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Center(
                    child: Text(valueFormatter != null
                        ? valueFormatter(value)
                        : value))))
            .toList());
  }
}
