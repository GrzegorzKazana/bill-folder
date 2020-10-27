import 'package:flutter/material.dart';

import './payment_form/index.dart';
import 'package:bill_folder/common/models/monetary.dart';
import 'package:bill_folder/common/components/custom_dialog.dart';

class AddPaymentDialog extends StatefulWidget {
  final String title;

  AddPaymentDialog({this.title});

  @override
  State<StatefulWidget> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  List<String> selectedTags = [];
  Monetary price;
  DateTime paymentDate = DateTime.now();
  String payer;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: widget.title ?? 'Add payment',
      child: PaymentForm(
        selectedTags: selectedTags,
        onSelectedTagsChanged: (tags) => setState(() => selectedTags = tags),
        price: price,
        onPriceChanged: (priceVal) => setState(() => price = priceVal),
        payer: payer,
        possiblePayers: ['You', 'Me'],
        onPayerChanged: (payerVal) => setState(() => payer = payerVal),
        paymentDate: paymentDate,
        onPaymentDateChanged: (date) => setState(() => paymentDate = date),
      ),
      footer: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        TextButton(
            onPressed: () {
              if (paymentFormKey.currentState.validate())
                Navigator.of(context).pop();
            },
            child: Text('Add', style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
