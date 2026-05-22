import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  static const _fallbacks = ['SF Pro Display', 'Plus Jakarta Sans'];

  static TextTheme textTheme = const TextTheme(
    displaySmall: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      height: 1.1,
      letterSpacing: -0.8,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.14,
      letterSpacing: -0.5,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: -0.2,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.25,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.45,
      color: AppColors.textSecondary,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.45,
      color: AppColors.textSecondary,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.35,
      color: AppColors.textMuted,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.25,
      color: AppColors.textMuted,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: AppColors.textMuted,
      fontFamily: 'Inter',
      fontFamilyFallback: _fallbacks,
    ),
  );
}
