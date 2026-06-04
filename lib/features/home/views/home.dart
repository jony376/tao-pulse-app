import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class HomeRootPage extends StatelessWidget {
  const HomeRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FigmaColors.pageBackground,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Home',
              style: FigmaTypography.h3Semibold.copyWith(
                color: FigmaColors.textNeutralPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Placeholder content',
              style: FigmaTypography.bodySmallRegular.copyWith(
                color: FigmaColors.textNeutralSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
