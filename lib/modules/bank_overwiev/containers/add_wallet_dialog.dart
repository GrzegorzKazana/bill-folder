import 'package:flutter/material.dart';

import 'package:bill_folder/common/components/custom_dialog.dart';

import './wallet_form/index.dart';

class AddWalletDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddWalletDialog();
}

class _AddWalletDialog extends State<AddWalletDialog> {
  String name;
  String currency = 'PLN';

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Create wallet',
      child: WalletForm(
        onNameChange: (val) => setState(() => name = val),
        currency: currency,
        possibleCurrencies: ['\$', 'PLN', '€', '£'],
        onCurrencyChange: (val) => setState(() => currency = val),
      ),
      footer: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        TextButton(
            onPressed: () {
              if (walletFormKey.currentState.validate())
                Navigator.of(context).pop();
            },
            child: Text('Add', style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
