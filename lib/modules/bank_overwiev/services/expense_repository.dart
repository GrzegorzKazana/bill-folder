import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'participant_repository.dart';
import 'wallet_repository.dart';
import '../models/Expense.dart';
import '../models/Participant.dart';
import '../models/Wallet.dart';

@immutable
class ExpenseRepository {
  final Database db;

  ExpenseRepository(this.db);

  static String get tableName => 'Expense';
  static String get init => '''
  create table $tableName (
    ${Expense.idField} text primary key,
    ${Expense.payerIdField} text not null,
    ${Expense.priceField} text not null,
    ${Expense.dateField} text not null,
    ${Expense.tagsField} text not null,
    foreign key (${Expense.payerIdField}) references ${ParticipantRepository.tableName}(${Participant.idField}) on delete cascade
  );
  ''';

  Future<Expense> insert(Expense expense) async {
    await db.insert(tableName, expense.toMap());
    return expense;
  }

  Future<String> delete(String expenseId) async {
    await db.delete(tableName,
        where: '${Expense.idField} = ?', whereArgs: [expenseId]);
    return expenseId;
  }

  Future<Expense> update(Expense expense) async {
    await db.update(tableName, expense.toMap(),
        where: '${Expense.idField} = ?', whereArgs: [expense.id]);
    return expense;
  }

  Future<List<Expense>> getAllByWalletId(String walletId) async {
    final expenses = await db.rawQuery('''
    select $tableName.*
    from $tableName
    inner join ${ParticipantRepository.tableName}
      on $tableName.${Expense.payerIdField} = ${ParticipantRepository.tableName}.${Participant.idField}
    inner join ${WalletRepository.tableName}
      on ${ParticipantRepository.tableName}.${Participant.walletIdField} = ${WalletRepository.tableName}.${Wallet.idField}
    where ${WalletRepository.tableName}.${Wallet.idField} = ?;
    ''', [walletId]);

    return expenses.map((data) => Expense.fromMap(data)).toList();
  }
}
