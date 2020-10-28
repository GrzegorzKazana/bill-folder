import 'package:flutter/material.dart';

import 'package:bill_folder/common/components/custom_dialog.dart';

import './wallet_form/index.dart';
import '../../models/Currency.dart';
import '../../models/Wallet.dart';

class AddWalletDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddWalletDialog();
}

class _AddWalletDialog extends State<AddWalletDialog> {
  String name;
  Currency currency = Currency.DOLLAR;

  void _submit() {
    if (!walletFormKey.currentState.validate()) return;

    final data = Wallet(name: name, currency: currency);
    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Create wallet',
      child: WalletForm(
        onNameChange: (val) => setState(() => name = val),
        currency: currency,
        possibleCurrencies: Currency.values,
        onCurrencyChange: (val) => setState(() => currency = val),
      ),
      footer: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        TextButton(
            onPressed: _submit,
            child: Text('Add', style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
