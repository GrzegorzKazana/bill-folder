import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'modules/bank_overwiev/bank_overview_page.dart';
import 'modules/bank_overwiev/state/wallet_state.dart';
import 'modules/bank_overwiev/state/detail_state.dart';
import 'modules/bank_overwiev/services/expense_stats.dart';
import 'modules/bank_overwiev/services/wallet_repository.dart';
import 'modules/bank_overwiev/services/expense_repository.dart';
import 'modules/bank_overwiev/services/participant_repository.dart';
import 'modules/bank_overwiev/services/wallet_detail_repository.dart';

void main() async {
  final db = await openDatabase('bill_folder.db', version: 1,
      onCreate: (db, ver) async {
    await db.execute(WalletRepository.init);
    await db.execute(ParticipantRepository.init);
    await db.execute(ExpenseRepository.init);
  });

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final Database db;

  MyApp({@required this.db});

  @override
  Widget build(BuildContext context) {
    final providers = [
      ChangeNotifierProvider<WalletState>(
          create: (_) => WalletState(WalletRepository(db))..loadWallets()),
      ChangeNotifierProxyProvider<WalletState, WalletDetailState>(
          create: (_) => WalletDetailState(
              ExpenseStatsService(),
              WalletDetailRepository(db,
                  participantRepo: ParticipantRepository(db),
                  expenseRepo: ExpenseRepository(db))),
          update: (_, wallet, detail) => wallet.currentWallet != null
              ? (detail..loadDetails(wallet.currentWallet.id))
              : detail)
    ];

    return MaterialApp(
      title: 'Bill folder',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(providers: providers, child: BakOverviewPage()),
    );
  }
}
