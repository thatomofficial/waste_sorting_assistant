import 'dart:io';

enum Environment { development, staging, production }

class AppConfig {
  static late Environment _environment;
  static late Map<String, dynamic> _config;

  static Environment get environment => _environment;
  static Map<String, dynamic> get config => _config;

  // API Configuration
  static String get apiBaseUrl => _config['api_base_url'] as String;
  static String get apiVersion => _config['api_version'] as String;
  static Duration get apiTimeout =>
      Duration(seconds: _config['api_timeout'] as int);

  // Firebase Configuration
  static String get firebaseProjectId =>
      _config['firebase_project_id'] as String;
  static String get firebaseApiKey => _config['firebase_api_key'] as String;
  static String get firebaseAppId => _config['firebase_app_id'] as String;
  static String get firebaseMessagingSenderId =>
      _config['firebase_messaging_sender_id'] as String;

  // ML Kit Configuration
  static bool get useCloudMLKit => _config['use_cloud_ml_kit'] as bool;
  static double get mlConfidenceThreshold =>
      _config['ml_confidence_threshold'] as double;
  static int get maxImageSize => _config['max_image_size'] as int;

  // Feature Flags
  static bool get enableAnalytics => _config['enable_analytics'] as bool;
  static bool get enableCrashReporting =>
      _config['enable_crash_reporting'] as bool;
  static bool get enablePushNotifications =>
      _config['enable_push_notifications'] as bool;
  static bool get enableOfflineMode => _config['enable_offline_mode'] as bool;
  static bool get enableDarkMode => _config['enable_dark_mode'] as bool;

  // Performance Configuration
  static int get cacheSize => _config['cache_size'] as int;
  static Duration get cacheExpiry =>
      Duration(hours: _config['cache_expiry_hours'] as int);
  static int get maxRetryAttempts => _config['max_retry_attempts'] as int;

  // App Information
  static String get appName => _config['app_name'] as String;
  static String get appVersion => _config['app_version'] as String;
  static String get buildNumber => _config['build_number'] as String;

  // Debug/Logging
  static bool get enableDebugLogs => _config['enable_debug_logs'] as bool;
  static bool get enableNetworkLogs => _config['enable_network_logs'] as bool;

  // Initialize configuration based on environment
  static Future<void> initialize({Environment? env}) async {
    // Determine environment
    _environment = env ?? _getEnvironmentFromFlavor();

    // Load configuration
    _config = _getConfigForEnvironment(_environment);

    // Apply platform-specific configurations
    _applyPlatformSpecificConfig();
  }

  static Environment _getEnvironmentFromFlavor() {
    // Get environment from build flavor or environment variable
    const flavor = String.fromEnvironment(
        'ENVIRONMENT',
        defaultValue: 'development');

    switch (flavor.toLowerCase()) {
      case 'production':
        return Environment.production;
      case 'staging':
        return Environment.staging;
      case 'development':
      default:
        return Environment.development;
    }
  }

  static Map<String, dynamic> _getConfigForEnvironment(Environment env) {
    switch (env) {
      case Environment.development:
        return _developmentConfig;
      case Environment.staging:
        return _stagingConfig;
      case Environment.production:
        return _productionConfig;
    }
  }

  static void _applyPlatformSpecificConfig() {
    // Apply iOS-specific configurations
    if (Platform.isIOS) {
      _config['enable_background_processing'] = true;
      _config['camera_quality'] = 'high';
    }

    // Apply Android-specific configurations
    if (Platform.isAndroid) {
      _config['enable_adaptive_icons'] = true;
      _config['target_sdk_version'] = 34;
    }
  }

  // Development Environment Configuration
  static final Map<String, dynamic> _developmentConfig = {
    // API Configuration
    'api_base_url': 'https://dev-api.wastesortingassistant.com',
    'api_version': 'v1',
    'api_timeout': 30,

    // Firebase Configuration
    'firebase_project_id': 'waste-sorting-assistant',
    'firebase_api_key': 'AIzaSyBdlO1jy-zh8Lf28bvzee9SbqP-3THMqKE',
    'firebase_app_id': '1:699854541918:web:dev-app-id',
    'firebase_messaging_sender_id': '699854541918',

    // ML Kit Configuration
    'use_cloud_ml_kit': false,
    'ml_confidence_threshold': 0.7,
    'max_image_size': 2048,

    // Feature Flags
    'enable_analytics': false,
    'enable_crash_reporting': false,
    'enable_push_notifications': true,
    'enable_offline_mode': true,
    'enable_dark_mode': true,

    // Performance Configuration
    'cache_size': 50 * 1024 * 1024, // 50MB
    'cache_expiry_hours': 24,
    'max_retry_attempts': 3,

    // App Information
    'app_name': 'Waste Sorting Assistant (Dev)',
    'app_version': '1.0.0-dev',
    'build_number': '1',

    // Debug/Logging
    'enable_debug_logs': true,
    'enable_network_logs': true,
  };

