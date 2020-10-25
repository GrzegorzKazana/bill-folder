import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String name;
  final void Function(String) onTextChange;
  final int maxLength;

  TextInput({@required this.onTextChange, this.name, this.maxLength});

  String get displayName => name ?? 'Text';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 24),
      validator: (value) {
        if (value.isEmpty) return '$displayName may not be empty';

        if (maxLength != null && value.length > maxLength)
          return '$displayName must be $maxLength signs or less';

        return null;
      },
      onChanged: onTextChange,
    );
  }
}
