import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'wallet_repository.dart';
import '../models/Wallet.dart';
import '../models/Participant.dart';

@immutable
class ParticipantRepository {
  final Database db;

  ParticipantRepository(this.db);

  static String get tableName => 'Participant';
  static String get init => '''
  create table $tableName (
    ${Participant.idField} text primary key,
    ${Participant.walletIdField} text not null,
    ${Participant.nameField} text not null,
    ${Participant.avatarColorField} integer not null,
    foreign key (${Participant.walletIdField}) references ${WalletRepository.tableName}(${Wallet.idField}) on delete cascade
  );
  ''';

  Future<Participant> insert(Participant participant) async {
    await db.insert(tableName, participant.toMap());
    return participant;
  }

  Future<List<Participant>> getByWalletId(String walletId) async {
    final participants = await db.query(tableName,
        where: '${Participant.walletIdField} = ?', whereArgs: [walletId]);

    return participants.map((data) => Participant.fromMap(data)).toList();
  }
}
