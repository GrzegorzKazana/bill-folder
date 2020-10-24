import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:bill_folder/common/components/avatar_name_form.dart';

class AddParticipantDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddParticipantDialogState();
}

class _AddParticipantDialogState extends State<AddParticipantDialog> {
  String _name = '';
  Color _avatarColor =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
            constraints: BoxConstraints(
                minHeight: 200, maxHeight: 400, minWidth: 200, maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 12),
                    margin: EdgeInsets.all(4),
                    child: Text('Add participant',
                        style: TextStyle(fontSize: 24))),
                AvatarNameForm(
                  name: _name,
                  color: _avatarColor,
                  onColorChange: (color) =>
                      setState(() => _avatarColor = color),
                  onNameChange: (name) => setState(() => _name = name),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child:
                                Text('Cancel', style: TextStyle(fontSize: 16))),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Add', style: TextStyle(fontSize: 16))),
                      ],
                    ))
              ],
            )));
  }
}
