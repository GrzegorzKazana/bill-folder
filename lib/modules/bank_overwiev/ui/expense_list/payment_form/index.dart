import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';
import 'package:bill_folder/common/components/choice_chip_dialog.dart';
import 'package:bill_folder/common/components/dropdown_input.dart';
import 'package:bill_folder/common/components/labeled_form_field_container.dart';

import './price_input.dart';
import './date_input.dart';
import './tag_list.dart';
import '../../../models/ExpenseTag.dart';
import '../../../models/Participant.dart';
import '../../../models/Currency.dart';

final paymentFormKey = GlobalKey<FormState>();

class PaymentForm extends StatelessWidget {
  final List<ExpenseTag> selectedTags;
  final void Function(List<ExpenseTag>) onSelectedTagsChanged;

  final Monetary price;
  final void Function(Monetary) onPriceChanged;

  final Participant payer;
  final List<Participant> possiblePayers;
  final void Function(Participant) onPayerChanged;

  final DateTime paymentDate;
  final void Function(DateTime) onPaymentDateChanged;

  final Currency walletCurrency;

  PaymentForm(
      {this.selectedTags = const [],
      this.onSelectedTagsChanged,
      this.price,
      this.onPriceChanged,
      this.payer,
      this.possiblePayers = const [],
      this.onPayerChanged,
      this.paymentDate,
      this.onPaymentDateChanged,
      this.walletCurrency});

  Future<void> _showChipDialog(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final tagNames = await showDialog<List<String>>(
        context: context,
        builder: (context) => ChoiceChipDialog(
              title: 'Tags',
              options: ExpenseTag.values.map(expenseTagToString).toList(),
              formatter: formatExpenseTagValue,
              selectedOptions: selectedTags.map(expenseTagToString).toList(),
            ));

    final tags = tagNames.map(stringToExpenseTag).toList();

    onSelectedTagsChanged(tags);
  }

  Future<void> _showDateDialog(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final maybeDate = await showDatePicker(
        context: context,
        initialDate: paymentDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (maybeDate != null) onPaymentDateChanged(maybeDate);
  }

  Participant _getParticipantById(String id, List<Participant> participants) {
    return participants.firstWhere((p) => p.id == id, orElse: () => null);
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
                value: payer?.id,
                onTap: FocusScope.of(context).unfocus,
                onValueChanged: (id) =>
                    onPayerChanged(_getParticipantById(id, possiblePayers)),
                possibleValues: possiblePayers.map((p) => p.id).toList(),
                valueFormatter: (id) =>
                    _getParticipantById(id, possiblePayers).name,
              ),
            ),
            LabeledFormFieldContainer(
              label: 'Price:',
              input: PriceInput(
                onPriceChanged: onPriceChanged,
              ),
              postfix: Text(formatCurrency(walletCurrency).padRight(2),
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
                  selectedTags: selectedTags.map(formatExpenseTag).toList(),
                  onTap: () => _showChipDialog(context),
                )),
          ],
        ));
  }
}
