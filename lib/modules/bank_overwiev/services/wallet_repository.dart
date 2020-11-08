import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Wallet.dart';

@immutable
class WalletRepository {
  final Database db;

  WalletRepository(this.db);

  static String get tableName => 'Wallet';
  static String get init => '''
  create table $tableName (
    ${Wallet.idField} text primary key,
    ${Wallet.nameField} text not null,
    ${Wallet.currencyField} text not null
  );
  ''';

  Future<Wallet> insert(Wallet wallet) async {
    await db.insert(tableName, wallet.toMap());
    return wallet;
  }

  Future<List<Wallet>> getAll() async {
    final wallets = await db.query(tableName);
    return wallets.map((data) => Wallet.fromMap(data)).toList();
  }

  Future<String> delete(String walletId) async {
    await db.delete(tableName,
        where: '${Wallet.idField} = ?', whereArgs: [walletId]);
    return walletId;
  }
}
