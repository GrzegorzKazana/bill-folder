import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/drawer/index.dart';
import 'ui/common/bank_overview_fab.dart';
import 'ui/common/bank_overview_tab.dart';
import 'ui/bank_header/index.dart';
import 'ui/participant_list/index.dart';
import 'ui/expense_list/index.dart';
import 'ui/participant_list/add_participant_dialog.dart';
import 'ui/expense_list/add_payment_dialog.dart';

import './models/Participant.dart';
import './models/Currency.dart';
import './models/Expense.dart';
import './state/bank_overview_state.dart';

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

  Future<void> _showAddParticipantDialog(BuildContext context) async {
    showDialog<String>(context: context, child: AddParticipantDialog());
  }

  Future<void> _showAddPaymentDialog(BuildContext context) async {
    showDialog(context: context, child: AddPaymentDialog());
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
        create: (_) => BankOverviewState(),
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: createHeaderBuilder(_tabController, _tabs),
            body: Builder(builder: (context) {
              final participants =
                  context.select<BankOverviewState, List<ParticipantWithStats>>(
                      (s) => s.participantsWithStats);

              final expenses = context
                  .select<BankOverviewState, List<Expense>>((s) => s.expenses);

              final currency = context.select<BankOverviewState, Currency>(
                  (s) => s.currentWalletCurrency);

              return TabBarView(controller: _tabController, children: [
                BankOverviewTabContent(
                    tabName: _tabs[0],
                    child: ParticipantSummaryList(
                        walletCurrency: currency, participants: participants)),
                BankOverviewTabContent(
                    tabName: _tabs[1],
                    child: ExpenseList(
                      expenses: expenses,
                      walletCurrency: currency,
                      participants: participants.map((p) => p.info).toList(),
                    ))
              ]);
            }),
          ),
          drawer: Drawer(
            child: BankOverviewDrawer(),
          ),
          floatingActionButton: BankOverviewFAB(
            onAddParticipant: () => _showAddParticipantDialog(context),
            onAddExpense: () => _showAddPaymentDialog(context),
          ),
        ));
  }
}
