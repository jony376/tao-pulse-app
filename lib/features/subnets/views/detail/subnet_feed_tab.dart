import 'package:flutter/material.dart';

import '../../models/subnet_info.dart';
import '../../models/subnet_metrics.dart';
import '../../../../theme/theme.dart';

class SubnetFeedTab extends StatelessWidget {
  const SubnetFeedTab({super.key, required this.data});

  final SubnetInfo data;

  @override
  Widget build(BuildContext context) {
    final signals = data.feed.recentSignals;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Recent signals',
          style: FigmaTypography.compactBodySmallMedium.copyWith(
            color: FigmaColors.textNeutralInversePrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Column(
          children: [
            for (var index = 0; index < signals.length; index++) ...[
              _SubnetFeedRow(signal: signals[index]),
              if (index < signals.length - 1)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: FigmaColors.neutralSecondary,
                ),
            ],
          ],
        ),
      ],
    );
  }
}

class _SubnetFeedRow extends StatelessWidget {
  const _SubnetFeedRow({required this.signal});

  final SubnetSignal signal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: _dotColor(signal.dotColor),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              signal.message,
              style: FigmaTypography.compactBodySmallRegular.copyWith(
                color: FigmaColors.textNeutralInversePrimary,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Text(
            signal.timeAgo,
            style: FigmaTypography.footnote.copyWith(
              color: FigmaColors.textNeutralInversePrimary,
            ),
          ),
        ],
      ),
    );
  }

  Color _dotColor(String value) {
    return switch (value) {
      'success' => FigmaColors.successBold,
      'warning' => FigmaColors.brandTertiary,
      'brand' => FigmaColors.brandPrimary,
      _ => FigmaColors.neutralDisabled,
    };
  }
}
