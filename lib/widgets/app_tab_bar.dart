import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.horizontalPadding = 0,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth - (horizontalPadding * 2);
        final slotWidth = contentWidth / labels.length;
        final indicatorLeft = horizontalPadding + (slotWidth * selectedIndex);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  for (var index = 0; index < labels.length; index++)
                    Expanded(
                      child: _AppTabBarLabel(
                        label: labels[index],
                        selected: index == selectedIndex,
                        onTap: () => onSelected(index),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 1,
              child: Stack(
                children: [
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: FigmaColors.neutralSecondary,
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    left: indicatorLeft,
                    bottom: 0,
                    child: Container(
                      width: slotWidth,
                      height: 1,
                      color: FigmaColors.brandPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AppTabBarLabel extends StatelessWidget {
  const _AppTabBarLabel({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style:
                (selected
                        ? FigmaTypography.compactBodySmallMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: FigmaColors.brandPrimary,
                          )
                        : FigmaTypography.compactBodySmallMedium.copyWith(
                            fontSize: 16,
                            color: FigmaColors.textNeutralTertiary,
                          ))
                    .copyWith(height: 1),
          ),
        ),
      ),
    );
  }
}
