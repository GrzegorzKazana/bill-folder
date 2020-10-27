import 'package:flutter/material.dart';

import 'package:bill_folder/common/utils/format_date.dart';

class DateInput extends StatelessWidget {
  final DateTime paymentDate;
  final void Function() onTap;

  DateInput({@required this.paymentDate, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
          child: Text(formatDate(paymentDate),
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.headline5)),
    );
  }
}
