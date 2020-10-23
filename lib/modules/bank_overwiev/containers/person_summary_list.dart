import 'package:flutter/material.dart';

import '../components/person_bill_summary_header.dart';
import '../components/person_bill_summary_detail.dart';

class PersonSummaryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonSummaryListState();
}

class _PersonSummaryListState extends State<PersonSummaryList> {
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
                      PersonBillSummaryHeader(
                    isExpanded: isExpanded,
                  ),
                  body: PersonBillSummaryDetail(),
                ))
            .toList());
  }
}
