import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:bill_folder/common/components/labeled_form_field_container.dart';
import 'package:bill_folder/common/components/text_input.dart';

import './avatar_color_input.dart';

final participantFormKey = GlobalKey<FormState>();

class ParticipantForm extends StatelessWidget {
  final String name;
  final Color color;
  final void Function(String) onNameChange;
  final void Function(Color) onColorChange;

  ParticipantForm(
      {@required this.name,
      @required this.color,
      this.onNameChange,
      this.onColorChange});

  void _showColorPicker(BuildContext context) {
    FocusScope.of(context).unfocus();

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
        key: participantFormKey,
        child: Column(children: [
          LabeledFormFieldContainer(
              label: 'Name:',
              input: TextInput(
                name: 'Name',
                onTextChange: onNameChange,
              )),
          LabeledFormFieldContainer(
              label: 'Avatar:',
              input: AvatarColorInput(
                  name: name,
                  color: color,
                  onTap: () => _showColorPicker(context))),
        ]));
  }
}
