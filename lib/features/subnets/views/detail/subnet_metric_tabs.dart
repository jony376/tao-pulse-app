import 'package:flutter/material.dart';

import '../../../../widgets/app_tab_bar.dart';

enum SubnetPrimaryTab { market, stakers, miners, feed }

extension on SubnetPrimaryTab {
  String get label => switch (this) {
    SubnetPrimaryTab.market => 'Market',
    SubnetPrimaryTab.stakers => 'stakers',
    SubnetPrimaryTab.miners => 'Miners',
    SubnetPrimaryTab.feed => 'Feed',
  };
}

class SubnetMetricTabs extends StatelessWidget {
  const SubnetMetricTabs({
    super.key,
    required this.selectedTab,
    required this.onSelected,
    this.horizontalPadding = 0,
  });

  final SubnetPrimaryTab selectedTab;
  final ValueChanged<SubnetPrimaryTab> onSelected;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final tabs = SubnetPrimaryTab.values;

    return AppTabBar(
      labels: [for (final tab in tabs) tab.label],
      selectedIndex: tabs.indexOf(selectedTab),
      onSelected: (index) => onSelected(tabs[index]),
      horizontalPadding: horizontalPadding,
    );
  }
}
