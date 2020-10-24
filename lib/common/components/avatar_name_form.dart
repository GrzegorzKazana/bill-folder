import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import './avatar.dart';

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
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: GestureDetector(
                      onTap: () => _showColorPicker(context),
                      child: Row(
                        children: [
                          Avatar(
                              color: color,
                              name: name.isEmpty ? 'Unknown Person' : name)
                        ],
                      )),
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          style: TextStyle(fontSize: 22),
                          validator: (value) =>
                              value.isEmpty ? 'Name may not be empty' : null,
                          onChanged: onNameChange,
                        ))),
              ],
            )));
  }
}
