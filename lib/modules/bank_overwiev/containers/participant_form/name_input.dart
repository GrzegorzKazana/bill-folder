import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  final void Function(String) onNameChange;

  NameInput({@required this.onNameChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 24),
      validator: (value) => value.isEmpty ? 'Name may not be empty' : null,
      onChanged: onNameChange,
    );
  }
}
