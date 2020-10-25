import 'package:flutter/material.dart';

class PayerDropdown extends StatelessWidget {
  final String payer;
  final List<String> possiblePayers;
  final void Function(String) onPayerChanged;

  PayerDropdown(
      {@required this.payer,
      @required this.possiblePayers,
      @required this.onPayerChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        isExpanded: true,
        style: TextStyle(fontSize: 24, color: Colors.black),
        value: payer,
        validator: (val) =>
            val == null || val.isEmpty ? 'Payer must be specified' : null,
        onChanged: onPayerChanged,
        items: possiblePayers
            .map((value) => DropdownMenuItem<String>(
                value: value, child: Center(child: Text(value))))
            .toList());
  }
}
