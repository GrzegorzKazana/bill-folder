import 'package:flutter/material.dart';

import './price_input.dart';
import './date_input.dart';
import './tag_list.dart';
import 'package:bill_folder/common/models/monetary.dart';
import 'package:bill_folder/common/components/choice_chip_dialog.dart';
import 'package:bill_folder/common/components/dropdown_input.dart';
import 'package:bill_folder/common/components/labeled_form_field_container.dart';

final paymentFormKey = GlobalKey<FormState>();

class PaymentForm extends StatelessWidget {
  final List<String> selectedTags;
  final void Function(List<String>) onSelectedTagsChanged;

  final Monetary price;
  final void Function(Monetary) onPriceChanged;

  final String payer;
  final List<String> possiblePayers;
  final void Function(String) onPayerChanged;

  final DateTime paymentDate;
  final void Function(DateTime) onPaymentDateChanged;

  PaymentForm(
      {this.selectedTags = const [],
      this.onSelectedTagsChanged,
      this.price,
      this.onPriceChanged,
      this.payer,
      this.possiblePayers = const [],
      this.onPayerChanged,
      this.paymentDate,
      this.onPaymentDateChanged});

  Future<void> _showChipDialog(BuildContext context) async {
    showDialog<List<String>>(
        context: context,
        builder: (context) => ChoiceChipDialog(
              title: 'Tags',
              options: [
                'Stuff',
                'Shopping',
                'Party',
                'Tickets',
                'Hang out',
                'Drinking',
                'Petrol',
                'Water'
              ],
              selectedOptions: selectedTags,
            )).then(onSelectedTagsChanged);
  }

  Future<void> _showDateDialog(BuildContext context) async {
    final maybeDate = await showDatePicker(
        context: context,
        initialDate: paymentDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (maybeDate != null) onPaymentDateChanged(maybeDate);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: paymentFormKey,
        child: Column(
          children: [
            LabeledFormFieldContainer(
              label: 'Payer:',
              input: DropdownInput(
                  value: payer,
                  onValueChanged: onPayerChanged,
                  possibleValues: possiblePayers),
            ),
            LabeledFormFieldContainer(
              label: 'Price:',
              input: PriceInput(
                onPriceChanged: onPriceChanged,
              ),
              postfix: Text(r'$'.padRight(2),
                  style: Theme.of(context).textTheme.headline5),
            ),
            LabeledFormFieldContainer(
                label: 'Date:',
                input: DateInput(
                  paymentDate: paymentDate,
                  onTap: () => _showDateDialog(context),
                )),
            LabeledFormFieldContainer(
                label: 'Tags:',
                input: TagList(
                  selectedTags: selectedTags,
                  onTap: () => _showChipDialog(context),
                )),
          ],
        ));
  }
}
