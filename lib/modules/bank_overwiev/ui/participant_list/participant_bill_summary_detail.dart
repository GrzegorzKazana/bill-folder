import 'package:flutter/material.dart';

import '../../models/Participant.dart';

class ParticipantBillSummaryDetail extends StatelessWidget {
  final ParticipantWithStats participant;

  ParticipantBillSummaryDetail({@required this.participant});

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
                          '${participant.stats.moneySpent}Z',
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
                          '${participant.stats.numberOfPayments}',
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
                          participant.stats.lastPaymentDate.toString(),
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
                        onPressed: () {},
                        child: Text("VIEW", style: TextStyle(fontSize: 16))),
                    TextButton(
                        onPressed: () {},
                        child: Text("ADD", style: TextStyle(fontSize: 16)))
                  ],
                ))
          ],
        ));
  }
}
