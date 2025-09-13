import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colours.dart';
import '../../core/constants/app_styles.dart';

class DarkTheme {
  static ThemeData get theme {
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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
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
        shadowColor: AppColors.black.withValues(alpha: 0.3),
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
          textStyle: AppStyles.buttonTextMedium.copyWith(color: AppColors.black),
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
          side: const BorderSide(color: AppColors.primaryLightGreen, width: 1.5),
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
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.mediumBorderRadius,
        ),
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
          borderSide: const BorderSide(color: AppColors.primaryLightGreen, width: 2),
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
        hintStyle: AppStyles.bodyMediumDark.copyWith(color: AppColors.textSecondaryDark),
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

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        indicatorColor: AppColors.primaryLightGreen.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppStyles.navigationLabel.copyWith(color: AppColors.primaryLightGreen);
          }
          return AppStyles.navigationLabel.copyWith(color: AppColors.textSecondaryDark);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryLightGreen);
          }
          return const IconThemeData(color: AppColors.textSecondaryDark);
        }),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkGrey,
        selectedColor: AppColors.primaryDarkGreen,
        secondarySelectedColor: AppColors.secondaryDarkBlue,
        labelStyle: AppStyles.bodySmall.copyWith(color: AppColors.textPrimaryDark),
        secondaryLabelStyle: AppStyles.bodySmall.copyWith(color: AppColors.white),
        padding: AppStyles.smallPadding,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.largeBorderRadius,
        ),
        deleteIconColor: AppColors.textSecondaryDark,
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

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        elevation: AppStyles.highElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primaryDarkGreen,
        contentTextStyle: AppStyles.bodyMedium.copyWith(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.smallBorderRadius,
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: AppColors.primaryLightGreen,
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
        dividerColor: AppColors.dividerDark,
      ),

      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: AppColors.primaryDarkGreen,
        iconColor: AppColors.textSecondaryDark,
        selectedColor: AppColors.primaryLightGreen,
        textColor: AppColors.textPrimaryDark,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
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

      // Slider Theme
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primaryLightGreen,
        inactiveTrackColor: AppColors.darkGrey,
        thumbColor: AppColors.primaryLightGreen,
        overlayColor: AppColors.primaryDarkGreen,
        valueIndicatorColor: AppColors.primaryLightGreen,
        valueIndicatorTextStyle: TextStyle(color: AppColors.black),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundDark,
          borderRadius: AppStyles.smallBorderRadius,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        textStyle: AppStyles.bodySmall.copyWith(color: AppColors.textPrimaryDark),
      ),

      // Banner Theme
      bannerTheme: const MaterialBannerThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        contentTextStyle: AppStyles.bodyMedium,
      ),

      // Popup Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.cardBackgroundDark,
        elevation: AppStyles.mediumElevation,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.mediumBorderRadius,
        ),
        textStyle: AppStyles.bodyMedium.copyWith(color: AppColors.textPrimaryDark),
      ),

      // Menu Theme
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.cardBackgroundDark),
          elevation: WidgetStateProperty.all(AppStyles.mediumElevation),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: AppStyles.mediumBorderRadius,
            ),
          ),
        ),
      ),

      // Expansion Tile Theme
      expansionTileTheme: const ExpansionTileThemeData(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: AppColors.primaryLightGreen,
        collapsedIconColor: AppColors.textSecondaryDark,
        textColor: AppColors.textPrimaryDark,
        collapsedTextColor: AppColors.textPrimaryDark,
      ),

      // Data Table Theme
      dataTableTheme: DataTableThemeData(
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundDark,
          borderRadius: AppStyles.mediumBorderRadius,
        ),
        headingRowColor: WidgetStateProperty.all(AppColors.primaryDarkGreen),
        headingTextStyle: AppStyles.labelLarge.copyWith(color: AppColors.white),
        dataTextStyle: AppStyles.bodyMedium.copyWith(color: AppColors.textPrimaryDark),
        dividerThickness: 1,
      ),
    );
  }
}