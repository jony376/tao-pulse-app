import 'package:flutter/material.dart';

import '../../models/subnet_info.dart';
import '../../models/subnet_metrics.dart';
import '../../../../theme/theme.dart';
import 'subnet_detail_formatters.dart';

class SubnetMinersTab extends StatelessWidget {
  const SubnetMinersTab({super.key, required this.data});

  final SubnetInfo data;

  @override
  Widget build(BuildContext context) {
    return _SubnetMinersOverviewCard(
      miners: data.miners,
      alphaToken: data.subnet.alphaToken,
    );
  }
}

class _SubnetMinersOverviewCard extends StatelessWidget {
  const _SubnetMinersOverviewCard({
    required this.miners,
    required this.alphaToken,
  });

  final SubnetMiners miners;
  final String alphaToken;

  @override
  Widget build(BuildContext context) {
    final isOpen = (miners.registrationLabel ?? '').toUpperCase() == 'OPEN';

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: FigmaColors.neutralPrimary,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: FigmaColors.neutralSecondary),
      ),
      child: Column(
        children: [
          _MinersStatRow(
            label: 'Active miners',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${miners.activeMiners ?? '--'}/${miners.totalMinerSlots ?? '--'}',
                  style: FigmaTypography.bodySmallSemibold.copyWith(
                    color: FigmaColors.textNeutralPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _MinerStatusPill(
                  label: miners.registrationLabel ?? '--',
                  backgroundColor: isOpen
                      ? FigmaColors.successBold
                      : FigmaColors.neutralDisabled,
                  textColor: isOpen
                      ? FigmaColors.textSuccessBold
                      : FigmaColors.textNeutralPrimary,
                ),
              ],
            ),
          ),
          const _MinerSectionDivider(),
          _MinersStatRow(
            label: 'Competition',
            trailing: _MinerStatusPill(
              label: miners.competitionLabel ?? '--',
              backgroundColor: FigmaColors.errorBold,
              textColor: FigmaColors.textErrorBold,
            ),
          ),
          const _MinerSectionDivider(),
          _MinersStatRow(
            label: 'Est. daily earn',
            trailing: Text(
              formatAlphaPerDay(
                    miners.estimatedDailyEarnAlpha,
                    symbol: alphaToken,
                  ) ??
                  '--',
              style: FigmaTypography.bodySmallSemibold.copyWith(
                color: FigmaColors.textNeutralPrimary,
              ),
            ),
          ),
          const _MinerSectionDivider(),
          _MinersStatRow(
            label: 'Hardware needed',
            trailing: _MinerStatusPill(
              label: miners.hardwareNeeded ?? '--',
              backgroundColor: FigmaColors.infoBold,
              textColor: FigmaColors.textInfoBold,
            ),
          ),
        ],
      ),
    );
  }
}

class _MinersStatRow extends StatelessWidget {
  const _MinersStatRow({required this.label, required this.trailing});

  final String label;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: FigmaTypography.compactBodySmallRegular.copyWith(
              color: FigmaColors.textNeutralTertiary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Flexible(child: trailing),
      ],
    );
  }
}

class _MinerSectionDivider extends StatelessWidget {
  const _MinerSectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Divider(
        height: 1,
        thickness: 1,
        color: FigmaColors.neutralSecondary,
      ),
    );
  }
}

class _MinerStatusPill extends StatelessWidget {
  const _MinerStatusPill({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: FigmaTypography.caption.copyWith(color: textColor),
      ),
    );
  }
}
