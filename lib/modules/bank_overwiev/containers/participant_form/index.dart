import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:bill_folder/common/components/avatar.dart';
import 'package:bill_folder/common/components/labeled_form_field_container.dart';

class AvatarNameForm extends StatelessWidget {
  final String name;
  final Color color;
  final void Function(String) onNameChange;
  final void Function(Color) onColorChange;

  AvatarNameForm(
      {@required this.name,
      @required this.color,
      this.onNameChange,
      this.onColorChange});

  void _showColorPicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text('Select a color'),
            content: SingleChildScrollView(
                child: BlockPicker(
                    pickerColor: color,
                    onColorChanged: (color) {
                      Navigator.pop(context);
                      onColorChange(color);
                    }))));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(children: [
      LabeledFormFieldContainer(
          label: 'Name:',
          input: TextFormField(
            style: TextStyle(fontSize: 24),
            validator: (value) =>
                value.isEmpty ? 'Name may not be empty' : null,
            onChanged: onNameChange,
          )),
      LabeledFormFieldContainer(
          label: 'Avatar:',
          input: GestureDetector(
              onTap: () => _showColorPicker(context),
              child: Container(
                  alignment: Alignment.center,
                  child: Avatar(
                      color: color,
                      name: name.isEmpty ? 'Unknown Person' : name)))),
    ]));
  }
}
