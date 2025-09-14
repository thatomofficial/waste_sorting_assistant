import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colours.dart';

class Helpers {
  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (log(bytes) / log(1024)).floor();
    final size = bytes / pow(1024, i);
    
    return '${size.toStringAsFixed(i >= 2 ? 1 : 0)} ${suffixes[i]}';
  }

  // Format numbers with commas
  static String formatNumber(num number) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return number
        .toString()
        .replaceAllMapped(formatter, (match) => '${match[1]},');
  }

  // Format percentage
  static String formatPercentage(double value, {int decimals = 1}) {
    return '${(value * 100).toStringAsFixed(decimals)}%';
  }

  // Format date and time
  static String formatDateTime(DateTime dateTime, {bool includeTime = true}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String dateStr;
    if (dateOnly == today) {
      dateStr = 'Today';
    } else if (dateOnly == yesterday) {
      dateStr = 'Yesterday';
    } else {
      dateStr = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }

    if (includeTime) {
      final timeStr = '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
      return '$dateStr at $timeStr';
    }

    return dateStr;
  }

  // Format time ago
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  // Truncate text with ellipsis
  static String truncateText(
    String text,
    int maxLength, {
    String suffix = '...',
  }) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - suffix.length)}$suffix';
  }

  // Capitalize first letter
  static String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Capitalize each word
  static String capitalizeWords(String text) {
    return text.split(' ')
        .map((word) => word.isNotEmpty ? capitalizeFirst(word) : word)
        .join(' ');
  }

  // Generate random string
  static String generateRandomString(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  // Debouncer for search
  static Timer? _debounceTimer;
  static void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, callback);
  }

  // Check if dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Get theme-appropriate color
  static Color getThemedColor(
    BuildContext context,
    Color lightColor,
    Color darkColor,
  ) {
    return isDarkMode(context) ? darkColor : lightColor;
  }

  // Haptic feedback
  static void lightHaptic() {
    HapticFeedback.lightImpact();
  }

  static void mediumHaptic() {
    HapticFeedback.mediumImpact();
  }

  static void heavyHaptic() {
    HapticFeedback.heavyImpact();
  }

  static void selectionHaptic() {
    HapticFeedback.selectionClick();
  }

  // Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // Show snackbar
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor ?? Colors.white),
        ),
        backgroundColor: backgroundColor ?? AppColors.primaryGreen,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Show success snackbar
  static void showSuccessSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppColors.success,
    );
  }

  // Show error snackbar
  static void showErrorSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppColors.error,
    );
  }

  // Show warning snackbar
  static void showWarningSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message,
      backgroundColor: AppColors.warning,
    );
  }

  // Calculate distance between two points
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);
    
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
        cos(_degreesToRadians(lat2)) *
        sin(dLon / 2) *
        sin(dLon / 2);
    
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  // Format distance
  static String formatDistance(double distanceInKm) {
    if (distanceInKm < 1) {
      final meters = (distanceInKm * 1000).round();
      return '${meters}m';
    } else if (distanceInKm < 10) {
      return '${distanceInKm.toStringAsFixed(1)}km';
    } else {
      return '${distanceInKm.round()}km';
    }
  }

  // Get waste category color
  static Color getWasteCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'recyclable':
        return AppColors.recyclableColor;
      case 'organic':
        return AppColors.organicColor;
      case 'hazardous':
        return AppColors.hazardousColor;
      case 'general':
        return AppColors.generalWasteColor;
      case 'electronic':
        return AppColors.electronicColor;
      case 'glass':
        return AppColors.glassColor;
      case 'plastic':
        return AppColors.plasticColor;
      case 'paper':
        return AppColors.paperColor;
      case 'metal':
        return AppColors.metalColor;
      default:
        return AppColors.grey;
    }
  }

  // Generate gradient from color
  static LinearGradient generateGradient(Color baseColor) {
    final lightColor = Color.lerp(baseColor, Colors.white, 0.2) ?? baseColor;
    final darkColor = Color.lerp(baseColor, Colors.black, 0.2) ?? baseColor;
    
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [lightColor, darkColor],
    );
  }

  // Check if string is numeric
  static bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  // Check if email format is valid
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // Remove special characters from string
  static String removeSpecialCharacters(String str) {
    return str.replaceAll(RegExp(r'[^\w\s]'), '');
  }

  // Convert string to slug
  static String stringToSlug(String str) {
    return str
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'[-\s]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  // Get file extension
  static String getFileExtension(String fileName) {
    final parts = fileName.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  // Check if file is image
  static bool isImageFile(String fileName) {
    final extension = getFileExtension(fileName);
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  // Convert bytes to image size description
  static String getImageSizeDescription(int bytes) {
    if (bytes < 100 * 1024) return 'Small'; // < 100KB
    if (bytes < 500 * 1024) return 'Medium'; // < 500KB
    if (bytes < 2 * 1024 * 1024) return 'Large'; // < 2MB
    return 'Very Large'; // >= 2MB
  }

  // Get device type
  static String getDeviceType() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  // Copy text to clipboard
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  // Get initials from name
  static String getInitials(String name) {
    if (name.trim().isEmpty) return '';
    
    final words = name.trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }
    
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  // Validate and format phone number
  static String? formatPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) return null;
    
    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    // Format as (XXX) XXX-XXXX for 10-digit numbers
    if (digitsOnly.length == 10) {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    }
    
    return phoneNumber; // Return original if not 10 digits
  }

  // Calculate CO2 savings based on waste type and amount
  static double calculateCO2Savings(String wasteType, double weightInKg) {
    // CO2 savings per kg for different waste types (approximate values)
    final co2FactorPerKg = <String, double>{
      'paper': 3.3, // kg CO2 saved per kg of paper recycled
      'plastic': 2.0,
      'glass': 0.2,
      'metal': 1.5,
      'electronic': 4.0,
      'organic': 0.5, // composting benefits
    };
    
    final factor = co2FactorPerKg[wasteType.toLowerCase()] ?? 1.0;
    return weightInKg * factor;
  }
}