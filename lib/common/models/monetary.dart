import 'package:flutter/foundation.dart';

class Monetary {
  final int unit;
  final int cent;
  Monetary({@required this.unit, @required this.cent});

  @override
  String toString([String separator = '.']) => '$unit$separator$cent';

  Monetary.fromString(String input, [String separator = '.'])
      : unit = Monetary._tryParseUnit(input, separator),
        cent = Monetary._tryParseCent(input, separator);

  static int _tryParseUnit(String input, [String separator = '.']) {
    final chunks = input.split(separator);
    final maybeUnit = chunks.length > 0 ? int.tryParse(chunks[0]) : null;

    return maybeUnit ?? 0;
  }

  static int _tryParseCent(String input, [String separator = '.']) {
    final chunks = input.split(separator);
    final maybeCent = chunks.length > 1 ? int.tryParse(chunks[1]) : null;

    return maybeCent ?? 0;
  }
}
