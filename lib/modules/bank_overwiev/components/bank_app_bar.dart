import 'package:flutter/material.dart';

class BankAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("Thingy thing", style: TextStyle(fontSize: 32)),
        titlePadding: EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}
