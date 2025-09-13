import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colours.dart';
import '../../core/constants/app_styles.dart';

class AppThemeData {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryGreen,
        primaryContainer: AppColors.primaryLightGreen,
        secondary: AppColors.secondaryBlue,
        secondaryContainer: AppColors.secondaryLightBlue,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        onError: AppColors.white,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        titleTextStyle: AppStyles.appBarTitle,
        iconTheme: IconThemeData(color: AppColors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: AppStyles.lowElevation,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.mediumBorderRadius,
        ),
        shadowColor: AppColors.cardShadow,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.white,
          elevation: AppStyles.mediumElevation,
          padding: AppStyles.mediumPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.mediumBorderRadius,
          ),
          textStyle: AppStyles.buttonTextMedium,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          textStyle: AppStyles.buttonTextMedium,
          padding: AppStyles.mediumPadding,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          side: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
          padding: AppStyles.mediumPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.mediumBorderRadius,
          ),
          textStyle: AppStyles.buttonTextMedium,
        ),
      ),

      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          iconSize: AppStyles.mediumIconSize,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        elevation: AppStyles.mediumElevation,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppStyles.bodyMedium,
        hintStyle:
            AppStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        errorStyle: AppStyles.errorText,
        contentPadding: AppStyles.mediumPadding,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: AppStyles.mediumElevation,
        selectedLabelStyle: AppStyles.navigationLabel,
        unselectedLabelStyle: AppStyles.navigationLabel,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightGrey,
        selectedColor: AppColors.primaryLightGreen,
        secondarySelectedColor: AppColors.secondaryLightBlue,
        labelStyle: AppStyles.bodySmall,
        secondaryLabelStyle:
            AppStyles.bodySmall.copyWith(color: AppColors.white),
        padding: AppStyles.smallPadding,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.largeBorderRadius,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        elevation: AppStyles.highElevation,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.mediumBorderRadius,
        ),
        titleTextStyle: AppStyles.titleLarge,
        contentTextStyle: AppStyles.bodyMedium,
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primaryDarkGreen,
        contentTextStyle: AppStyles.bodyMedium.copyWith(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.smallBorderRadius,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryGreen,
        linearTrackColor: AppColors.lightGrey,
        circularTrackColor: AppColors.lightGrey,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppStyles.headlineLarge,
        displayMedium: AppStyles.headlineMedium,
        displaySmall: AppStyles.headlineSmall,
        headlineLarge: AppStyles.headlineLarge,
        headlineMedium: AppStyles.headlineMedium,
        headlineSmall: AppStyles.headlineSmall,
        titleLarge: AppStyles.titleLarge,
        titleMedium: AppStyles.titleMedium,
        titleSmall: AppStyles.titleSmall,
        bodyLarge: AppStyles.bodyLarge,
        bodyMedium: AppStyles.bodyMedium,
        bodySmall: AppStyles.bodySmall,
        labelLarge: AppStyles.labelLarge,
        labelMedium: AppStyles.labelMedium,
        labelSmall: AppStyles.labelSmall,
      ),

      // Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.primaryGreen,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primaryGreen,
        labelStyle: AppStyles.labelLarge,
        unselectedLabelStyle: AppStyles.labelLarge,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryGreen;
          }
          return AppColors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLightGreen;
          }
          return AppColors.lightGrey;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryGreen;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(color: AppColors.primaryGreen),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryGreen;
          }
          return AppColors.grey;
        }),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLightGreen,
        primaryContainer: AppColors.primaryDarkGreen,
        secondary: AppColors.secondaryLightBlue,
        secondaryContainer: AppColors.secondaryDarkBlue,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: AppColors.black,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimaryDark,
        onError: AppColors.white,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryDarkGreen,
        foregroundColor: AppColors.white,
        titleTextStyle: AppStyles.appBarTitle,
        iconTheme: IconThemeData(color: AppColors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.cardBackgroundDark,
        elevation: AppStyles.lowElevation,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.mediumBorderRadius,
        ),
        shadowColor: AppColors.black.withValues(alpha: 0.5),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLightGreen,
          foregroundColor: AppColors.black,
          elevation: AppStyles.mediumElevation,
          padding: AppStyles.mediumPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.mediumBorderRadius,
          ),
          textStyle: AppStyles.buttonTextMedium,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLightGreen,
          textStyle: AppStyles.buttonTextMedium,
          padding: AppStyles.mediumPadding,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLightGreen,
          side:
              const BorderSide(color: AppColors.primaryLightGreen, width: 1.5),
          padding: AppStyles.mediumPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.mediumBorderRadius,
          ),
          textStyle: AppStyles.buttonTextMedium,
        ),
      ),

      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.primaryLightGreen,
          iconSize: AppStyles.mediumIconSize,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLightGreen,
        foregroundColor: AppColors.black,
        elevation: AppStyles.mediumElevation,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackgroundDark,
        border: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.dividerDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.dividerDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide:
              const BorderSide(color: AppColors.primaryLightGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppStyles.mediumBorderRadius,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppStyles.bodyMediumDark,
        hintStyle: AppStyles.bodyMediumDark
            .copyWith(color: AppColors.textSecondaryDark),
        errorStyle: AppStyles.errorText,
        contentPadding: AppStyles.mediumPadding,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        selectedItemColor: AppColors.primaryLightGreen,
        unselectedItemColor: AppColors.textSecondaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: AppStyles.mediumElevation,
        selectedLabelStyle: AppStyles.navigationLabel,
        unselectedLabelStyle: AppStyles.navigationLabel,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkGrey,
        selectedColor: AppColors.primaryDarkGreen,
        secondarySelectedColor: AppColors.secondaryDarkBlue,
        labelStyle:
            AppStyles.bodySmall.copyWith(color: AppColors.textPrimaryDark),
        secondaryLabelStyle:
            AppStyles.bodySmall.copyWith(color: AppColors.white),
        padding: AppStyles.smallPadding,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.largeBorderRadius,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        elevation: AppStyles.highElevation,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.mediumBorderRadius,
        ),
        titleTextStyle: AppStyles.titleLargeDark,
        contentTextStyle: AppStyles.bodyMediumDark,
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primaryDarkGreen,
        contentTextStyle: AppStyles.bodyMedium.copyWith(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.smallBorderRadius,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryLightGreen,
        linearTrackColor: AppColors.darkGrey,
        circularTrackColor: AppColors.darkGrey,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppStyles.headlineLargeDark,
        displayMedium: AppStyles.headlineLargeDark,
        displaySmall: AppStyles.headlineLargeDark,
        headlineLarge: AppStyles.headlineLargeDark,
        headlineMedium: AppStyles.headlineLargeDark,
        headlineSmall: AppStyles.headlineLargeDark,
        titleLarge: AppStyles.titleLargeDark,
        titleMedium: AppStyles.titleLargeDark,
        titleSmall: AppStyles.titleLargeDark,
        bodyLarge: AppStyles.bodyLargeDark,
        bodyMedium: AppStyles.bodyMediumDark,
        bodySmall: AppStyles.bodyMediumDark,
        labelLarge: AppStyles.bodyLargeDark,
        labelMedium: AppStyles.bodyMediumDark,
        labelSmall: AppStyles.bodyMediumDark,
      ),

      // Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.primaryLightGreen,
        unselectedLabelColor: AppColors.textSecondaryDark,
        indicatorColor: AppColors.primaryLightGreen,
        labelStyle: AppStyles.labelLarge,
        unselectedLabelStyle: AppStyles.labelLarge,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLightGreen;
          }
          return AppColors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryDarkGreen;
          }
          return AppColors.darkGrey;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLightGreen;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.black),
        side: const BorderSide(color: AppColors.primaryLightGreen),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLightGreen;
          }
          return AppColors.grey;
        }),
      ),
    );
  }
}
