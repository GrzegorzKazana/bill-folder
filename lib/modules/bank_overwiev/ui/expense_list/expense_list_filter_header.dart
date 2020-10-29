import 'package:flutter/material.dart';

import './expense_list_filter_button.dart';
import '../../models/Participant.dart';

class ExpenseListFilterHeader extends StatelessWidget {
  final int numberOfAllExpenses;
  final int numberOfFilteredExpenses;

  final Participant selectedParticipant;
  final List<Participant> allParticipants;
  final void Function(Participant) onParticipantChange;

  ExpenseListFilterHeader({
    @required this.numberOfFilteredExpenses,
    @required this.numberOfAllExpenses,
    @required this.selectedParticipant,
    @required this.allParticipants,
    @required this.onParticipantChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  '$numberOfFilteredExpenses out of $numberOfAllExpenses',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ExpenseListFilterButton(
                selectedParticipant: selectedParticipant,
                allParticipants: allParticipants,
                onParticipantChange: onParticipantChange,
              ),
            )
          ],
        ));
  }
}