  // Staging Environment Configuration
  static final Map<String, dynamic> _stagingConfig = {
    // API Configuration
    'api_base_url': 'https://staging-api.wastesortingassistant.com',
    'api_version': 'v1',
    'api_timeout': 20,

    // Firebase Configuration
    'firebase_project_id': 'waste-sorting-assistant',
    'firebase_api_key': 'AIzaSyBdlO1jy-zh8Lf28bvzee9SbqP-3THMqKE',
    'firebase_app_id': '1:699854541918:web:staging-app-id',
    'firebase_messaging_sender_id': '699854541918',

    // ML Kit Configuration
    'use_cloud_ml_kit': true,
    'ml_confidence_threshold': 0.8,
    'max_image_size': 1024,

    // Feature Flags
    'enable_analytics': true,
    'enable_crash_reporting': true,
    'enable_push_notifications': true,
    'enable_offline_mode': true,
    'enable_dark_mode': true,

    // Performance Configuration
    'cache_size': 30 * 1024 * 1024, // 30MB
    'cache_expiry_hours': 12,
    'max_retry_attempts': 3,

    // App Information
    'app_name': 'Waste Sorting Assistant (Staging)',
    'app_version': '1.0.0-staging',
    'build_number': '1',

    // Debug/Logging
    'enable_debug_logs': false,
    'enable_network_logs': false,
  };

  // Production Environment Configuration
  static final Map<String, dynamic> _productionConfig = {
    // API Configuration
    'api_base_url': 'https://api.wastesortingassistant.com',
    'api_version': 'v1',
    'api_timeout': 15,

    // Firebase Configuration
    'firebase_project_id': 'waste-sorting-assistant',
    'firebase_api_key': 'AIzaSyBdlO1jy-zh8Lf28bvzee9SbqP-3THMqKE',
    'firebase_app_id': '1:699854541918:web:prod-app-id',
    'firebase_messaging_sender_id': '699854541918',

    // ML Kit Configuration
    'use_cloud_ml_kit': true,
    'ml_confidence_threshold': 0.85,
    'max_image_size': 1024,

    // Feature Flags
    'enable_analytics': true,
    'enable_crash_reporting': true,
    'enable_push_notifications': true,
    'enable_offline_mode': true,
    'enable_dark_mode': true,

    // Performance Configuration
    'cache_size': 20 * 1024 * 1024, // 20MB
    'cache_expiry_hours': 6,
    'max_retry_attempts': 2,

    // App Information
    'app_name': 'Waste Sorting Assistant',
    'app_version': '1.0.0',
    'build_number': '1',

    // Debug/Logging
    'enable_debug_logs': false,
    'enable_network_logs': false,
  };

  // Utility methods
  static bool get isDebug => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;

  static String get environmentName {
    switch (_environment) {
      case Environment.development:
        return 'Development';
      case Environment.staging:
        return 'Staging';
      case Environment.production:
        return 'Production';
    }
  }

  // Get configuration value by key with optional default
  static T getValue<T>(String key, {T? defaultValue}) {
    if (_config.containsKey(key)) {
      return _config[key] as T;
    }
    if (defaultValue != null) {
      return defaultValue;
    }
    throw ArgumentError(
        'Configuration key "$key" not found and no default value provided');
  }

  // Update configuration value at runtime (for testing or feature flags)
  static void updateValue(String key, dynamic value) {
    _config[key] = value;
  }

  // Print current configuration (for debugging)
  static void printConfiguration() {
    if (!enableDebugLogs) return;

    print('=== App Configuration ===');
    print('Environment: $environmentName');
    print('App Name: $appName');
    print('Version: $appVersion+$buildNumber');
    print('API Base URL: $apiBaseUrl');
    print('Firebase Project: $firebaseProjectId');
    print('Debug Logs: $enableDebugLogs');
    print('Analytics: $enableAnalytics');
    print('Crash Reporting: $enableCrashReporting');
    print('========================');
  }
}