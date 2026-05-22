import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/app_top_bar.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  static const _alerts = <_AlertItem>[
    _AlertItem(
      category: 'Large Stake Movement',
      title: '18,420 TAO moved into Subnet 8',
      description: 'Large wallet tao1q...x7k9 staked 18,420 TAO into Subnet 8 (Compute).',
      timeAgo: '12m ago',
      severity: 'Critical',
      color: AppColors.critical,
      icon: Icons.savings_outlined,
      primaryAction: 'View',
    ),
    _AlertItem(
      category: 'Subnet Emission Spike',
      title: 'Subnet 19 emissions increased 4.2%',
      description: 'Emission rate is higher than usual in the last 12 hours.',
      timeAgo: '38m ago',
      severity: 'High',
      color: AppColors.warning,
      icon: Icons.bar_chart_rounded,
      primaryAction: 'View Subnet',
    ),
    _AlertItem(
      category: 'Validator Rotation',
      title: '3 validators changed weights on Subnet 19',
      description: 'Weight distribution changed significantly in the last 60 minutes.',
      timeAgo: '1h ago',
      severity: 'Medium',
      color: AppColors.info,
      icon: Icons.groups_outlined,
      primaryAction: 'Open Feed',
    ),
    _AlertItem(
      category: 'Deregistration Risk',
      title: 'Miner 5F3a...9d2f at risk of deregistration',
      description: 'Rank dropped to #256 on Subnet 15. Take action soon.',
      timeAgo: '2h ago',
      severity: 'High',
      color: AppColors.success,
      icon: Icons.shield_outlined,
      primaryAction: 'View Miner',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        titleSpacing: AppSpacing.md,
        title: AppTopBar(
          title: 'Alert',
          showSearch: false,
          rightActions: [
            const AppTopBarAction(icon: Icons.search),
            AppTopBarAction(
              icon: Icons.settings_outlined,
              onPressed: () => context.push('/alerts/setup'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              4,
              AppSpacing.md,
              4,
              AppSpacing.md,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _AlertFilterChip(label: 'All', selected: true),
                  SizedBox(width: AppSpacing.md),
                  _AlertFilterChip(label: 'Unread'),
                  SizedBox(width: AppSpacing.md),
                  _AlertFilterChip(label: 'Critical'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                4,
                0,
                4,
                108,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const _SectionLabel(label: 'TODAY');
                }
                return _AlertCard(item: _alerts[index - 1]);
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: index == 0 ? AppSpacing.md : AppSpacing.sm),
              itemCount: _alerts.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertFilterChip extends StatelessWidget {
  const _AlertFilterChip({
    required this.label,
    this.selected = false,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.aiPurple.withValues(alpha: 0.95)
            : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: AppColors.textSecondary,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.item});

  final _AlertItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final severityStyle = _severityStyle(item.severity);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppRadius.smallCard),
            ),
            child: Icon(item.icon, color: item.color, size: 26),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.category,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: severityStyle.$2,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        item.severity.toUpperCase(),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: severityStyle.$1,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      item.timeAgo,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  item.title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  item.description,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.aiPurple.withValues(alpha: 0.18),
                        foregroundColor: AppColors.aiPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.sm,
                        ),
                      ),
                      child: const Text('Ask AI'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.06),
                        foregroundColor: AppColors.textPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.sm,
                        ),
                      ),
                      child: Text(item.primaryAction),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.bookmark_border,
                      color: AppColors.textSecondary.withValues(alpha: 0.95),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  (Color, Color) _severityStyle(String severity) {
    switch (severity) {
      case 'Critical':
        return (const Color(0xFFFF7474), const Color(0x33EF4444));
      case 'High':
        return (const Color(0xFFFFB347), const Color(0x33F59E0B));
      case 'Medium':
        return (const Color(0xFF67B6FF), const Color(0x333B82F6));
      default:
        return (AppColors.textSecondary, Colors.white10);
    }
  }
}

class _AlertItem {
  const _AlertItem({
    required this.category,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.severity,
    required this.color,
    required this.icon,
    required this.primaryAction,
  });

  final String category;
  final String title;
  final String description;
  final String timeAgo;
  final String severity;
  final Color color;
  final IconData icon;
  final String primaryAction;
}
