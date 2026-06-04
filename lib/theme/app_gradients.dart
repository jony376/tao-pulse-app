import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  static const brand = LinearGradient(
    colors: [AppColors.brandStart, AppColors.brandMid, AppColors.brandEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
