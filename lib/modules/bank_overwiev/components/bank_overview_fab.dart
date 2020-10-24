import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class BankOverviewFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: Icon(Icons.add),
      tooltip: 'Add',
      overlayOpacity: 0.5,
      children: [
        SpeedDialChild(
            child: Icon(Icons.group_add),
            label: 'Add participant',
            labelStyle: TextStyle(fontSize: 24),
            onTap: () {}),
        SpeedDialChild(
            child: Icon(Icons.attach_money),
            label: 'Add expense',
            labelStyle: TextStyle(fontSize: 24),
            onTap: () {}),
      ],
    );
  }
}
