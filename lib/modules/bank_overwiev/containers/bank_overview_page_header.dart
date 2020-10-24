import 'package:flutter/material.dart';

import './bank_summary_bar.dart';
import '../components/bank_app_bar.dart';
import '../components/bank_tab_header.dart';

typedef List<Widget> HeaderSliverBuilder(
    BuildContext context, bool innerBoxIsScrolled);

HeaderSliverBuilder createHeaderBuilder(
    TabController tabController, List<String> tabNames) {
  return (BuildContext context, bool innerBoxIsScrolled) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: BankAppBar(),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: BankSummaryBarDelegate(),
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate: BandTabPersistentHeaderDelegate(
                bankTabHeader(tabNames, tabController),
                color: Theme.of(context).colorScheme.primary)),
      ];
}
