# Waste Sorting Assistant

A new Flutter project aimed at assisting users with waste sorting.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [API Integration](#api-integration)
- [Permissions](#permissions)
- [Testing](#testing)
- [Build and Deployment](#build-and-deployment)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Environmental Impact](#environmental-impact)
- [Roadmap](#roadmap)
- [Changelog](#changelog)
- [Contact](#contact)

## Introduction

Waste Sorting Assistant is a Flutter application designed to help users sort their waste correctly. The app provides information on how to dispose of various types of waste and aims to promote recycling and proper waste management.

## Features

- **Image Recognition**: AI-powered waste identification using Google ML Kit
- **User Authentication**: Secure sign up, sign in, and sign out functionality
- **Camera Integration**: Take photos or upload images of waste items for identification
- **Waste Scanning**: Real-time scanning with camera overlay for optimal image capture
- **Personalized Profile**: User profile management and waste sorting statistics
- **Firebase Integration**: Cloud storage and real-time data synchronization
- **Local Notifications**: Reminders and updates about waste sorting
- **Dark Mode Support**: Adaptive theming for better user experience
- **Statistics Tracking**: Monitor your waste sorting progress and environmental impact
- **Offline Support**: Local data caching for offline functionality

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter
- Firebase account: [Create Firebase account](https://firebase.google.com/)

### Steps

1. Clone the repository:
    ```sh
    git clone https://github.com/thatomofficial/waste_sorting_assistant.git
    cd waste_sorting_assistant
    ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Set up Firebase:
    - Follow the instructions to add Firebase to your Flutter app: [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup)
    - Update the `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` files with your Firebase project configuration.

4. Run the app:
    ```sh
    flutter run
    ```

## Usage

### Getting Started
1. Launch the app on your device or emulator.
2. Sign up or sign in using your email and password.
3. Allow camera and storage permissions when prompted.

### Scanning Waste Items
1. Tap the **Scan** button on the home screen.
2. Point your camera at the waste item you want to identify.
3. Use the camera overlay for optimal framing.
4. Take a photo or select an existing image from your gallery.
5. View the AI-powered recommendations for proper disposal.

### Tracking Progress
1. Navigate to your **Profile** to view sorting statistics.
2. Track your environmental impact and waste sorting habits.
3. Set up notifications for sorting reminders.

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   ├── app_styles.dart
│   │   └── app_assets.dart
│   ├── exceptions/
│   │   └── custom_exception.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   └── helpers.dart
│   └── widgets/
│       ├── custom_button.dart
│       └── custom_loader.dart
├── data/
│   ├── datasources/
│   │   ├── local/
│   │   │   └── local_data_source.dart
│   │   ├── remote/
│   │       └── firebase_data_source.dart
│   ├── models/
│   │   ├── waste_item_model.dart
│   │   └── user_model.dart
│   ├── repositories/
│       ├── waste_repository_impl.dart
│       └── user_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── waste_item.dart
│   │   └── user.dart
│   ├── repositories/
│   │   ├── waste_repository.dart
│   │   └── user_repository.dart
│   └── usecases/
│       ├── get_waste_recommendation.dart
│       ├── save_user_data.dart
│       └── track_waste_sorting.dart
├── presentation/
│   ├── screens/
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   ├── home_view_model.dart
│   │   │   └── widgets/
│   │   │       ├── waste_card.dart
│   │   │       └── statistics_card.dart
│   │   ├── scan/
│   │   │   ├── scan_screen.dart
│   │   │   ├── scan_view_model.dart
│   │   │   └── widgets/
│   │   │       ├── camera_overlay.dart
│   │   │       └── scan_results_card.dart
│   │   ├── profile/
│   │       ├── profile_screen.dart
│   │       ├── profile_view_model.dart
│   │       └── widgets/
│   │           └── profile_card.dart
│   ├── routes/
│   │   └── app_routes.dart
│   └── theme/
│       ├── theme_data.dart
│       └── dark_theme.dart
├── services/
│   ├── auth_service.dart
│   ├── user_service.dart
│   └── waste_item_service.dart
├── main.dart

```

## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

- **Domain Layer**: Contains business entities, repositories interfaces, and use cases
- **Data Layer**: Implements repository interfaces, handles data sources (Firebase, local storage)
- **Presentation Layer**: Contains screens, view models, and UI components
- **Core Layer**: Shared utilities, constants, and common widgets

### Key Technologies

- **Flutter**: Cross-platform mobile development framework
- **Firebase**: Backend services (Authentication, Firestore, Cloud Storage)
- **Google ML Kit**: On-device machine learning for image recognition
- **Provider**: State management solution
- **Clean Architecture**: Maintains separation of concerns and testability

## API Integration

The app integrates with several services:

- **Firebase Authentication**: User management and secure authentication
- **Cloud Firestore**: Real-time database for user data and waste sorting history
- **Google ML Kit Vision**: Image labeling and object detection for waste identification
- **Flutter Local Notifications**: Push notifications for reminders and updates

## Permissions

The app requires the following permissions:

### Android
- `CAMERA`: For taking photos of waste items
- `READ_EXTERNAL_STORAGE`: For selecting images from gallery
- `WRITE_EXTERNAL_STORAGE`: For saving captured images
- `INTERNET`: For Firebase connectivity
- `RECEIVE_BOOT_COMPLETED`: For local notifications

### iOS
- `NSCameraUsageDescription`: Camera access for waste scanning
- `NSPhotoLibraryUsageDescription`: Photo library access for image selection

## Testing

Run tests using:
```sh
flutter test
```

The project includes:
- Unit tests for business logic and use cases
- Widget tests for UI components
- Integration tests for user flows

## Build and Deployment

### Debug Build
```sh
flutter run --debug
```

### Release Build
```sh
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

## Troubleshooting

### Common Issues

1. **Firebase Configuration Error**
   - Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are properly configured
   - Verify Firebase project settings match your app's bundle identifier

2. **Camera Not Working**
   - Check device permissions for camera access
   - Ensure app has necessary permissions in device settings

3. **ML Kit Recognition Issues**
   - Verify internet connectivity for model downloads
   - Ensure adequate lighting when taking photos
   - Clean camera lens for better image quality

4. **Build Failures**
   - Run `flutter clean` and `flutter pub get`
   - Check Flutter and Dart SDK versions
   - Verify all dependencies are compatible

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch:
    ```sh
    git checkout -b feature/your-feature-name
    ```
3. Make your changes and commit them:
    ```sh
    git commit -m "Add your commit message"
    ```
4. Push to the branch:
    ```sh
    git push origin feature/your-feature-name
    ```
5. Create a pull request.

## Environmental Impact

The Waste Sorting Assistant contributes to environmental sustainability by:

- **Reducing Contamination**: Proper waste sorting prevents recyclable materials from ending up in landfills
- **Educational Value**: Teaches users about different waste categories and disposal methods
- **Behavioral Change**: Encourages consistent waste sorting habits through progress tracking
- **Community Impact**: Collective user data helps identify common sorting challenges

## Roadmap

### Version 1.1.0 (Planned)
- [ ] Offline mode improvements
- [ ] Barcode scanning for packaged items
- [ ] Community challenges and leaderboards
- [ ] Multi-language support

### Version 1.2.0 (Future)
- [ ] AR overlay for waste bin identification
- [ ] Integration with local waste management systems
- [ ] Advanced analytics and reporting
- [ ] Voice-guided instructions

## Changelog

### Version 1.0.0 (Current)
- Initial release with core functionality
- Image recognition for waste identification
- User authentication and profile management
- Firebase integration for data persistence
- Camera scanning with overlay
- Statistics tracking and notifications

[//]: # (## License)

[//]: # (This project is licensed under the MIT License. See the [LICENSE]&#40;LICENSE&#41; file for details.)

## Contact

For any inquiries or feedback, please contact:

- Name: Thato Mokgotsi
- Email: mokgotsitt@gmail.com
- GitHub: [thatomofficial](https://github.com/thatomofficial)