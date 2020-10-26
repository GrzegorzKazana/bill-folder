import 'package:flutter/material.dart';

import 'package:bill_folder/common/components/avatar.dart';

class PersonBillSummaryHeader extends StatelessWidget {
  final bool isExpanded;

  PersonBillSummaryHeader({this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Avatar(color: Colors.blue, name: 'Grzegorz K', size: 40)),
          Expanded(
              child: Text('Grzegorz K',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5)),
          Text('-24\$', style: TextStyle(fontSize: 24, color: Colors.red))
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
