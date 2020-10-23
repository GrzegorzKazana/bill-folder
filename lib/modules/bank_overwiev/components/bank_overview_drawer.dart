import 'package:flutter/material.dart';

class BankOverviewDrawer extends StatelessWidget {
  Widget _buildDrawerListItem({IconData icon, String title}) {
    return ListTile(
        leading: Icon(icon, size: 28),
        title: Text(title, style: TextStyle(fontSize: 24)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.orange),
          child: Text("Bill folder",
              style: TextStyle(color: Colors.white, fontSize: 32)),
        ),
        _buildDrawerListItem(icon: Icons.ac_unit, title: "Switch the AC unit"),
        _buildDrawerListItem(icon: Icons.fastfood, title: "End world hunger"),
      ],
    );
  }
}
