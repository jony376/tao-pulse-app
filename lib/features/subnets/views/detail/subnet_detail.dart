import 'package:flutter/material.dart';

import '../../models/subnet.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/app_top_bar.dart';
import '../../../../widgets/surface_card.dart';
import '../../../../widgets/tab_page_scaffold.dart';

class SubnetDetailPage extends StatelessWidget {
  const SubnetDetailPage({super.key, required this.data});

  final Subnet data;

  @override
  Widget build(BuildContext context) {
    return TabPageScaffold(
      appBar: TopBar(
        left: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: FigmaColors.textNeutralPrimary,
            size: 18,
          ),
        ),
        title: data.name,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SurfaceCard(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _DetailChip(label: 'SN ${data.netuid}'),
                      _DetailChip(label: data.alphaToken),
                      if ((data.category ?? '').isNotEmpty)
                        _DetailChip(label: data.category!),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    data.description,
                    style: FigmaTypography.bodyRegularRegular.copyWith(
                      color: FigmaColors.textNeutralPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SurfaceCard(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: FigmaTypography.h7Semibold.copyWith(
                      color: FigmaColors.textNeutralPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _MetricRow(
                    label: 'Alpha Price',
                    value: _formatPrice(data.price),
                  ),
                  _MetricRow(
                    label: 'Price Trend',
                    value: _formatPercent(data.priceTrend),
                  ),
                  _MetricRow(
                    label: 'Market Cap',
                    value: _formatTao(data.marketCap),
                  ),
                  _MetricRow(
                    label: '24H Volume',
                    value: _formatUsd(data.volume24h),
                  ),
                  _MetricRow(
                    label: 'Emission',
                    value: _formatPercent(data.emission),
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: FigmaColors.neutralSecondary,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Text(
        label,
        style: FigmaTypography.compactBodySmallMedium.copyWith(
          color: FigmaColors.textNeutralPrimary,
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String? value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: FigmaTypography.compactBodySmallRegular.copyWith(
                color: FigmaColors.textNeutralInversePrimary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            value ?? '--',
            style: FigmaTypography.compactBodySmallMedium.copyWith(
              color: FigmaColors.textNeutralPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

String? _formatPrice(double? value) {
  if (value == null) {
    return null;
  }
  return '${value.toStringAsFixed(3)} T';
}

String? _formatPercent(double? value) {
  if (value == null) {
    return null;
  }
  return '${value.toStringAsFixed(2)}%';
}

String? _formatTao(double? value) {
  if (value == null) {
    return null;
  }
  return 'T ${_formatCompactNumber(value)}';
}

String? _formatUsd(double? value) {
  if (value == null) {
    return null;
  }
  return '\$${_formatCompactNumber(value)}';
}

String _formatCompactNumber(double value) {
  final absolute = value.abs();
  if (absolute >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(absolute >= 10000000 ? 0 : 1)}m';
  }
  if (absolute >= 1000) {
    return '${(value / 1000).toStringAsFixed(absolute >= 10000 ? 0 : 1)}k';
  }
  if (value % 1 == 0) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(2);
}
