import 'package:flutter/material.dart';

class PersonBillSummaryHeader extends StatelessWidget {
  final bool isExpanded;

  PersonBillSummaryHeader({this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("test!"),
        subtitle: Text("KEK"),
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
