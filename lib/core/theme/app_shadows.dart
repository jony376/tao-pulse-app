import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  static const card = [
    BoxShadow(color: Color(0x59000000), blurRadius: 32, offset: Offset(0, 8)),
  ];

  static const glow = [
    BoxShadow(
      color: AppColors.glowPurple,
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 0),
    ),
  ];
}
