import 'package:flutter/material.dart';

import '../../models/Participant.dart';

class ExpenseListFilterButton extends StatelessWidget {
  final Participant selectedParticipant;
  final List<Participant> allParticipants;
  final void Function(Participant) onParticipantChange;

  ExpenseListFilterButton({
    @required this.selectedParticipant,
    @required this.allParticipants,
    @required this.onParticipantChange,
  });

  Participant _getParticipantById(String id, List<Participant> participants) {
    return participants.firstWhere((p) => p.id == id, orElse: () => null);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        icon: Icon(Icons.filter_list_alt),
        iconSize: 32,
        style: TextStyle(fontSize: 24, color: Colors.black),
        value: selectedParticipant?.id,
        onChanged: (id) =>
            onParticipantChange(_getParticipantById(id, allParticipants)),
        items: [
          DropdownMenuItem<String>(value: null, child: Text("All")),
          ...allParticipants
              .map((participant) => DropdownMenuItem<String>(
                  value: participant.id, child: Text(participant.name)))
              .toList()
        ]);
  }
}
