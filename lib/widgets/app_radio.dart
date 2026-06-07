import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AppRadio extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.selected,
    this.size = 20,
    this.dotSize = 8,
    this.activeColor = FigmaColors.brandSecondary,
    this.dotColor = FigmaColors.pageBackground,
    this.showInactiveBorder = false,
    this.inactiveBorderColor = Colors.transparent,
    this.borderWidth = 1.5,
  });

  final bool selected;
  final double size;
  final double dotSize;
  final Color activeColor;
  final Color dotColor;
  final bool showInactiveBorder;
  final Color inactiveBorderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: selected ? activeColor : Colors.transparent,
        shape: BoxShape.circle,
        border: showInactiveBorder && !selected
            ? Border.all(color: inactiveBorderColor, width: borderWidth)
            : null,
      ),
      child: selected
          ? Center(
              child: Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
