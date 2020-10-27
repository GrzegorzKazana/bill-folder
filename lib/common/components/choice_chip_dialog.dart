import 'package:flutter/material.dart';

import 'custom_dialog.dart';

class ChoiceChipDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final List<String> selectedOptions;

  ChoiceChipDialog(
      {this.title = '',
      this.options = const [],
      this.selectedOptions = const []});

  @override
  State<StatefulWidget> createState() => _ChoiceChipDialogState();
}

class _ChoiceChipDialogState extends State<ChoiceChipDialog> {
  List<String> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = List.from(widget.selectedOptions);
  }

  void _toggleSelectedOption(String option, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: widget.title,
      child: Container(
          child: Wrap(
              runSpacing: 4,
              spacing: 4,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: widget.options
                  .map((option) => ChoiceChip(
                        onSelected: (isSelected) =>
                            _toggleSelectedOption(option, isSelected),
                        label: Text(option),
                        selected: selectedOptions.contains(option),
                        labelPadding: EdgeInsets.symmetric(horizontal: 8),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ))
                  .toList())),
      footer: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(widget.selectedOptions),
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        TextButton(
            onPressed: () => Navigator.of(context).pop(selectedOptions),
            child: Text('Add', style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
