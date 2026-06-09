import 'package:flutter/material.dart';

import '../../models/subnet_info.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/app_top_bar.dart';
import '../../../../widgets/buttons/app_back_button.dart';
import '../../../../widgets/buttons/app_icon_button.dart';
import '../../../../widgets/tab_page_scaffold.dart';
import 'subnet_feed_tab.dart';
import 'subnet_info_section.dart';
import 'subnet_market_tab.dart';
import 'subnet_metric_tabs.dart';

class SubnetDetailPage extends StatefulWidget {
  const SubnetDetailPage({super.key, required this.data});

  final SubnetInfo data;

  @override
  State<SubnetDetailPage> createState() => _SubnetDetailPageState();
}

class _SubnetDetailPageState extends State<SubnetDetailPage> {
  SubnetPrimaryTab _selectedTab = SubnetPrimaryTab.market;
  SubnetMarketRange _selectedRange = SubnetMarketRange.day24;

  @override
  Widget build(BuildContext context) {
    final subnetInfo = widget.data;
    final subnet = subnetInfo.subnet;

    return TabPageScaffold(
      appBar: TopBar(
        left: AppBackButton(onPressed: () => Navigator.of(context).maybePop()),
        title: subnet.name,
        right: _SubnetDetailTopBarActions(watching: subnet.watching),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              0,
            ),
            child: SubnetInfoSection(data: subnetInfo),
          ),
          const SizedBox(height: 32),
          SubnetMetricTabs(
            selectedTab: _selectedTab,
            onSelected: (tab) => setState(() => _selectedTab = tab),
            horizontalPadding: AppSpacing.lg,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.xxl,
              ),
              child: switch (_selectedTab) {
                SubnetPrimaryTab.market => SubnetMarketTab(
                  data: subnetInfo,
                  selectedRange: _selectedRange,
                  onRangeSelected: (range) =>
                      setState(() => _selectedRange = range),
                ),
                SubnetPrimaryTab.stakers => const _DetailPlaceholder(
                  title: 'Stakers',
                  description:
                      'Staker analytics will appear here once this view is connected.',
                ),
                SubnetPrimaryTab.miners => const _DetailPlaceholder(
                  title: 'Miners',
                  description:
                      'Miner activity and rankings will appear here once this view is connected.',
                ),
                SubnetPrimaryTab.feed => SubnetFeedTab(data: subnetInfo),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SubnetDetailTopBarActions extends StatelessWidget {
  const _SubnetDetailTopBarActions({required this.watching});

  final bool watching;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIconButton(
          onPressed: () {},
          backgroundColor: FigmaColors.neutralSecondary,
          borderColor: FigmaColors.neutralSecondary,
          borderRadius: AppRadius.full,
          icon: Icon(
            watching ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          ),
          iconColor: watching
              ? FigmaColors.brandSecondary
              : FigmaColors.iconNeutralPrimary,
        ),
        const SizedBox(width: 6),
        AppIconButton(
          onPressed: () {},
          backgroundColor: FigmaColors.neutralSecondary,
          borderColor: FigmaColors.neutralSecondary,
          borderRadius: AppRadius.full,
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}

class _DetailPlaceholder extends StatelessWidget {
  const _DetailPlaceholder({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: FigmaColors.neutralPrimary,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: FigmaColors.neutralSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FigmaTypography.h7Semibold.copyWith(
              color: FigmaColors.textNeutralPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            style: FigmaTypography.compactBodySmallRegular.copyWith(
              color: FigmaColors.textNeutralTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
