import 'dart:math' as math;
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final Color color;
  final String name;
  final double size;

  Avatar({@required this.color, @required this.name, this.size = 50});

  String get initals {
    final chunks = name.split(' ').where((chunk) => chunk.length > 0);
    final nameOrInitials =
        chunks.length < 2 ? name : chunks.map((chunk) => chunk[0]).join('');

    return nameOrInitials
        .substring(0, math.min(nameOrInitials.length, 2))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(size / 2))),
        child: Container(
            alignment: Alignment.center,
            child: Text(initals,
                style: TextStyle(
                    fontSize: size / 2,
                    color: color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white))));
  }
}
