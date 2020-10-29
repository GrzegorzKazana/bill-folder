import 'package:flutter/material.dart';

import 'package:bill_folder/common/components/avatar.dart';

import '../../models/Participant.dart';
import '../../models/Currency.dart';

class ParticipantBillSummaryHeader extends StatelessWidget {
  final bool isExpanded;
  final ParticipantWithStats participant;
  final Currency walletCurrency;

  ParticipantBillSummaryHeader(
      {@required this.isExpanded,
      @required this.participant,
      @required this.walletCurrency});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Avatar(
                  color: Colors.blue, name: participant.info.name, size: 40)),
          Expanded(
              child: Text(participant.info.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5)),
          Text(
              '${participant.stats.debt.toString()}${formatCurrency(walletCurrency)}',
              style: TextStyle(fontSize: 24, color: Colors.red))
        ]),
        contentPadding: EdgeInsets.only(left: 16),
        trailing: !isExpanded
            ? IconButton(
                icon: Icon(Icons.add),
                tooltip: "Add payment",
                onPressed: () {
                  print("Pressed add payment butotn");
                },
              )
            : null);
  }
}
