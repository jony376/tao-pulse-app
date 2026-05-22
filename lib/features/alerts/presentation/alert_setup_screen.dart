import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class AlertSetupScreen extends StatefulWidget {
  const AlertSetupScreen({super.key});

  @override
  State<AlertSetupScreen> createState() => _AlertSetupScreenState();
}

class _AlertSetupScreenState extends State<AlertSetupScreen> {
  final Map<String, bool> _activityAlerts = {
    'Emission Changes': true,
    'Large Stake Movement': true,
    'Validator Changes': true,
    'Unusual Activity': true,
    'Risk Alerts': true,
  };

  bool _githubUpdates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: Text(
          'Alert Setup',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          4,
          AppSpacing.md,
          4,
          108,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hub_outlined,
                    color: AppColors.success,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subnet 19 — Vision',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Netuid: 19',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Choose what you want to be notified about.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    'Watching',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          const _SetupSectionLabel(label: 'ACTIVITY ALERTS'),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceCard.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Column(
              children: _activityAlerts.entries
                  .map(
                    (entry) => _SetupToggleTile(
                      title: entry.key,
                      subtitle: _subtitleForActivity(entry.key),
                      icon: _iconForActivity(entry.key),
                      color: _colorForActivity(entry.key),
                      value: entry.value,
                      onChanged: (value) {
                        setState(() {
                          _activityAlerts[entry.key] = value;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          const _SetupSectionLabel(label: 'OTHER ALERTS'),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceCard.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: _SetupToggleTile(
              title: 'GitHub Updates',
              subtitle: 'Notify me about new releases and important updates.',
              icon: Icons.code,
              color: AppColors.textPrimary,
              value: _githubUpdates,
              onChanged: (value) {
                setState(() {
                  _githubUpdates = value;
                });
              },
              showDivider: false,
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.aiPurple,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'How it works',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'We send alerts only for meaningful changes. You can manage all settings anytime.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                    ),
                    child: const Text('Save Alert Settings'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _subtitleForActivity(String title) {
    switch (title) {
      case 'Emission Changes':
        return 'Notify me when emissions increase or decrease significantly.';
      case 'Large Stake Movement':
        return 'Notify me when large amounts of TAO move in or out.';
      case 'Validator Changes':
        return 'Notify me when validators change weights or activity.';
      case 'Unusual Activity':
        return 'Notify me about unusual patterns or rapid changes.';
      case 'Risk Alerts':
        return 'Notify me about potential risks like deregistration or instability.';
      default:
        return '';
    }
  }

  IconData _iconForActivity(String title) {
    switch (title) {
      case 'Emission Changes':
        return Icons.bar_chart_rounded;
      case 'Large Stake Movement':
        return Icons.trending_up;
      case 'Validator Changes':
        return Icons.groups_outlined;
      case 'Unusual Activity':
        return Icons.shield_outlined;
      case 'Risk Alerts':
        return Icons.warning_amber_rounded;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _colorForActivity(String title) {
    switch (title) {
      case 'Emission Changes':
        return AppColors.aiPurple;
      case 'Large Stake Movement':
        return AppColors.success;
      case 'Validator Changes':
        return const Color(0xFFFFA055);
      case 'Unusual Activity':
        return AppColors.info;
      case 'Risk Alerts':
        return const Color(0xFFF4C542);
      default:
        return AppColors.textPrimary;
    }
  }
}

class _SetupSectionLabel extends StatelessWidget {
  const _SetupSectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: AppColors.textSecondary,
        letterSpacing: 0.7,
      ),
    );
  }
}

class _SetupToggleTile extends StatelessWidget {
  const _SetupToggleTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
                bottom: BorderSide(color: AppColors.borderSubtle),
              )
            : null,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(AppRadius.smallCard),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
