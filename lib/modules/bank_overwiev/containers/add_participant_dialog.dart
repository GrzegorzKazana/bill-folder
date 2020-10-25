import 'package:flutter/material.dart';

import './participant_form/index.dart';
import 'package:bill_folder/common/components/custom_dialog.dart';
import 'package:bill_folder/common/utils/get_random_color.dart';

class AddParticipantDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddParticipantDialogState();
}

class _AddParticipantDialogState extends State<AddParticipantDialog> {
  String _name = '';
  Color _avatarColor = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Add participant',
      child: AvatarNameForm(
        name: _name,
        color: _avatarColor,
        onColorChange: (color) => setState(() => _avatarColor = color),
        onNameChange: (name) => setState(() => _name = name),
      ),
      footer: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Add', style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
