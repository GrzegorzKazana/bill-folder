import 'package:flutter/material.dart';

import 'participant_bill_summary_header.dart';
import 'participant_bill_summary_detail.dart';

class ParticipantSummaryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParticipantSummaryListState();
}

class _ParticipantSummaryListState extends State<ParticipantSummaryList> {
  List<bool> _openItems = [true, false, false, false, true, false, true, false];

  void _toggleItemOpen(int index, bool isExpanded) {
    setState(() {
      _openItems[index] = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: _toggleItemOpen,
        children: _openItems
            .map((item) => ExpansionPanel(
                  isExpanded: item,
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) =>
                      ParticipantBillSummaryHeader(
                    isExpanded: isExpanded,
                  ),
                  body: ParticipantBillSummaryDetail(),
                ))
            .toList());
  }
}
