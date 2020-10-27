import 'package:flutter/material.dart';

class PersonBillSummaryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(left: 8, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'Money spent:',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          '123\$',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'Number of payments:',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          '8',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Expanded(
                            child: Text(
                          'Date of last payment:',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        )),
                        Text(
                          '25-10-2020',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text("VIEW", style: TextStyle(fontSize: 16))),
                    TextButton(
                        onPressed: () {},
                        child: Text("ADD", style: TextStyle(fontSize: 16)))
                  ],
                ))
          ],
        ));
  }
}
