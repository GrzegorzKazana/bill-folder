import 'package:flutter/material.dart';

class BankAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      expandedHeight: 75,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("Thingy thing", style: TextStyle(fontSize: 20)),
        titlePadding: EdgeInsets.symmetric(vertical: 12),
      ),
      elevation: 0,
    );
  }
}
