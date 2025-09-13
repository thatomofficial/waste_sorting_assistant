abstract class CustomException implements Exception {
  final String message;
  final String code;
  final dynamic details;

  const CustomException({
    required this.message,
    required this.code,
    this.details,
  });

  @override
  String toString() => 'CustomException: $message (Code: $code)';
}

// Network Exceptions
class NetworkException extends CustomException {
  const NetworkException({
    required super.message,
    super.code = 'NETWORK_ERROR',
    super.details,
  });
}

class TimeoutException extends CustomException {
  const TimeoutException({
    super.message = 'Request timeout',
    super.code = 'TIMEOUT_ERROR',
    super.details,
  });
}

class NoInternetException extends CustomException {
  const NoInternetException({
    super.message = 'No internet connection',
    super.code = 'NO_INTERNET',
    super.details,
  });
}

// Authentication Exceptions
class AuthException extends CustomException {
  const AuthException({
    required super.message,
    super.code = 'AUTH_ERROR',
    super.details,
  });
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException({
    super.message = 'Invalid email or password',
    super.code = 'INVALID_CREDENTIALS',
    super.details,
  });
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException({
    super.message = 'User not found',
    super.code = 'USER_NOT_FOUND',
    super.details,
  });
}

class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException({
    super.message = 'Email already in use',
    super.code = 'EMAIL_IN_USE',
    super.details,
  });
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException({
    super.message = 'Password is too weak',
    super.code = 'WEAK_PASSWORD',
    super.details,
  });
}

class UserDisabledException extends AuthException {
  const UserDisabledException({
    super.message = 'User account has been disabled',
    super.code = 'USER_DISABLED',
    super.details,
  });
}

// Database Exceptions
class DatabaseException extends CustomException {
  const DatabaseException({
    required super.message,
    super.code = 'DATABASE_ERROR',
    super.details,
  });
}

class DocumentNotFoundException extends DatabaseException {
  const DocumentNotFoundException({
    super.message = 'Document not found',
    super.code = 'DOCUMENT_NOT_FOUND',
    super.details,
  });
}

class PermissionDeniedException extends DatabaseException {
  const PermissionDeniedException({
    super.message = 'Permission denied',
    super.code = 'PERMISSION_DENIED',
    super.details,
  });
}

class QuotaExceededException extends DatabaseException {
  const QuotaExceededException({
    super.message = 'Quota exceeded',
    super.code = 'QUOTA_EXCEEDED',
    super.details,
  });
}

// Storage Exceptions
class StorageException extends CustomException {
  const StorageException({
    required super.message,
    super.code = 'STORAGE_ERROR',
    super.details,
  });
}

class FileNotFoundException extends StorageException {
  const FileNotFoundException({
    super.message = 'File not found',
    super.code = 'FILE_NOT_FOUND',
    super.details,
  });
}

class InsufficientStorageException extends StorageException {
  const InsufficientStorageException({
    super.message = 'Insufficient storage space',
    super.code = 'INSUFFICIENT_STORAGE',
    super.details,
  });
}

// Camera and Image Exceptions
class CameraException extends CustomException {
  const CameraException({
    required super.message,
    super.code = 'CAMERA_ERROR',
    super.details,
  });
}

class CameraPermissionException extends CameraException {
  const CameraPermissionException({
    super.message = 'Camera permission denied',
    super.code = 'CAMERA_PERMISSION_DENIED',
    super.details,
  });
}

class ImageProcessingException extends CustomException {
  const ImageProcessingException({
    super.message = 'Image processing failed',
    super.code = 'IMAGE_PROCESSING_ERROR',
    super.details,
  });
}

// ML Kit Exceptions
class MLKitException extends CustomException {
  const MLKitException({
    required super.message,
    super.code = 'MLKIT_ERROR',
    super.details,
  });
}

class ImageLabelingException extends MLKitException {
  const ImageLabelingException({
    super.message = 'Image labeling failed',
    super.code = 'IMAGE_LABELING_ERROR',
    super.details,
  });
}

class ModelNotAvailableException extends MLKitException {
  const ModelNotAvailableException({
    super.message = 'ML model not available',
    super.code = 'MODEL_NOT_AVAILABLE',
    super.details,
  });
}

// Validation Exceptions
class ValidationException extends CustomException {
  const ValidationException({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.details,
  });
}

class InvalidInputException extends ValidationException {
  const InvalidInputException({
    required super.message,
    super.code = 'INVALID_INPUT',
    super.details,
  });
}

class RequiredFieldException extends ValidationException {
  const RequiredFieldException({
    required String fieldName,
    super.code = 'REQUIRED_FIELD',
    super.details,
  }) : super(message: '$fieldName is required');
}

// General Exceptions
class UnknownException extends CustomException {
  const UnknownException({
    super.message = 'An unknown error occurred',
    super.code = 'UNKNOWN_ERROR',
    super.details,
  });
}

class FeatureNotImplementedException extends CustomException {
  const FeatureNotImplementedException({
    super.message = 'Feature not yet implemented',
    super.code = 'NOT_IMPLEMENTED',
    super.details,
  });
}

class ConfigurationException extends CustomException {
  const ConfigurationException({
    required super.message,
    super.code = 'CONFIGURATION_ERROR',
    super.details,
  });
}

// Exception Handler Utility
class ExceptionHandler {
  static CustomException handleException(dynamic error) {
    if (error is CustomException) {
      return error;
    }

    // Handle Firebase Auth errors
    if (error.toString().contains('user-not-found')) {
      return const UserNotFoundException();
    }
    if (error.toString().contains('wrong-password')) {
      return const InvalidCredentialsException();
    }
    if (error.toString().contains('email-already-in-use')) {
      return const EmailAlreadyInUseException();
    }
    if (error.toString().contains('weak-password')) {
      return const WeakPasswordException();
    }
    if (error.toString().contains('user-disabled')) {
      return const UserDisabledException();
    }

    // Handle Network errors
    if (error.toString().contains('network') || 
        error.toString().contains('connection')) {
      return NetworkException(message: error.toString());
    }

    // Handle permission errors
    if (error.toString().contains('permission')) {
      return const PermissionDeniedException();
    }

    // Default to unknown exception
    return UnknownException(
      message: error.toString(),
      details: error,
    );
  }

  static String getErrorMessage(CustomException exception) {
    switch (exception.code) {
      case 'NETWORK_ERROR':
      case 'NO_INTERNET':
        return 'Please check your internet connection and try again';
      case 'TIMEOUT_ERROR':
        return 'Request timed out. Please try again';
      case 'INVALID_CREDENTIALS':
        return 'Invalid email or password';
      case 'USER_NOT_FOUND':
        return 'No account found with this email';
      case 'EMAIL_IN_USE':
        return 'An account with this email already exists';
      case 'WEAK_PASSWORD':
        return 'Please choose a stronger password';
      case 'USER_DISABLED':
        return 'This account has been disabled';
      case 'CAMERA_PERMISSION_DENIED':
        return 'Camera permission is required to scan items';
      case 'IMAGE_PROCESSING_ERROR':
        return 'Failed to process the image. Please try again';
      case 'IMAGE_LABELING_ERROR':
        return 'Could not identify the item. Please try a clearer image';
      default:
        return exception.message;
    }
  }
}