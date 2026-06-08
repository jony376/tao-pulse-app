import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/app_bottom_sheet.dart';
import '../../../../widgets/app_radio.dart';
import '../../models/subnet_sort_option.dart';

Future<SubnetSortOption?> showSubnetSortBottomSheet(
  BuildContext context, {
  required SubnetSortOption selectedSort,
}) {
  return showAppBottomSheet<SubnetSortOption>(
    context,
    title: 'Sort By',
    child: _SubnetSortSheetContent(selectedSort: selectedSort),
  );
}

class _SubnetSortSheetContent extends StatelessWidget {
  const _SubnetSortSheetContent({required this.selectedSort});

  final SubnetSortOption selectedSort;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (
          var index = 0;
          index < SubnetSortOption.values.length;
          index++
        ) ...[
          _SubnetSortOptionTile(
            option: SubnetSortOption.values[index],
            selected: SubnetSortOption.values[index] == selectedSort,
          ),
          if (index != SubnetSortOption.values.length - 1)
            const SizedBox(height: 5),
        ],
      ],
    );
  }
}

class _SubnetSortOptionTile extends StatelessWidget {
  const _SubnetSortOptionTile({required this.option, required this.selected});

  final SubnetSortOption option;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: FigmaColors.neutralSecondary,
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        onTap: () => Navigator.of(context).pop(option),
        borderRadius: BorderRadius.circular(26),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option.label,
                  style: FigmaTypography.compactBodySmallMedium.copyWith(
                    fontSize: 16,
                    color: FigmaColors.textNeutralPrimary,
                  ),
                ),
              ),
              AppRadio(
                selected: selected,
                size: 21,
                dotSize: 6,
                activeColor: FigmaColors.brandSecondary,
                dotColor: FigmaColors.pageBackground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
