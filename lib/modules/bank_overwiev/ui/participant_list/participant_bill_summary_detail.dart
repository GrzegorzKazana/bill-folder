import 'package:flutter/material.dart';

import 'package:bill_folder/common/utils/format_date.dart';

import '../../models/Participant.dart';
import '../../models/Currency.dart';

class ParticipantBillSummaryDetail extends StatelessWidget {
  final ParticipantWithStats participant;
  final Currency walletCurrency;
  final void Function(BuildContext, {Participant initialPayer})
      showAddPaymentWithPayer;
  final void Function(Participant) navigateToFilteredExpenseList;

  String get _moneySpent =>
      '${participant.stats.moneySpent}${formatCurrency(walletCurrency)}';
  String get _numberOfPayments => '${participant.stats.numberOfPayments}';
  String get _lastPayment => participant.stats.lastPaymentDate != null
      ? formatDate(participant.stats.lastPaymentDate)
      : '---';

  ParticipantBillSummaryDetail(
      {@required this.participant,
      @required this.walletCurrency,
      @required this.showAddPaymentWithPayer,
      @required this.navigateToFilteredExpenseList});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(left: 8, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'Money spent:',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          _moneySpent,
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'Number of payments:',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          _numberOfPayments,
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Expanded(
                            child: Text(
                          'Date of last payment:',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        )),
                        Text(
                          _lastPayment,
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () =>
                            navigateToFilteredExpenseList(participant.info),
                        child: Text("VIEW", style: TextStyle(fontSize: 16))),
                    TextButton(
                        onPressed: () => showAddPaymentWithPayer(context,
                            initialPayer: participant.info),
                        child: Text("ADD", style: TextStyle(fontSize: 16)))
                  ],
                ))
          ],
        ));
  }
}
