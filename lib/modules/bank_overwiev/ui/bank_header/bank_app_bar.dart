import 'package:flutter/material.dart';

class BankAppBar extends StatelessWidget {
  final String walletId;
  final String walletName;
  final void Function(String) onDeleteRequest;

  BankAppBar(
      {@required this.walletId,
      @required this.walletName,
      @required this.onDeleteRequest});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      expandedHeight: 75,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(walletName, style: TextStyle(fontSize: 20)),
        titlePadding: EdgeInsets.symmetric(vertical: 12),
      ),
      elevation: 0,
      actions: [
        PopupMenuButton(
            onSelected: (str) {
              if (str == 'Delete' && walletId != null)
                onDeleteRequest(walletId);
            },
            itemBuilder: (_) => [
                  PopupMenuItem(
                      child: Text('Delete'),
                      enabled: walletId != null,
                      value: 'Delete'),
                ])
      ],
    );
  }
}
