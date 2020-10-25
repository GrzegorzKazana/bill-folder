import 'package:flutter/material.dart';

class PersonBillSummaryHeader extends StatelessWidget {
  final bool isExpanded;

  PersonBillSummaryHeader({this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(children: [
          Expanded(
              child: Text('Grzegorz K',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5)),
          Text('-24\$', style: TextStyle(fontSize: 24, color: Colors.red))
        ]),
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
