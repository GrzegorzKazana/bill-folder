import 'package:flutter/material.dart';

class BankOverviewTabContent extends StatelessWidget {
  final String tabName;
  final Widget child;
  final Widget sliver;

  BankOverviewTabContent({@required this.tabName, this.child, this.sliver});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) => CustomScrollView(
          key: PageStorageKey<String>(tabName),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            if (sliver != null) sliver,
            if (child != null) SliverToBoxAdapter(child: child),
          ],
        ),
      ),
    );
  }
}
