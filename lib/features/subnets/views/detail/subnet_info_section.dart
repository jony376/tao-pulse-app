import 'package:flutter/material.dart';

import '../../models/subnet_info.dart';
import '../../../../theme/theme.dart';
import 'subnet_detail_formatters.dart';

class SubnetInfoSection extends StatelessWidget {
  const SubnetInfoSection({super.key, required this.data});

  final SubnetInfo data;

  @override
  Widget build(BuildContext context) {
    final subnet = data.subnet;
    final network = data.network;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _SubnetBadge(label: 'SN ${subnet.netuid}'),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subnet.name,
                          style: FigmaTypography.h7Semibold.copyWith(
                            color: FigmaColors.textNeutralPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          subnet.category ?? 'Uncategorized',
                          style: FigmaTypography.compactBodySmallMedium
                              .copyWith(
                                color: FigmaColors.textNeutralInversePrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                subnet.description,
                style: FigmaTypography.compactBodySmallRegular.copyWith(
                  color: FigmaColors.textNeutralTertiary,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Container(
          padding: const EdgeInsets.all(AppRadius.m),
          decoration: BoxDecoration(
            color: FigmaColors.neutralPrimary,
            borderRadius: BorderRadius.circular(AppRadius.m),
          ),
          child: _OverviewGrid(
            items: [
              _OverviewTile(
                label: 'Network Share',
                value: '#${network.networkShareRank ?? '--'}',
              ),
              _OverviewTile(
                label: 'TVL',
                value: formatTaoSuffix(network.tvl) ?? '--',
              ),
              _OverviewTile(
                label: 'Owner Cut',
                value: formatPercentPrecise(network.ownerCut) ?? '--',
              ),
              _OverviewTile(
                label: 'Registration',
                value: network.registrationStatus ?? '--',
              ),
              _OverviewTile(
                label: 'Validators',
                value:
                    '${network.validatorCount ?? '--'}/${network.validatorLimit ?? '--'}',
              ),
              _OverviewTile(
                label: 'Miners',
                value: formatIntegerCompact(network.minerCount),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OverviewGrid extends StatelessWidget {
  const _OverviewGrid({required this.items});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var index = 0; index < items.length; index += 2) {
      final rightItem = index + 1 < items.length ? items[index + 1] : null;

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: items[index]),
            const SizedBox(width: 1),
            Expanded(child: rightItem ?? const SizedBox.shrink()),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (var index = 0; index < rows.length; index++) ...[
          if (index > 0) const SizedBox(height: 11),
          rows[index],
        ],
      ],
    );
  }
}

class _SubnetBadge extends StatelessWidget {
  const _SubnetBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: FigmaColors.neutralPrimary,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: FigmaColors.iconNeutralInverseTertiary),
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

class _OverviewTile extends StatelessWidget {
  const _OverviewTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: FigmaTypography.caption.copyWith(
              fontWeight: FontWeight.w400,
              color: FigmaColors.textBrandSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: FigmaTypography.compactBodySmallMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: FigmaColors.textNeutralPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
