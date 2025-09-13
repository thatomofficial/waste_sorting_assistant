import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color primaryLightGreen = Color(0xFF66BB6A);
  static const Color primaryDarkGreen = Color(0xFF1B5E20);
  
  // Secondary Colors
  static const Color secondaryBlue = Color(0xFF1976D2);
  static const Color secondaryLightBlue = Color(0xFF42A5F5);
  static const Color secondaryDarkBlue = Color(0xFF0D47A1);
  
  // Accent Colors
  static const Color accentOrange = Color(0xFFFF8F00);
  static const Color accentYellow = Color(0xFFFFC107);
  static const Color accentRed = Color(0xFFD32F2F);
  
  // Waste Category Colors
  static const Color recyclableColor = Color(0xFF4CAF50);
  static const Color organicColor = Color(0xFF8BC34A);
  static const Color hazardousColor = Color(0xFFE91E63);
  static const Color generalWasteColor = Color(0xFF757575);
  static const Color electronicColor = Color(0xFF3F51B5);
  static const Color glassColor = Color(0xFF00BCD4);
  static const Color plasticColor = Color(0xFFFF9800);
  static const Color paperColor = Color(0xFF795548);
  static const Color metalColor = Color(0xFF607D8B);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB3B3B3);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFF8F00);
  static const Color info = Color(0xFF1976D2);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF424242);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLightGreen, primaryDarkGreen],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryLightBlue, secondaryDarkBlue],
  );
  
  // Camera and Scanning Colors
  static const Color cameraOverlay = Color(0x88000000);
  static const Color scanningFrame = Color(0xFFFFFFFF);
  static const Color scanningSuccess = Color(0xFF4CAF50);
  static const Color scanningError = Color(0xFFD32F2F);
  
  // Card and Component Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF2C2C2C);
  static const Color cardShadow = Color(0x1F000000);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF616161);
  
  // Button Colors
  static const Color buttonPrimary = primaryGreen;
  static const Color buttonSecondary = secondaryBlue;
  static const Color buttonDisabled = Color(0xFFBDBDBD);
  static const Color buttonTextLight = Color(0xFFFFFFFF);
  static const Color buttonTextDark = Color(0xFF000000);
}