import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';
import '../../models/Currency.dart';

class BankSummaryBarDelegate extends SliverPersistentHeaderDelegate {
  final Currency walletCurrency;
  final Monetary costOfWallet;
  final int numberOfParticipants;

  BankSummaryBarDelegate(
      {@required this.costOfWallet,
      @required this.numberOfParticipants,
      @required this.walletCurrency});

  String get _fullCost =>
      '${costOfWallet.toString()}${formatCurrency(walletCurrency)}';

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      final double percentage =
          (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

      final leftLabel = [
        TextSpan(
            text: _fullCost,
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ))
      ];

      final rightLabel = [
        WidgetSpan(
            child: Icon(Icons.account_circle, size: 32, color: Colors.white),
            style: TextStyle(fontSize: 32)),
        TextSpan(
            text: " users: $numberOfParticipants",
            style: TextStyle(fontSize: 32, color: Colors.white))
      ];

      return Container(
        color: Theme.of(context).colorScheme.primary,
        height: constraints.maxHeight,
        child: (Stack(children: [
          Align(
              // to center left
              alignment: Alignment.lerp(
                  Alignment(-1, -1), Alignment(0, -0.5), percentage),
              child: Transform.scale(
                  scale: lerpDouble(1, 2, percentage),
                  child: _BankSummaryLabel(
                    height: 50,
                    children: leftLabel,
                  ))),
          Align(
              // to center right
              alignment:
                  Alignment.lerp(Alignment(1, 1), Alignment(0, 1), percentage),
              child: Transform.scale(
                  scale: 1,
                  child: _BankSummaryLabel(
                    height: 50,
                    children: rightLabel,
                  )))
        ])),
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 150.0;

  @override
  double get minExtent => 50.0;
}

class _BankSummaryLabel extends StatelessWidget {
  final double height;
  final List<InlineSpan> children;

  _BankSummaryLabel({@required this.height, this.children = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FittedBox(
              child: RichText(
                  text: TextSpan(
            children: children,
          )))
        ]));
  }
}
