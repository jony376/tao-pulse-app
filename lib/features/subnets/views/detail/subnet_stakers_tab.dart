import 'package:flutter/material.dart';

import '../../models/subnet_info.dart';
import '../../models/subnet_metrics.dart';
import '../../../../theme/theme.dart';
import 'subnet_detail_formatters.dart';

class SubnetStakersTab extends StatelessWidget {
  const SubnetStakersTab({super.key, required this.data});

  final SubnetInfo data;

  @override
  Widget build(BuildContext context) {
    final stakers = data.stakers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SubnetStakersOverviewCard(stakers: stakers),
        const SizedBox(height: AppSpacing.section),
        Text(
          'TOP VALIDATORS',
          style: FigmaTypography.compactBodySmallMedium.copyWith(
            color: FigmaColors.textNeutralInversePrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Column(
          children: [
            for (
              var index = 0;
              index < stakers.topValidators.length;
              index++
            ) ...[
              if (index > 0) const SizedBox(height: AppSpacing.sm),
              _TopValidatorRow(
                validator: stakers.topValidators[index],
                dotColor: _validatorDotColor(index),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Color _validatorDotColor(int index) {
    return switch (index) {
      0 => FigmaColors.brandSecondary,
      1 => FigmaColors.successBold,
      2 => FigmaColors.brandTertiary,
      _ => FigmaColors.neutralDisabled,
    };
  }
}

class _SubnetStakersOverviewCard extends StatelessWidget {
  const _SubnetStakersOverviewCard({required this.stakers});

  final SubnetStakers stakers;

  @override
  Widget build(BuildContext context) {
    final isOpen = (stakers.registrationLabel ?? '').toUpperCase() == 'OPEN';

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
          _StakersStatRow(
            label: 'Validator Slots',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${stakers.validatorSlotsFilled ?? '--'}/${stakers.validatorSlotsTotal ?? '--'}',
                  style: FigmaTypography.bodySmallSemibold.copyWith(
                    color: FigmaColors.textNeutralPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _StatusPill(
                  label: stakers.registrationLabel ?? '--',
                  isOpen: isOpen,
                ),
              ],
            ),
          ),
          const _SectionDivider(),
          _StakersStatRow(
            label: 'Staker Apy',
            trailing: Text(
              formatPercentWhole(stakers.stakerApyPercent) ?? '--',
              style: FigmaTypography.bodySmallSemibold.copyWith(
                color: FigmaColors.textNeutralPrimary,
              ),
            ),
          ),
          const _SectionDivider(),
          _StakersStatRow(
            label: 'Est.per Validator',
            trailing: Text(
              formatEstimatedValidator(
                    stakers.estimatedValidatorEpochTau,
                    stakers.estimatedValidatorJ,
                  ) ??
                  '--',
              style: FigmaTypography.bodySmallSemibold.copyWith(
                color: FigmaColors.textNeutralPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StakersStatRow extends StatelessWidget {
  const _StakersStatRow({required this.label, required this.trailing});

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

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

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

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.isOpen});

  final String label;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: isOpen ? FigmaColors.successBold : FigmaColors.neutralDisabled,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: FigmaTypography.caption.copyWith(
          color: isOpen
              ? FigmaColors.textSuccessBold
              : FigmaColors.textNeutralPrimary,
        ),
      ),
    );
  }
}

class _TopValidatorRow extends StatelessWidget {
  const _TopValidatorRow({required this.validator, required this.dotColor});

  final SubnetTopValidator validator;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: FigmaColors.neutralPrimary,
        borderRadius: BorderRadius.circular(AppRadius.l),
        border: Border.all(color: FigmaColors.neutralSecondary),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 14,
            child: Text(
              validator.rank.toString(),
              style: FigmaTypography.footnote.copyWith(
                color: FigmaColors.textNeutralTertiary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              validator.name,
              style: FigmaTypography.compactBodySmallMedium.copyWith(
                color: FigmaColors.textNeutralPrimary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            formatValidatorTake(validator.takePercent) ?? '--',
            style: FigmaTypography.caption.copyWith(
              color: FigmaColors.textNeutralTertiary,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Text(
            formatTaoCompact(validator.stakeTao) ?? '--',
            style: FigmaTypography.compactBodySmallMedium.copyWith(
              color: FigmaColors.brandSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
