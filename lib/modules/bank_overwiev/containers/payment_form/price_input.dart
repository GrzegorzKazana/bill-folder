import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bill_folder/common/models/monetary.dart';

final monetryRegex = RegExp(r'^\d*((\.|,)\d{0,2})?');

class PriceInput extends StatelessWidget {
  final void Function(Monetary) onPriceChanged;

  PriceInput({@required this.onPriceChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.end,
      keyboardType:
          TextInputType.numberWithOptions(decimal: true, signed: false),
      inputFormatters: [
        FilteringTextInputFormatter.allow(monetryRegex),
      ],
      onChanged: (value) =>
          onPriceChanged(Monetary.fromString(value.replaceAll(',', '.'))),
    );
  }
}
