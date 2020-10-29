import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';
import 'package:bill_folder/common/components/custom_dialog.dart';

import './payment_form/index.dart';
import '../../models/Expense.dart';
import '../../models/ExpenseTag.dart';
import '../../models/Participant.dart';
import '../../models/Currency.dart';

class AddPaymentDialog extends StatefulWidget {
  final String title;
  final Currency walletCurrency;
  final List<Participant> participants;

  final Participant initialPayer;
  final Expense initialExpense;

  AddPaymentDialog({
    this.title,
    @required this.participants,
    @required this.walletCurrency,
    this.initialPayer,
    this.initialExpense,
  });

  @override
  State<StatefulWidget> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  List<ExpenseTag> selectedTags = [];
  Monetary price;
  DateTime paymentDate = DateTime.now();
  Participant payer;

  String get _title => widget.title ?? 'Add payment';
  Currency get _currency => widget.walletCurrency;
  List<Participant> get _participants => widget.participants;

  @override
  void initState() {
    super.initState();
    payer = widget.initialPayer;
    if (widget.initialExpense != null) {
      selectedTags = widget.initialExpense.tags;
      price = widget.initialExpense.price;
      paymentDate = widget.initialExpense.date;
    }
  }

  void _submit() {
    if (!paymentFormKey.currentState.validate()) return;

    final data = Expense(
        payerId: payer.id, price: price, date: paymentDate, tags: selectedTags);

    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: _title,
      child: PaymentForm(
        walletCurrency: _currency,
        selectedTags: selectedTags,
        onSelectedTagsChanged: (tags) => setState(() => selectedTags = tags),
        price: price,
        onPriceChanged: (priceVal) => setState(() => price = priceVal),
        payer: payer,
        possiblePayers: _participants,
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
            onPressed: _submit,
            child: Text('Add', style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
