import 'package:flutter/foundation.dart';

@immutable
class Monetary {
  final int unit;
  final int cent;
  final int sign;
  Monetary({@required this.unit, @required this.cent, this.sign = 1});

  @override
  String toString([String separator = '.']) =>
      '${sign == -1 ? '-' : ''}$unit$separator${cent.toString().padLeft(2, '0')}';

  Monetary.fromString(String input, [String separator = '.'])
      : sign = Monetary._tryParseSign(input),
        unit = Monetary._tryParseUnit(input, separator),
        cent = Monetary._tryParseCent(input, separator);

  Monetary.empty()
      : sign = 1,
        unit = 0,
        cent = 0;

  Monetary.fromCents(int cents)
      : sign = cents.sign,
        unit = cents.abs() ~/ 100,
        cent = cents.abs() % 100;

  int toCents() {
    return sign * (unit * 100 + cent);
  }

  bool operator ==(Object other) {
    return (other is Monetary) &&
        unit == other.unit &&
        cent == other.cent &&
        sign == other.sign;
  }

  @override
  int get hashCode => unit.hashCode ^ cent.hashCode ^ sign.hashCode;

  Monetary operator +(Monetary other) {
    return Monetary.fromCents(toCents() + other.toCents());
  }

  Monetary operator -(Monetary other) {
    return Monetary.fromCents(toCents() - other.toCents());
  }

  Monetary operator ~/(int other) {
    return Monetary.fromCents(toCents() ~/ other);
  }

  Monetary operator -() {
    return Monetary.fromCents(-toCents());
  }

  static int _tryParseSign(String input) {
    return input.isNotEmpty && input[0] == '-' ? -1 : 1;
  }

  static int _tryParseUnit(String input, [String separator = '.']) {
    final chunks = input.split(separator);
    final maybeUnit = chunks.length > 0 ? int.tryParse(chunks[0]) : null;

    return maybeUnit != null ? maybeUnit.abs() : 0;
  }

  static int _tryParseCent(String input, [String separator = '.']) {
    final chunks = input.split(separator);
    final maybeCent = chunks.length > 1
        ? int.tryParse(
            chunks[1].replaceAll('-', '').padRight(2, '0').substring(0, 2))
        : null;

    return maybeCent ?? 0;
  }
}
