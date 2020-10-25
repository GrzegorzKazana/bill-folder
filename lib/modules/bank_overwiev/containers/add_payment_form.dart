import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bill_folder/common/models/monetary.dart';
import 'package:bill_folder/common/utils/format_date.dart';
import 'package:bill_folder/common/components/choice_chip_dialog.dart';

final monetryRegex = RegExp(r'^\d*((\.|,)\d{0,2})?');

class AddPaymentForm extends StatelessWidget {
  final List<String> selectedTags;
  final void Function(List<String>) onSelectedTagsChanged;

  final Monetary price;
  final void Function(Monetary) onPriceChanged;

  final String payer;
  final List<String> possiblePayers;
  final void Function(String) onPayerChanged;

  final DateTime paymentDate;
  final void Function(DateTime) onPaymentDateChanged;

  AddPaymentForm(
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
              options: ['Stuff', 'Shopping', 'Party', 'Tickets', 'Hang out'],
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
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Payer:', style: Theme.of(context).textTheme.headline6),
            Expanded(
                child: Container(
                    constraints: BoxConstraints(minHeight: 48),
                    padding: EdgeInsets.only(left: 20),
                    child: DropdownButton<String>(
                        isExpanded: true,
                        style: TextStyle(fontSize: 24, color: Colors.black),
                        value: payer,
                        onChanged: onPayerChanged,
                        items: possiblePayers
                            .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Center(child: Text(value))))
                            .toList()))),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text('Price:', style: Theme.of(context).textTheme.headline6),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextFormField(
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(monetryRegex),
                      ],
                      onChanged: (value) => onPriceChanged(
                          Monetary.fromString(value.replaceAll(',', '.'))),
                    ))),
            Padding(
                padding: EdgeInsets.only(right: 10),
                child:
                    Text(r'$', style: Theme.of(context).textTheme.headline5)),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Date:', style: Theme.of(context).textTheme.headline6),
            Expanded(
                child: InkWell(
              onTap: () => _showDateDialog(context),
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Text(formatDate(paymentDate),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.headline5)),
            ))
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: selectedTags.isEmpty
              ? CrossAxisAlignment.baseline
              : CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text('Tags:',
                    style: Theme.of(context).textTheme.headline6)),
            Expanded(
                child: Container(
                    constraints: BoxConstraints(minHeight: 48),
                    child: selectedTags.isEmpty
                        ? Container(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                                onPressed: () => _showChipDialog(context),
                                icon: Icon(Icons.add),
                                label: Text('Add tag')))
                        : InkWell(
                            onTap: () => _showChipDialog(context),
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              runSpacing: 4,
                              spacing: 4,
                              children: selectedTags
                                  .map((selectedChipText) => Chip(
                                        label: Text(
                                          selectedChipText,
                                        ),
                                        padding: EdgeInsets.zero,
                                        labelPadding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ))
                                  .toList(),
                            ))))
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
