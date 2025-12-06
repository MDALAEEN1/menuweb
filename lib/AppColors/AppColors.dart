import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color background;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color success;
  final Color warning;
  final Color error;

  const AppColors({
    required this.primary,
    required this.background,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.warning,
    required this.error,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? background,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      card: card ?? this.card,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      card: Color.lerp(card, other.card, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}

// ---------------------------------------------------------
// 🔆 Light Theme
// ---------------------------------------------------------
const AppColors lightAppColors = AppColors(
  primary: Color(0xFF3E64FF),
  background: Color(0xFFF6F7FB),
  card: Colors.white,
  textPrimary: Color(0xFF1A1A1A),
  textSecondary: Color(0xFF6A6A6A),
  success: Color(0xFF28A745),
  warning: Color(0xFFFFC107),
  error: Color(0xFFDC3545),
);

// ---------------------------------------------------------
// 🌙 Dark Theme
// ---------------------------------------------------------
const AppColors darkAppColors = AppColors(
  primary: Color(0xFF5A8FFF),
  background: Color(0xFF0E1320),
  card: Color(0xFF1C2331),
  textPrimary: Colors.white,
  textSecondary: Color(0xFFBDBDBD),
  success: Color(0xFF4CAF50),
  warning: Color(0xFFFFD54F),
  error: Color(0xFFFF5252),
);
