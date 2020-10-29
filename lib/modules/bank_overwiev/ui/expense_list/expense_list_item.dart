import 'package:bill_folder/common/utils/format_date.dart';
import 'package:flutter/material.dart';

import '../../models/Expense.dart';
import '../../models/ExpenseTag.dart';
import '../../models/Currency.dart';
import '../../models/Participant.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;
  final Currency walletCurrency;
  final Participant payer;
  final VoidCallback onConfirmDelete;
  final VoidCallback onEditPayment;

  ExpenseListItem({
    @required this.expense,
    @required this.walletCurrency,
    @required this.payer,
    @required this.onConfirmDelete,
    @required this.onEditPayment,
  });

  String get _price => expense.price.toString();
  String get _currency => formatCurrency(walletCurrency);
  String get _paymentDate => formatDate(expense.date);
  String get _expenseTags => expense.tags.map(formatExpenseTag).join(', ');

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 100),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: FittedBox(
                          child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: _price,
                              style: Theme.of(context).textTheme.headline1),
                          TextSpan(
                              text: _currency,
                              style: Theme.of(context).textTheme.headline3),
                        ]),
                      ))),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(payer.name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline5),
                            Text(_paymentDate,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6),
                            Text(_expenseTags,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle1)
                          ])),
                ),
                PopupMenuButton(
                    onSelected: (str) =>
                        str == 'Delete' ? onConfirmDelete() : onEditPayment(),
                    itemBuilder: (_) => [
                          PopupMenuItem<String>(
                              child: Text('Edit'), value: 'Edit'),
                          PopupMenuItem<String>(
                              child: Text('Delete'), value: 'Delete'),
                        ]),
              ],
            )));
  }
}
