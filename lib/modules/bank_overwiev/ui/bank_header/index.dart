import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';

import 'bank_summary_bar.dart';
import 'bank_app_bar.dart';
import 'bank_tab_header.dart';
import 'bank_delete_confirm_dialog.dart';

import '../../models/Currency.dart';
import '../../state/wallet_state.dart';
import '../../state/detail_state.dart';

typedef List<Widget> HeaderSliverBuilder(
    BuildContext context, bool innerBoxIsScrolled);

HeaderSliverBuilder createHeaderBuilder(
    TabController tabController, List<String> tabNames) {
  return (BuildContext context, bool innerBoxIsScrolled) {
    final walletId =
        context.select<WalletState, String>((s) => s.currentWalletId);

    final walletName =
        context.select<WalletState, String>((s) => s.currentWallet?.name) ??
            'Unknown';

    final currency =
        context.select<WalletState, Currency>((s) => s.currentWalletCurrency);

    final walletCost =
        context.select<WalletDetailState, Monetary>((s) => s.totalCost);

    final numberOfParticipants =
        context.select<WalletDetailState, int>((s) => s.numberOfParticipants);

    final showWalletDeletConfirmDialog = (String walletId) async {
      final shouldDelete =
          await showDialog(context: context, child: BankDeleteConfirmDialog());

      if (!shouldDelete) return;

      Provider.of<WalletState>(context, listen: false).deleteWallet(walletId);
    };

    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: BankAppBar(
          walletId: walletId,
          walletName: walletName,
          onDeleteRequest: showWalletDeletConfirmDialog,
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
