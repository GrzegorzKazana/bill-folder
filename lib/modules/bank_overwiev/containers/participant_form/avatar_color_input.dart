import 'package:flutter/material.dart';

import 'package:bill_folder/common/components/avatar.dart';

class AvatarColorInput extends StatelessWidget {
  final String name;
  final Color color;
  final void Function() onTap;

  AvatarColorInput(
      {@required this.color, @required this.name, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            child: Avatar(
                color: color, name: name.isEmpty ? 'Unknown Person' : name)));
  }
}
