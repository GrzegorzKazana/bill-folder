import 'package:flutter/material.dart';

TabBar bankTabHeader(List<String> tabs) {
  return TabBar(
    labelColor: Colors.black87,
    unselectedLabelColor: Colors.grey,
    tabs: tabs.map((tab) => Tab(text: tab)).toList(),
  );
}

class BandTabPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  BandTabPersistentHeaderDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
      color: Colors.white,
    );
  }

  @override
  bool shouldRebuild(BandTabPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
