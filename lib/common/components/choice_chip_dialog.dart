import 'package:flutter/material.dart';

import 'custom_dialog.dart';

class ChoiceChipDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final List<String> selectedOptions;
  final String Function(String) formatter;

  ChoiceChipDialog(
      {this.title = '',
      this.options = const [],
      this.selectedOptions = const [],
      this.formatter});

  @override
  State<StatefulWidget> createState() => _ChoiceChipDialogState();
}

class _ChoiceChipDialogState extends State<ChoiceChipDialog> {
  List<String> selectedOptions;

  String get _title => widget.title;
  List<String> get _options => widget.options;
  List<String> get _initialSelectedOptions => widget.selectedOptions;
  String Function(String) get _formatter => widget.formatter;

  @override
  void initState() {
    super.initState();
    selectedOptions = List.from(_initialSelectedOptions);
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

  String _formatLabel(String label) {
    return _formatter != null ? _formatter(label) : label;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: _title,
      child: Container(
          child: Wrap(
              runSpacing: 4,
              spacing: 4,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _options
                  .map((option) => ChoiceChip(
                        onSelected: (isSelected) =>
                            _toggleSelectedOption(option, isSelected),
                        label: Text(_formatLabel(option)),
                        selected: selectedOptions.contains(option),
                        labelPadding: EdgeInsets.symmetric(horizontal: 8),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ))
                  .toList())),
      footer: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(_initialSelectedOptions),
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        TextButton(
            onPressed: () => Navigator.of(context).pop(selectedOptions),
            child: Text('Add', style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
