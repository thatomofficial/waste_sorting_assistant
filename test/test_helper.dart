import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test helper class to provide common test utilities and setup
class TestHelper {
  /// Setup method channels for testing
  static void setupMethodChannels() {
    // Setup Firebase Core method channel
    const firebaseCoreChannel = MethodChannel('plugins.flutter.io/firebase_core');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(firebaseCoreChannel, (methodCall) async {
      switch (methodCall.method) {
        case 'Firebase#initializeCore':
          return {
            'name': '[DEFAULT]',
            'options': {
              'apiKey': 'fake-api-key',
              'appId': 'fake-app-id',
              'messagingSenderId': 'fake-sender-id',
              'projectId': 'fake-project-id',
            },
            'pluginConstants': <String, dynamic>{},
          };
        default:
          return null;
      }
    });

    // Setup Firebase Auth method channel
    const firebaseAuthChannel = MethodChannel('plugins.flutter.io/firebase_auth');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(firebaseAuthChannel, (methodCall) async {
      switch (methodCall.method) {
        case 'Auth#registerIdTokenListener':
        case 'Auth#registerAuthStateListener':
          return null;
        case 'Auth#signInWithEmailAndPassword':
          return {
            'user': {
              'uid': 'test-uid',
              'email': 'test@example.com',
              'displayName': 'Test User',
            },
            'additionalUserInfo': {'isNewUser': false},
          };
        case 'Auth#createUserWithEmailAndPassword':
          return {
            'user': {
              'uid': 'new-test-uid',
              'email': 'newtest@example.com',
              'displayName': 'New Test User',
            },
            'additionalUserInfo': {'isNewUser': true},
          };
        case 'Auth#signOut':
          return null;
        case 'Auth#currentUser':
          return null;
        default:
          return null;
      }
    });

    // Setup Firestore method channel
    const firestoreChannel = MethodChannel('plugins.flutter.io/cloud_firestore');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(firestoreChannel, (methodCall) async {
      return {};
    });

    // Setup Image Picker method channel
    const imagePickerChannel = MethodChannel('plugins.flutter.io/image_picker');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(imagePickerChannel, (methodCall) async {
      return null;
    });

    // Setup Google ML Kit method channels
    const mlKitChannel = MethodChannel('google_ml_kit');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(mlKitChannel, (methodCall) async {
      switch (methodCall.method) {
        case 'vision#processImage':
          return [
            {
              'text': 'plastic bottle',
              'confidence': 0.95,
            }
          ];
        default:
          return [];
      }
    });

    // Setup Camera method channel
    const cameraChannel = MethodChannel('plugins.flutter.io/camera');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(cameraChannel, (methodCall) async {
      return {};
    });

    // Setup Local Notifications method channel
    const notificationsChannel = MethodChannel('dexterous.com/flutter/local_notifications');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(notificationsChannel, (methodCall) async {
      return true;
    });
  }

  /// Cleanup method channels after tests
  static void cleanupMethodChannels() {
    const channels = [
      'plugins.flutter.io/firebase_core',
      'plugins.flutter.io/firebase_auth',
      'plugins.flutter.io/cloud_firestore',
      'plugins.flutter.io/image_picker',
      'google_ml_kit',
      'plugins.flutter.io/camera',
      'dexterous.com/flutter/local_notifications',
    ];

    for (final channel in channels) {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(MethodChannel(channel), null);
    }
  }

  /// Create a test binding with proper setup
  static void setupTestBinding() {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupMethodChannels();
  }

  /// Wait for async operations to complete
  static Future<void> waitForAsync() async {
    await Future<void>.delayed(Duration.zero);
  }

  /// Pump frames until no more frames are scheduled
  static Future<void> pumpUntilNoMoreFrames(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }
}

/// Common test data for use across tests
class TestData {
  // User test data
  static const String testEmail = 'test@example.com';
  static const String testPassword = 'testpassword123';
  static const String testUserId = 'test-user-id';
  static const String testUserName = 'Test User';

  // Waste item test data
  static const String testWasteItemId = 'test-waste-item-id';
  static const String testWasteCategory = 'plastic';
  static const String testWasteDescription = 'Plastic bottle';
  static const double testWasteConfidence = 0.95;

  // Image test data
  static const String testImagePath = '/fake/path/to/image.jpg';
  static const String testImageBase64 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==';

  // Firebase test data
  static const Map<String, dynamic> testFirebaseUser = {
    'uid': testUserId,
    'email': testEmail,
    'displayName': testUserName,
    'photoURL': null,
    'emailVerified': true,
  };

  static const Map<String, dynamic> testWasteItemData = {
    'id': testWasteItemId,
    'category': testWasteCategory,
    'description': testWasteDescription,
    'confidence': testWasteConfidence,
    'timestamp': '2024-01-15T10:30:00Z',
    'imagePath': testImagePath,
  };
}

/// Custom matchers for testing
class TestMatchers {
  /// Matcher to verify that a widget has specific text
  static Matcher hasText(String text) => findsOneWidget;

  /// Matcher to verify widget visibility
  static Matcher isVisible() => findsOneWidget;

  /// Matcher to verify widget is not present
  static Matcher isNotPresent() => findsNothing;

  /// Matcher for checking error states
  static Matcher hasErrorState() => findsOneWidget;
}