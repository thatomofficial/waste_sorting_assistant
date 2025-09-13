import 'package:flutter/material.dart';
import 'app_colours.dart';

class AppStyles {
  // Text Styles - Light Theme
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.25,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.15,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 1.25,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 1.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
  );

  // Button Text Styles
  static const TextStyle buttonTextLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonTextMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    letterSpacing: 0.25,
  );

  static const TextStyle buttonTextSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  // Special Text Styles
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.15,
  );

  static const TextStyle navigationLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle statisticsNumber = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryGreen,
    letterSpacing: -0.5,
  );

  static const TextStyle statisticsLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    letterSpacing: 0.4,
  );

  static const TextStyle successText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
    letterSpacing: 0.25,
  );

  // Dark Theme Text Styles
  static TextStyle get headlineLargeDark => headlineLarge.copyWith(
        color: AppColors.textPrimaryDark,
      );

  static TextStyle get titleLargeDark => titleLarge.copyWith(
        color: AppColors.textPrimaryDark,
      );

  static TextStyle get bodyLargeDark => bodyLarge.copyWith(
        color: AppColors.textPrimaryDark,
      );

  static TextStyle get bodyMediumDark => bodyMedium.copyWith(
        color: AppColors.textSecondaryDark,
      );

  // Box Decorations
  static BoxDecoration get cardDecoration => BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );

  static BoxDecoration get cardDecorationDark => BoxDecoration(
        color: AppColors.cardBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );

  static BoxDecoration get primaryButtonDecoration => BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get secondaryButtonDecoration => BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryBlue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get inputDecoration => BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1,
        ),
      );

  static BoxDecoration get inputDecorationFocused => BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryGreen,
          width: 2,
        ),
      );

  // Border Radius
  static const BorderRadius smallBorderRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius mediumBorderRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius largeBorderRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius extraLargeBorderRadius = BorderRadius.all(Radius.circular(24));

  // Padding and Margins
  static const EdgeInsets smallPadding = EdgeInsets.all(8);
  static const EdgeInsets mediumPadding = EdgeInsets.all(16);
  static const EdgeInsets largePadding = EdgeInsets.all(24);
  static const EdgeInsets extraLargePadding = EdgeInsets.all(32);

  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets verticalPadding = EdgeInsets.symmetric(vertical: 16);

  // Spacing
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 24.0;
  static const double extraLargeSpacing = 32.0;

  // Icon Sizes
  static const double smallIconSize = 16.0;
  static const double mediumIconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double extraLargeIconSize = 48.0;

  // Button Heights
  static const double smallButtonHeight = 36.0;
  static const double mediumButtonHeight = 48.0;
  static const double largeButtonHeight = 56.0;

  // Input Field Heights
  static const double inputFieldHeight = 56.0;
  static const double multilineInputMinHeight = 100.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 150);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Elevation
  static const double lowElevation = 2.0;
  static const double mediumElevation = 4.0;
  static const double highElevation = 8.0;
  static const double extraHighElevation = 16.0;
}