import 'package:flutter/material.dart';

import '../modules/bank_overwiev/ui/drawer/index.dart';
import '../modules/bank_overwiev/ui/common/bank_overview_fab.dart';
import '../modules/bank_overwiev/ui/common/bank_overview_tab.dart';
import '../modules/bank_overwiev/ui/bank_header/index.dart';
import '../modules/bank_overwiev/ui/participant_list/index.dart';
import '../modules/bank_overwiev/ui/expense_list/index.dart';
import '../modules/bank_overwiev/ui/participant_list/add_participant_dialog.dart';
import '../modules/bank_overwiev/ui/expense_list/add_payment_dialog.dart';
import '../modules/bank_overwiev/ui/drawer/add_wallet_dialog.dart';

class BakOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BankOverviewPageState();
}

class _BankOverviewPageState extends State<BakOverviewPage>
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
          BankOverviewTabContent(
              tabName: _tabs[0], child: ParticipantSummaryList()),
          BankOverviewTabContent(tabName: _tabs[1], child: ExpenseList())
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
