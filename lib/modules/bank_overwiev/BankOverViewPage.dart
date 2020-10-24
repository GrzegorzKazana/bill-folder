import 'package:bill_folder/modules/bank_overwiev/components/bank_overview_fab.dart';
import 'package:flutter/material.dart';

import 'components/bank_app_bar.dart';
import 'components/bank_tab_header.dart';
import 'components/bank_overview_drawer.dart';
import 'components/bank_overview_fab.dart';
import 'containers/person_summary_list.dart';
import 'containers/bank_summary_bar.dart';
import 'containers/expense_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _tabs = ["Participants", "Expenses"];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          delegate: BandTabPersistentHeaderDelegate(
              bankTabHeader(_tabs, _tabController),
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
    return (Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _buildHeader,
        body: TabBarView(controller: _tabController, children: [
          _buildTab(_tabs[0], child: PersonSummaryList()),
          _buildTab(_tabs[1], child: ExpenseList())
        ]),
      ),
      drawer: Drawer(
        child: BankOverviewDrawer(),
      ),
      floatingActionButton: BankOverviewFAB(),
    ));
  }
}
