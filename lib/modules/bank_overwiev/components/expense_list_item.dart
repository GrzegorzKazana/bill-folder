import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  final String expense;

  ExpenseListItem({@required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 100),
            child: Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 120),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: FittedBox(
                          child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '22',
                              style: Theme.of(context).textTheme.headline1),
                          TextSpan(
                              text: 'PLN',
                              style: Theme.of(context).textTheme.headline3),
                        ]),
                      ))),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Grzegorz K',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline5),
                            Text('26-10-2020',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6),
                            Text('shopping, stuff, tickets',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle1)
                          ])),
                ),
                PopupMenuButton(
                    itemBuilder: (_) => [
                          PopupMenuItem<String>(
                              child: Text('Edit'), value: 'Edit'),
                          PopupMenuItem<String>(
                              child: Text('Delete'), value: 'Delete'),
                        ]),
              ],
            )));
  }
}
