import 'package:flutter/material.dart';

import 'package:bill_folder/common/components/custom_dialog.dart';
import 'package:bill_folder/common/utils/get_random_color.dart';

import './participant_form/index.dart';
import '../../models/Participant.dart';

class AddParticipantDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddParticipantDialogState();
}

class _AddParticipantDialogState extends State<AddParticipantDialog> {
  String _name = '';
  Color _avatarColor = getRandomColor();

  void _submit() {
    if (!participantFormKey.currentState.validate()) return;

    final data = Participant(name: _name, avatarColor: _avatarColor);
    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Add participant',
      child: ParticipantForm(
        name: _name,
        color: _avatarColor,
        onColorChange: (color) => setState(() => _avatarColor = color),
        onNameChange: (name) => setState(() => _name = name),
      ),
      footer: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        TextButton(
            onPressed: _submit,
            child: Text('Add', style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
