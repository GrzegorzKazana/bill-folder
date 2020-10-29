import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';

import 'bank_summary_bar.dart';
import 'bank_app_bar.dart';
import 'bank_tab_header.dart';

import '../../models/Currency.dart';
import '../../state/bank_overview_state.dart';

typedef List<Widget> HeaderSliverBuilder(
    BuildContext context, bool innerBoxIsScrolled);

HeaderSliverBuilder createHeaderBuilder(
    TabController tabController, List<String> tabNames) {
  return (BuildContext context, bool innerBoxIsScrolled) {
    final walletName = context
            .select<BankOverviewState, String>((s) => s.currentWallet?.name) ??
        'Unknown';

    final walletCost = context
        .select<BankOverviewState, Monetary>((s) => s.totalCostOfCurrentWallet);

    final numberOfParticipants =
        context.select<BankOverviewState, int>((s) => s.numberOfParticipants);

    final currency = context
        .select<BankOverviewState, Currency>((s) => s.currentWalletCurrency);

    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: BankAppBar(
          walletName: walletName,
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: BankSummaryBarDelegate(
          walletCurrency: currency,
          costOfWallet: walletCost,
          numberOfParticipants: numberOfParticipants,
        ),
      ),
      SliverPersistentHeader(
          pinned: true,
          delegate: BandTabPersistentHeaderDelegate(
              bankTabHeader(tabNames, tabController),
              color: Theme.of(context).colorScheme.primary)),
    ];
  };
}
