import 'package:flutter/material.dart';

import 'participant_bill_summary_header.dart';
import 'participant_bill_summary_detail.dart';

import '../../models/Participant.dart';

class ParticipantSummaryList extends StatefulWidget {
  final List<ParticipantWithStats> participants;

  ParticipantSummaryList({@required this.participants});

  @override
  State<StatefulWidget> createState() => _ParticipantSummaryListState();
}

class _ParticipantSummaryListState extends State<ParticipantSummaryList> {
  Set<String> _openItemsIds = Set();

  void _toggleItemOpen(int index, bool isExpanded) {
    setState(() {
      if (isExpanded) {
        _openItemsIds.remove(widget.participants[index].info.id);
      } else {
        _openItemsIds.add(widget.participants[index].info.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: _toggleItemOpen,
        children: widget.participants
            .map((participant) => ExpansionPanel(
                  isExpanded: _openItemsIds.contains(participant.info.id),
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) =>
                      ParticipantBillSummaryHeader(
                    isExpanded: isExpanded,
                    participant: participant,
                  ),
                  body: ParticipantBillSummaryDetail(
                    participant: participant,
                  ),
                ))
            .toList());
  }
}
