import 'package:nanoid/nanoid.dart';
import 'package:flutter/material.dart';

import 'package:bill_folder/common/models/monetary.dart';

@immutable
class Participant {
  final String id;
  final String name;
  final Color avatarColor;

  Participant({
    @required this.name,
    @required this.avatarColor,
    String id,
  }) : id = id ?? nanoid();
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
