# Claude Code Configuration

This file contains configuration and documentation for Claude Code assistance.

## Build and Test Commands

### Build Commands
```bash
# Build for all platforms
./scripts/build.sh all --release

# Build Android APK
./scripts/build.sh android --release --test --analyze

# Build iOS
./scripts/build.sh ios --release --clean

# Build with analysis and tests
./scripts/build.sh android --release --analyze --test --verbose
```

### Test Commands
```bash
# Run all tests with coverage
./scripts/test.sh --coverage

# Run unit tests only
./scripts/test.sh unit --verbose

# Run widget tests
./scripts/test.sh widget --coverage

# Run integration tests
./scripts/test.sh integration

# Watch mode for development
./scripts/test.sh unit --watch
```

### Code Quality Commands
```bash
# Run full code quality check
./scripts/quality-check.sh

# Auto-fix formatting issues
./scripts/quality-check.sh --fix

# Strict mode for CI
./scripts/quality-check.sh --ci --strict

# Verbose output for debugging
./scripts/quality-check.sh --verbose
```

### Flutter Commands
```bash
# Get dependencies
flutter pub get

# Run static analysis
flutter analyze

# Format code
dart format .

# Run tests
flutter test

# Clean build
flutter clean
```

## Project Structure

```
lib/
├── core/                   # Core utilities and constants
│   ├── constants/         # App colors, strings, styles, assets
│   ├── exceptions/        # Custom exception classes
│   ├── utils/            # Helpers and validators
│   └── widgets/          # Reusable custom widgets
├── data/                  # Data layer
│   ├── datasources/      # Local and remote data sources
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
├── domain/               # Business logic layer
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business use cases
├── presentation/         # UI layer
│   ├── screens/          # Screen widgets and view models
│   ├── routes/           # App navigation
│   └── theme/            # App themes
└── services/             # External services
```

## CI/CD Pipeline

### Required Checks for PR Approval
1. ✅ Code Quality Checks (formatting, linting)
2. ✅ Unit and Widget Tests
3. ✅ Android Build Success
4. ✅ iOS Build Success (macOS runner)
5. ✅ Security Vulnerability Scan
6. ✅ Performance and Size Analysis

### Branch Protection Rules
- **main**: Requires 1 approval + all status checks
- **develop**: Requires 1 approval + core status checks
- Force push disabled
- Delete protection enabled
- Conversation resolution required

## Development Guidelines

### Code Style
- Use `dart format` for formatting
- Follow analysis_options.yaml rules
- Single quotes for strings
- Trailing commas for better diffs
- 80 character line limit

### Testing
- Minimum 80% code coverage
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for user flows
- Mock external dependencies

### Naming Conventions
- Files: snake_case
- Classes: PascalCase
- Variables/functions: camelCase
- Constants: UPPER_CASE
- Private members: _leadingUnderscore

### Commit Messages
- Use conventional commits format
- Examples:
  - `feat: add waste scanning feature`
  - `fix: resolve camera permission issue`
  - `docs: update API documentation`
  - `test: add unit tests for validators`

## Environment Setup

### Prerequisites
- Flutter SDK 3.24.3+
- Dart SDK (included with Flutter)
- Android Studio / Xcode
- Firebase project configuration

### Dependencies
- firebase_core: Firebase initialization
- firebase_auth: User authentication
- cloud_firestore: Database
- google_ml_kit: Image recognition
- provider: State management
- image_picker: Camera/gallery access

### Firebase Setup
1. Create Firebase project
2. Add Android/iOS apps
3. Download configuration files
4. Place in appropriate directories
5. Enable Authentication and Firestore

## Troubleshooting

### Common Issues
1. **Build failures**: Run `flutter clean && flutter pub get`
2. **Analysis errors**: Check analysis_options.yaml rules
3. **Test failures**: Ensure proper mock setup
4. **Firebase issues**: Verify configuration files

### Performance Tips
- Use const constructors where possible
- Implement proper lifecycle management
- Optimize image loading and caching
- Profile app regularly
- Monitor APK/IPA size

## Security Checklist
- ✅ No hardcoded secrets or API keys
- ✅ Proper input validation
- ✅ Secure storage for sensitive data
- ✅ HTTPS for network requests
- ✅ Permission handling
- ✅ Data encryption where needed