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
import './state/detail_state.dart';
import './state/wallet_state.dart';

class BakOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BankOverviewPageState();
}

class _BankOverviewPageState extends State<BakOverviewPage>
    with SingleTickerProviderStateMixin {
  final _tabs = ["Participants", "Expenses"];
  Participant _selectedParticipant;
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

  void _navigateToFilteredExpenseList(Participant participant) {
    setState(() => _selectedParticipant = participant);

    // navigate after state is set and component is rebuilt
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _tabController.animateTo(1));
  }

  Future<void> _showAddParticipantDialog(BuildContext context) async {
    final wallet = Provider.of<WalletState>(context, listen: false);

    final participant = await showDialog<Participant>(
        context: context,
        child: AddParticipantDialog(walletId: wallet.currentWalletId));

    if (participant == null) return;

    Provider.of<WalletDetailState>(context, listen: false)
        .addParticipant(participant);
  }

  Future<void> _showAddPaymentDialog(BuildContext context,
      {Participant initialPayer}) async {
    final wallet = Provider.of<WalletState>(context, listen: false);
    final detail = Provider.of<WalletDetailState>(context, listen: false);

    final expense = await showDialog(
        context: context,
        child: AddPaymentDialog(
            walletCurrency: wallet.currentWalletCurrency,
            participants: detail.participants,
            initialPayer: initialPayer));

    if (expense == null) return;

    detail.addExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: createHeaderBuilder(_tabController, _tabs),
        body: Builder(builder: (context) {
          final participants =
              context.select<WalletDetailState, List<ParticipantWithStats>>(
                  (s) => s.participantsWithStats);

          final expenses = context
              .select<WalletDetailState, List<Expense>>((s) => s.expenses);

          final currency = context
              .select<WalletState, Currency>((s) => s.currentWalletCurrency);

          return TabBarView(controller: _tabController, children: [
            BankOverviewTabContent(
                tabName: _tabs[0],
                child: ParticipantSummaryList(
                  walletCurrency: currency,
                  participants: participants,
                  showAddPaymentWithPayer: _showAddPaymentDialog,
                  navigateToFilteredExpenseList: _navigateToFilteredExpenseList,
                )),
            BankOverviewTabContent(
                tabName: _tabs[1],
                child: ExpenseList(
                    expenses: expenses,
                    walletCurrency: currency,
                    participants: participants.map((p) => p.info).toList(),
                    selectedParticipant: _selectedParticipant,
                    onSelectedParticipantChange: (val) =>
                        setState(() => _selectedParticipant = val)))
          ]);
        }),
      ),
      drawer: Drawer(
        child: BankOverviewDrawer(),
      ),
      floatingActionButton: Builder(
          builder: (context) => BankOverviewFAB(
                onAddParticipant: () => _showAddParticipantDialog(context),
                onAddExpense: () => _showAddPaymentDialog(context),
              )),
    );
  }
}
