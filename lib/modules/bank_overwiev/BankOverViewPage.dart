import 'package:flutter/material.dart';

import 'components/bank_overview_drawer.dart';
import 'components/bank_overview_fab.dart';
import 'components/bank_overview_tab.dart';
import 'containers/bank_overview_page_header.dart';
import 'containers/person_summary_list.dart';
import 'containers/expense_list.dart';
import 'containers/add_participant_dialog.dart';
import './containers/add_payment_dialog.dart';
import './containers/add_wallet_dialog.dart';

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

  Future<void> _showCreateWallet(BuildContext context) async {
    showDialog(context: context, child: AddWalletDialog());
  }

  Future<void> _showAddParticipantDialog(BuildContext context) async {
    showDialog<String>(context: context, child: AddParticipantDialog());
  }

  Future<void> _showAddPaymentDialog(BuildContext context) async {
    showDialog(context: context, child: AddPaymentDialog());
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: createHeaderBuilder(_tabController, _tabs),
        body: TabBarView(controller: _tabController, children: [
          BankOverviewTab(tabName: _tabs[0], child: PersonSummaryList()),
          BankOverviewTab(tabName: _tabs[1], child: ExpenseList())
        ]),
      ),
      drawer: Drawer(
        child: BankOverviewDrawer(
          onCreateWalletDialog: () => _showCreateWallet(context),
        ),
      ),
      floatingActionButton: BankOverviewFAB(
        onAddParticipant: () => _showAddParticipantDialog(context),
        onAddExpense: () => _showAddPaymentDialog(context),
      ),
    ));
  }
}
