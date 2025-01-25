# Waste Sorting Assistant

A new Flutter project aimed at assisting users with waste sorting.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)

- [Contributing](#contributing)
- [Contact](#contact)

## Introduction

Waste Sorting Assistant is a Flutter application designed to help users sort their waste correctly. The app provides information on how to dispose of various types of waste and aims to promote recycling and proper waste management.

## Features

- User authentication (sign up, sign in, sign out)
- Firebase integration
- Home screen with waste sorting information
- User-friendly interface

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

1. Launch the app on your device or emulator.
2. Sign up or sign in using your email and password.
3. Navigate through the home screen to find information on how to sort different types of waste.

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

[//]: # (## License)

[//]: # (This project is licensed under the MIT License. See the [LICENSE]&#40;LICENSE&#41; file for details.)

## Contact

For any inquiries or feedback, please contact:

- Name: Thato Mokgotsi
- Email: mokgotsitt@gmail.com
- GitHub: [thatomofficial](https://github.com/thatomofficial)