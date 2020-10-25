import 'package:flutter/material.dart';

import 'package:bill_folder/common/components/labeled_form_field_container.dart';
import 'package:bill_folder/common/components/text_input.dart';
import 'package:bill_folder/common/components/dropdown_input.dart';

final walletFormKey = GlobalKey<FormState>();

class WalletForm extends StatelessWidget {
  final void Function(String) onNameChange;

  final String currency;
  final List<String> possibleCurrencies;
  final void Function(String) onCurrencyChange;

  WalletForm(
      {@required this.onNameChange,
      @required this.currency,
      @required this.possibleCurrencies,
      @required this.onCurrencyChange});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: walletFormKey,
      child: Column(
        children: [
          LabeledFormFieldContainer(
              label: 'Name:',
              input: TextInput(
                  name: 'Name', maxLength: 16, onTextChange: onNameChange)),
          LabeledFormFieldContainer(
              label: 'Currency:',
              input: DropdownInput(
                  value: currency,
                  possibleValues: possibleCurrencies,
                  onValueChanged: onCurrencyChange)),
        ],
      ),
    );
  }
}
