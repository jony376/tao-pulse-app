import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../models/feed_item.dart';

class FeedItemTile extends StatelessWidget {
  const FeedItemTile({super.key, required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = _accentColorForCategory(item.category);
    final impactStyle = _impactStyle(item.impact);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _iconForCategory(item.category),
                color: accent,
                size: 28,
              ),
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
                          item.category.toUpperCase(),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: accent,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      Text(
                        item.timeAgo,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 22,
                            height: 1.15,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: impactStyle.$2,
                          borderRadius: BorderRadius.circular(AppRadius.button),
                        ),
                        child: Text(
                          item.impact,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: impactStyle.$1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    item.summary,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: AppColors.aiPurple.withValues(alpha: 0.95),
                        size: 16,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          item.insight,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textSecondary,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: item.tags
                        .map((tag) => _FeedTag(label: tag, color: accent))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _accentColorForCategory(String category) {
    switch (category) {
      case 'Subnet Activity':
        return AppColors.success;
      case 'Stake Movement':
        return const Color(0xFF4EA7FF);
      case 'AI Insight':
        return AppColors.aiPurple;
      default:
        return AppColors.info;
    }
  }

  IconData _iconForCategory(String category) {
    switch (category) {
      case 'Subnet Activity':
        return Icons.show_chart;
      case 'Stake Movement':
        return Icons.water_drop_outlined;
      case 'AI Insight':
        return Icons.psychology_outlined;
      default:
        return Icons.auto_graph;
    }
  }

  (Color, Color) _impactStyle(String impact) {
    switch (impact) {
      case 'High':
        return (const Color(0xFFFF7474), const Color(0x33EF4444));
      case 'Medium':
        return (const Color(0xFFFFB347), const Color(0x33F59E0B));
      case 'Low':
        return (const Color(0xFF9FBBFF), const Color(0x333B82F6));
      default:
        return (AppColors.textSecondary, Colors.white10);
    }
  }
}

class _FeedTag extends StatelessWidget {
  const _FeedTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
      ),
    );
  }
}
