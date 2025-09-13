import '../constants/app_strings.dart';

class Validators {
  // Email validation
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.emailRequired;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email.trim())) {
      return AppStrings.invalidEmail;
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.passwordRequired;
    }

    if (password.length < 6) {
      return AppStrings.passwordTooShort;
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(
      String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (confirmPassword != password) {
      return AppStrings.passwordsDoNotMatch;
    }

    return null;
  }

  // Name validation
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return AppStrings.nameRequired;
    }

    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }

    if (name.trim().length > 50) {
      return 'Name must be less than 50 characters';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(name.trim())) {
      return 'Name can only contain letters and spaces';
    }

    return null;
  }

  // Phone number validation
  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return null; // Phone is optional
    }

    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(phoneNumber.trim())) {
      return 'Please enter a valid phone number';
    }

    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[\D]'), '');
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return 'Phone number must be between 10-15 digits';
    }

    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // URL validation
  static String? validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return null; // URL is optional
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(url.trim())) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  // Age validation
  static String? validateAge(String? age) {
    if (age == null || age.isEmpty) {
      return null; // Age is optional
    }

    final ageInt = int.tryParse(age);
    if (ageInt == null) {
      return 'Please enter a valid age';
    }

    if (ageInt < 13 || ageInt > 120) {
      return 'Age must be between 13 and 120';
    }

    return null;
  }

  // Text length validation
  static String? validateTextLength(
    String? text,
    String fieldName, {
    int minLength = 0,
    int maxLength = 500,
  }) {
    if (text == null || text.trim().isEmpty) {
      if (minLength > 0) {
        return '$fieldName is required';
      }
      return null;
    }

    final trimmedText = text.trim();

    if (trimmedText.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }

    if (trimmedText.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }

    return null;
  }

  // Search query validation
  static String? validateSearchQuery(String? query) {
    if (query == null || query.trim().isEmpty) {
      return 'Please enter a search term';
    }

    if (query.trim().length < 2) {
      return 'Search term must be at least 2 characters long';
    }

    if (query.trim().length > 100) {
      return 'Search term must be less than 100 characters';
    }

    return null;
  }

  // Number validation
  static String? validateNumber(
    String? value,
    String fieldName, {
    double? min,
    double? max,
    bool allowDecimal = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final number = allowDecimal
        ? double.tryParse(value.trim())
        : int.tryParse(value.trim())?.toDouble();

    if (number == null) {
      return 'Please enter a valid ${allowDecimal ? 'number' : 'whole number'}';
    }

    if (min != null && number < min) {
      return '$fieldName must be at least $min';
    }

    if (max != null && number > max) {
      return '$fieldName must be at most $max';
    }

    return null;
  }

  // Date validation
  static String? validateDate(String? date, {bool requireFuture = false}) {
    if (date == null || date.trim().isEmpty) {
      return 'Date is required';
    }

    final parsedDate = DateTime.tryParse(date);
    if (parsedDate == null) {
      return 'Please enter a valid date';
    }

    if (requireFuture && parsedDate.isBefore(DateTime.now())) {
      return 'Date must be in the future';
    }

    return null;
  }

  // Custom validation combiner
  static String? combineValidators(
      String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  // Waste category validation
  static String? validateWasteCategory(String? category) {
    if (category == null || category.trim().isEmpty) {
      return 'Waste category is required';
    }

    final validCategories = [
      'recyclable',
      'organic',
      'hazardous',
      'general',
      'electronic',
      'glass',
      'plastic',
      'paper',
      'metal',
    ];

    if (!validCategories.contains(category.toLowerCase())) {
      return 'Invalid waste category';
    }

    return null;
  }

  // File size validation (in bytes)
  static String? validateFileSize(int? fileSize, {int maxSizeInMB = 10}) {
    if (fileSize == null) {
      return 'Invalid file';
    }

    final maxSizeInBytes = maxSizeInMB * 1024 * 1024;

    if (fileSize > maxSizeInBytes) {
      return 'File size must be less than ${maxSizeInMB}MB';
    }

    return null;
  }

  // Image file validation
  static String? validateImageFile(String? fileName) {
    if (fileName == null || fileName.isEmpty) {
      return 'Please select an image';
    }

    final allowedExtensions = [
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.bmp',
      '.webp'
    ];
    final lowerCaseFileName = fileName.toLowerCase();

    final hasValidExtension = allowedExtensions.any(
      (extension) => lowerCaseFileName.endsWith(extension),
    );

    if (!hasValidExtension) {
      return 'Please select a valid image file (jpg, png, gif, etc.)';
    }

    return null;
  }
}
