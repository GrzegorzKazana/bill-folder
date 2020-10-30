import 'package:test/test.dart';

import 'package:bill_folder/common/models/monetary.dart';

void main() {
  group('Monetary model', () {
    test('it should handle equality', () {
      expect(Monetary(unit: 3, cent: 34), equals(Monetary(unit: 3, cent: 34)));
      expect(Monetary(unit: 3, cent: 34, sign: -1),
          equals(Monetary(unit: 3, cent: 34, sign: -1)));
      expect(
        Monetary(unit: 3, cent: 34, sign: -1) == Monetary(unit: 3, cent: 34),
        equals(false),
      );
      expect(Monetary(unit: 3, cent: 34) == (Monetary(unit: 2, cent: 34)),
          equals(false));
      expect(Monetary(unit: 3, cent: 99) == (Monetary(unit: 3, cent: 90)),
          equals(false));
    });

    test('it should handle adding', () {
      expect(Monetary(unit: 3, cent: 34) + Monetary(unit: 10, cent: 99),
          equals(Monetary(unit: 14, cent: 33)));
      expect(
          Monetary(unit: 3, cent: 34, sign: -1) + Monetary(unit: 10, cent: 99),
          equals(Monetary(unit: 7, cent: 65)));
      expect(
          Monetary(unit: 3, cent: 34) + Monetary(unit: 10, cent: 99, sign: -1),
          equals(Monetary(unit: 7, cent: 65, sign: -1)));
    });

    test('it should handle subtracting', () {
      expect(Monetary(unit: 3, cent: 34) - Monetary(unit: 10, cent: 99),
          equals(Monetary(unit: 7, cent: 65, sign: -1)));
      expect(
          Monetary(unit: 3, cent: 34, sign: -1) - Monetary(unit: 10, cent: 99),
          equals(Monetary(unit: 14, cent: 33, sign: -1)));
      expect(
          Monetary(unit: 3, cent: 34) - Monetary(unit: 10, cent: 99, sign: -1),
          equals(Monetary(unit: 14, cent: 33)));
    });

    test('it should handle integer division', () {
      expect(Monetary(unit: 3, cent: 34) ~/ 2,
          equals(Monetary(unit: 1, cent: 67)));
      expect(Monetary(unit: 3, cent: 34, sign: -1) ~/ 2,
          equals(Monetary(unit: 1, cent: 67, sign: -1)));
      expect(Monetary(unit: 3, cent: 34) ~/ -2,
          equals(Monetary(unit: 1, cent: 67, sign: -1)));
    });

    test('it should be properly formatted', () {
      expect(Monetary(unit: 3, cent: 34).toString(), equals('3.34'));
      expect(Monetary(unit: 3, cent: 34, sign: -1).toString(), equals('-3.34'));
      expect(Monetary(unit: 3, cent: 1, sign: -1).toString(), equals('-3.01'));
      expect(Monetary(unit: 3, cent: 10, sign: -1).toString(), equals('-3.10'));
    });

    test('it should be properly parsed', () {
      expect(Monetary.fromString('3.34'), equals(Monetary(unit: 3, cent: 34)));
      expect(Monetary.fromString('-3.34'),
          equals(Monetary(unit: 3, cent: 34, sign: -1)));
      expect(Monetary.fromString('3.04'), equals(Monetary(unit: 3, cent: 4)));
      expect(Monetary.fromString('3.4'), equals(Monetary(unit: 3, cent: 40)));
    });

    test('it should be correctly changed to cents', () {
      expect(Monetary(unit: 3, cent: 34).toCents(), 334);
      expect(Monetary(unit: 3, cent: 34, sign: -1).toCents(), -334);
      expect(Monetary(unit: 3, cent: 1, sign: -1).toCents(), -301);
      expect(Monetary(unit: 3, cent: 10, sign: -1).toCents(), -310);
    });

    test('it should be correctly contructed from cents', () {
      expect(Monetary.fromCents(334), equals(Monetary(unit: 3, cent: 34)));
      expect(Monetary.fromCents(-334),
          equals(Monetary(unit: 3, cent: 34, sign: -1)));
      expect(Monetary.fromCents(-301),
          equals(Monetary(unit: 3, cent: 1, sign: -1)));
      expect(Monetary.fromCents(-310),
          equals(Monetary(unit: 3, cent: 10, sign: -1)));
    });
  });
}
