import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final List<String> selectedTags;
  final void Function() onTap;

  TagList({@required this.selectedTags, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        constraints: BoxConstraints(minHeight: 48),
        child: selectedTags.isEmpty
            ? Container(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                    onPressed: onTap,
                    icon: Icon(Icons.add),
                    label: Text('Add tag')))
            : InkWell(
                onTap: onTap,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  runSpacing: 4,
                  spacing: 4,
                  children: selectedTags
                      .map((selectedChipText) => Chip(
                            label: Text(
                              selectedChipText,
                            ),
                            padding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.symmetric(horizontal: 8),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ))
                      .toList(),
                )));
  }
}
