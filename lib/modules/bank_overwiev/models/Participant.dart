import 'package:nanoid/nanoid.dart';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';

@immutable
class Participant {
  final String id;
  final String walletId;
  final String name;
  final Color avatarColor;

  static final String idField = '_id';
  static final String walletIdField = 'walletId';
  static final String nameField = 'name';
  static final String avatarColorField = 'avatarColor';

  Participant({
    @required this.walletId,
    @required this.name,
    @required this.avatarColor,
    String id,
  }) : id = id ?? nanoid();

  Participant.fromMap(Map<String, dynamic> data)
      : id = data[idField],
        walletId = data[walletIdField],
        name = data[nameField],
        avatarColor = Color(data[avatarColorField]);

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      walletIdField: walletId,
      nameField: name,
      avatarColorField: avatarColor.value,
    };
  }
}

@immutable
class Stats {
  final Monetary balance;
  final Monetary moneySpent;
  final DateTime lastPaymentDate;
  final int numberOfPayments;

  Stats(
      {@required this.balance,
      @required this.moneySpent,
      @required this.lastPaymentDate,
      @required this.numberOfPayments});
}

@immutable
class ParticipantWithStats {
  final Participant info;
  final Stats stats;

  ParticipantWithStats({@required this.info, @required this.stats});
}
