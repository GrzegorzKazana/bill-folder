import 'package:flutter/material.dart';

class LabeledFormFieldContainer extends StatelessWidget {
  final String label;
  final Widget input;
  final Widget postfix;

  LabeledFormFieldContainer(
      {@required this.label, @required this.input, this.postfix});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(label, style: Theme.of(context).textTheme.headline6),
            SizedBox(width: 24),
            Expanded(child: input),
            if (postfix != null) postfix,
          ],
        ));
  }
}
