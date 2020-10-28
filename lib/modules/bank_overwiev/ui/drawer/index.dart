import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_wallet_dialog.dart';
import '../../models/Wallet.dart';
import '../../state/bank_overview_state.dart';

class BankOverviewDrawer extends StatelessWidget {
  Future<void> _showCreateWallet(BuildContext context) async {
    final maybeWallet =
        await showDialog<Wallet>(context: context, child: AddWalletDialog());

    if (maybeWallet != null) {
      Navigator.of(context).pop();
      Provider.of<BankOverviewState>(context, listen: false)
          .addWallet(maybeWallet);
    }
  }

  Widget _buildDrawerListItem(
      {IconData icon, String title, VoidCallback onTap, bool highlight}) {
    final textStyle = TextStyle(
        fontSize: 24,
        fontWeight: highlight != null && highlight
            ? FontWeight.bold
            : FontWeight.normal);

    return InkWell(
        onTap: onTap,
        child: ListTile(
            leading: Icon(icon, size: 28),
            title: Text(title, style: textStyle)));
  }

  void _handleTapOnWallet(BuildContext context, Wallet wallet) {
    Navigator.of(context).pop();
    Provider.of<BankOverviewState>(context, listen: false)
        .switchToWallet(wallet.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BankOverviewState>();
    final currentWallet = state.currentWallet;
    final wallets = state.wallets.map((wallet) => _buildDrawerListItem(
        icon: Icons.monetization_on,
        title: wallet.name,
        highlight: currentWallet == wallet,
        onTap: () => _handleTapOnWallet(context, wallet)));

    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.orange),
          child: Text("Bill folder",
              style: TextStyle(color: Colors.white, fontSize: 32)),
        ),
        ...wallets,
        if (wallets.isNotEmpty) Divider(),
        _buildDrawerListItem(
            icon: Icons.add_circle,
            title: "Create new wallet",
            onTap: () => _showCreateWallet(context)),
      ],
    );
  }
}
