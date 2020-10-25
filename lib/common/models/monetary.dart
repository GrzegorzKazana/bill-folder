import 'package:flutter/foundation.dart';

class Monetary {
  final int unit;
  final int cent;
  Monetary({@required this.unit, @required this.cent});

  @override
  String toString([String separator = '.']) => '$unit$separator$cent';

  Monetary.fromString(String input, [String separator = '.'])
      : unit = int.tryParse(input.split(separator)[0]) ?? 0,
        cent = int.tryParse(input.split(separator)[1]) ?? 0;
}
