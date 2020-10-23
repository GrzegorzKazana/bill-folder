import 'package:flutter/material.dart';

import 'components/bank_app_bar.dart';
import 'components/bank_tab_header.dart';
import 'components/bank_overview_drawer.dart';
import 'containers/person_summary_list.dart';
import 'containers/bank_summary_bar.dart';

class MyHomePage extends StatelessWidget {
  final _tabs = ["Tab 1", "Tab 2"];

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: BankAppBar(),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: BankSummaryBarDelegate(),
      ),
      SliverPersistentHeader(
          pinned: true,
          delegate: BandTabPersistentHeaderDelegate(bankTabHeader(_tabs))),
    ];
  }

  Widget _buildTab(String tabName, {Widget child}) {
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
            SliverToBoxAdapter(child: child),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: _buildHeader,
            body: TabBarView(
              children: _tabs
                  .map((name) => _buildTab(name, child: PersonSummaryList()))
                  .toList(),
            ),
          ),
          drawer: Drawer(
            child: BankOverviewDrawer(),
          ),
        ));
  }
}
