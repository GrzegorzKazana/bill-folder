import 'package:flutter/material.dart';

TabBar bankTabHeader(List<String> tabs, TabController controller) {
  return TabBar(
    controller: controller,
    indicatorColor: Colors.white,
    labelColor: Colors.white,
    unselectedLabelColor: Colors.white,
    indicatorWeight: 4,
    tabs: tabs.map((tab) => Tab(text: tab)).toList(),
  );
}

class BandTabPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  final Color color;

  BandTabPersistentHeaderDelegate(this._tabBar, {this.color});

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
      color: color,
    );
  }

  @override
  bool shouldRebuild(BandTabPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
