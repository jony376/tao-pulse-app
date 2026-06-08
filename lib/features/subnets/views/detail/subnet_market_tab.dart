import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/subnet_info.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/buttons/outlined_text_button.dart';
import 'subnet_detail_formatters.dart';

enum SubnetMarketRange { day24, day7, day30 }

extension on SubnetMarketRange {
  String get label => switch (this) {
    SubnetMarketRange.day24 => '24h',
    SubnetMarketRange.day7 => '7d',
    SubnetMarketRange.day30 => '30d',
  };
}

class SubnetMarketTab extends StatelessWidget {
  const SubnetMarketTab({
    super.key,
    required this.data,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  final SubnetInfo data;
  final SubnetMarketRange selectedRange;
  final ValueChanged<SubnetMarketRange> onRangeSelected;

  @override
  Widget build(BuildContext context) {
    final market = data.market;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 180 / 89,
          children: [
            _MarketMetricCard(
              label: 'Alpha Price',
              value: formatPriceTao(market.price) ?? '--',
              subValue: formatPercent(market.priceTrend),
              subValueColor: FigmaColors.textSuccessSubtle,
              leadingIcon: Icons.arrow_upward_rounded,
            ),
            _MarketMetricCard(
              label: 'Market Cap',
              value: formatTaoCompact(market.marketCap) ?? '--',
              subValue: formatUsdCompact(market.marketCapUsd),
            ),
            _MarketMetricCard(
              label: 'TAO Locked',
              value: formatTaoCompact(market.taoLocked) ?? '--',
              subValue: 'Total staked',
            ),
            _MarketMetricCard(
              label: 'Emissions',
              value: market.emissionsPerHour?.toStringAsFixed(1) ?? '--',
              subValue: 'TAO/hr',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        _SubnetPriceChartCard(
          data: data,
          selectedRange: selectedRange,
          onRangeSelected: onRangeSelected,
        ),
      ],
    );
  }
}

class _MarketMetricCard extends StatelessWidget {
  const _MarketMetricCard({
    required this.label,
    required this.value,
    this.subValue,
    this.subValueColor = FigmaColors.textNeutralTertiary,
    this.leadingIcon,
  });

  final String label;
  final String value;
  final String? subValue;
  final Color subValueColor;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
      decoration: BoxDecoration(
        color: FigmaColors.neutralPrimary,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: FigmaColors.neutralSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: FigmaTypography.caption.copyWith(
              color: FigmaColors.textNeutralTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: FigmaTypography.compactBodySmallMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: FigmaColors.textNeutralPrimary,
            ),
          ),
          const SizedBox(height: 5),
          if (subValue != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, size: 12, color: subValueColor),
                  const SizedBox(width: 1),
                ],
                Text(
                  subValue!,
                  style: FigmaTypography.caption.copyWith(color: subValueColor),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _SubnetPriceChartCard extends StatelessWidget {
  const _SubnetPriceChartCard({
    required this.data,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  final SubnetInfo data;
  final SubnetMarketRange selectedRange;
  final ValueChanged<SubnetMarketRange> onRangeSelected;

  @override
  Widget build(BuildContext context) {
    final market = data.market;
    final chartColor = (market.priceTrend ?? 0) >= 0
        ? FigmaColors.textSuccessSubtle
        : const Color(0xFFF87171);
    final chartPoints = _resolvePoints(market.priceHistory, selectedRange);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Now',
                      style: FigmaTypography.footnote.copyWith(
                        color: FigmaColors.textNeutralTertiary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${(chartPoints.isNotEmpty ? chartPoints.last : market.price ?? 0).toStringAsFixed(6)} T',
                      style: FigmaTypography.h7Regular.copyWith(
                        fontWeight: FontWeight.w500,
                        color: chartColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${formatUsdRegular(market.alphaUsdPrice) ?? '--'} per alpha',
                      style: FigmaTypography.compactBodySmallMedium.copyWith(
                        color: FigmaColors.textNeutralTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  for (final range in SubnetMarketRange.values) ...[
                    if (range != SubnetMarketRange.values.first)
                      const SizedBox(width: 5),
                    OutlinedTextButton(
                      label: range.label,
                      selected: range == selectedRange,
                      onPressed: () => onRangeSelected(range),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 10,
                      ),
                      backgroundColor: FigmaColors.neutralPrimary,
                      selectedBackgroundColor: FigmaColors.neutralSecondary,
                      borderColor: FigmaColors.iconNeutralInverseTertiary,
                      textColor: FigmaColors.textNeutralTertiary,
                      selectedTextColor: FigmaColors.brandSecondary,
                      borderRadius: 15,
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 132,
            child: CustomPaint(
              painter: _SubnetLineChartPainter(
                points: chartPoints,
                strokeColor: chartColor,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        (market.priceTrend ?? 0) >= 0
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 12,
                        color: chartColor,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        formatPercentPrecise(market.priceTrend) ?? '--',
                        style: FigmaTypography.caption.copyWith(
                          color: chartColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        selectedRange.label,
                        style: FigmaTypography.caption.copyWith(
                          color: FigmaColors.textNeutralInversePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _ChartStat(
                  label: 'Vol 24h',
                  value: formatUsdCompact(market.volume24h) ?? '--',
                ),
              ),
              Expanded(
                child: _ChartStat(
                  label: 'Liquidity',
                  value: formatTaoSuffix(market.liquidity) ?? '--',
                ),
              ),
              Expanded(
                child: _ChartStat(
                  label: 'Health',
                  value: '${market.healthScore ?? '--'}/100',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<double> _resolvePoints(List<double> source, SubnetMarketRange range) {
    if (source.isEmpty) {
      return const [0.064, 0.059, 0.061, 0.058];
    }
    return switch (range) {
      SubnetMarketRange.day24 => source,
      SubnetMarketRange.day7 => _compress(source, 12),
      SubnetMarketRange.day30 => _compress(source, 8),
    };
  }

  List<double> _compress(List<double> source, int target) {
    if (source.length <= target) {
      return source;
    }
    final result = <double>[];
    for (var i = 0; i < target; i++) {
      final index = ((source.length - 1) * (i / (target - 1))).round();
      result.add(source[index]);
    }
    return result;
  }
}

class _ChartStat extends StatelessWidget {
  const _ChartStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FigmaTypography.footnote.copyWith(
            color: FigmaColors.textNeutralTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Roboto Mono',
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: FigmaColors.textNeutralPrimary,
          ),
        ),
      ],
    );
  }
}

class _SubnetLineChartPainter extends CustomPainter {
  const _SubnetLineChartPainter({
    required this.points,
    required this.strokeColor,
  });

  final List<double> points;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) {
      return;
    }

    final minValue = points.reduce(math.min);
    final maxValue = points.reduce(math.max);
    final valueRange = math.max(maxValue - minValue, 0.0001);

    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = (size.width / (points.length - 1)) * i;
      final normalizedY = (points[i] - minValue) / valueRange;
      final y = size.height - (normalizedY * (size.height - 12)) - 6;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        strokeColor.withValues(alpha: 0.35),
        strokeColor.withValues(alpha: 0),
      ],
    );

    final fillPaint = Paint()
      ..shader = gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _SubnetLineChartPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.strokeColor != strokeColor;
  }
}
