import 'package:flutter/material.dart';

class PersonBillSummaryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Test",
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {},
                child: Text("VIEW", style: TextStyle(fontSize: 16))),
            TextButton(
                onPressed: () {},
                child: Text("ADD", style: TextStyle(fontSize: 16)))
          ],
        )
      ],
    );
  }
}
