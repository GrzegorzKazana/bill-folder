import 'package:bill_folder/modules/bank_overwiev/containers/expense_list.dart';
import 'package:flutter/material.dart';

import 'components/bank_app_bar.dart';
import 'components/bank_tab_header.dart';
import 'components/bank_overview_drawer.dart';
import 'containers/person_summary_list.dart';
import 'containers/bank_summary_bar.dart';

class MyHomePage extends StatelessWidget {
  final _tabs = ["Participants", "Expenses"];

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
          delegate: BandTabPersistentHeaderDelegate(bankTabHeader(_tabs),
              color: Theme.of(context).colorScheme.primary)),
    ];
  }

  Widget _buildTab(String tabName, {Widget child, Widget sliver}) {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: _buildHeader,
            body: TabBarView(children: [
              _buildTab(_tabs[0], child: PersonSummaryList()),
              _buildTab(_tabs[1], child: ExpenseList())
            ]),
          ),
          drawer: Drawer(
            child: BankOverviewDrawer(),
          ),
        ));
  }
}
