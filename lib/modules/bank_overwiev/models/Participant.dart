import 'package:nanoid/nanoid.dart';
import 'package:flutter/material.dart';

@immutable
class Participant {
  final String id;
  final String name;
  final Color avatarColor;

  Participant({
    @required this.name,
    @required this.avatarColor,
    String id,
  }) : id = id ?? nanoid();
}
