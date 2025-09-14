#!/bin/bash

# Waste Sorting Assistant - Build Script
# This script handles building the app for different platforms and configurations

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS] <platform>"
    echo ""
    echo "Platforms:"
    echo "  android      Build Android APK"
    echo "  android-aab  Build Android App Bundle"
    echo "  ios          Build iOS app"
    echo "  web          Build web app"
    echo "  all          Build for all platforms"
    echo ""
    echo "Options:"
    echo "  --release    Build in release mode (default: debug)"
    echo "  --analyze    Run static analysis before build"
    echo "  --test       Run tests before build"
    echo "  --clean      Clean before build"
    echo "  --verbose    Enable verbose output"
    echo "  --help       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 android --release --test"
    echo "  $0 ios --clean --analyze"
    echo "  $0 all --release"
}

# Default values
BUILD_MODE="debug"
RUN_ANALYSIS=false
RUN_TESTS=false
CLEAN_BUILD=false
VERBOSE=false
PLATFORM=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --release)
            BUILD_MODE="release"
            shift
            ;;
        --analyze)
            RUN_ANALYSIS=true
            shift
            ;;
        --test)
            RUN_TESTS=true
            shift
            ;;
        --clean)
            CLEAN_BUILD=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --help)
            show_usage
            exit 0
            ;;
        android|android-aab|ios|web|all)
            PLATFORM=$1
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Validate platform argument
if [[ -z "$PLATFORM" ]]; then
    print_error "Platform is required"
    show_usage
    exit 1
fi

# Set verbose flag
VERBOSE_FLAG=""
if [[ "$VERBOSE" == true ]]; then
    VERBOSE_FLAG="--verbose"
fi

# Function to check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi

    print_info "Flutter version:"
    flutter --version
}

# Function to get dependencies
get_dependencies() {
    print_info "Getting Flutter dependencies..."
    flutter pub get
    print_success "Dependencies updated"
}

# Function to clean build
clean_build() {
    if [[ "$CLEAN_BUILD" == true ]]; then
        print_info "Cleaning previous builds..."
        flutter clean
        get_dependencies
        print_success "Clean completed"
    fi
}

# Function to run static analysis
run_analysis() {
    if [[ "$RUN_ANALYSIS" == true ]]; then
        print_info "Running static analysis..."

        # Check formatting
        print_info "Checking code formatting..."
        if ! dart format --output=none --set-exit-if-changed .; then
            print_error "Code formatting issues found. Run 'dart format .' to fix."
            exit 1
        fi

        # Run analyzer
        flutter analyze --fatal-infos
        print_success "Static analysis completed"
    fi
}

# Function to run tests
run_tests() {
    if [[ "$RUN_TESTS" == true ]]; then
        print_info "Running tests..."
        flutter test --coverage
        print_success "Tests completed"
    fi
}

# Function to build Android APK
build_android_apk() {
    print_info "Building Android APK ($BUILD_MODE mode)..."

    if [[ "$BUILD_MODE" == "release" ]]; then
        flutter build apk --release $VERBOSE_FLAG

        # Get APK size
        APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
        if [[ -f "$APK_PATH" ]]; then
            APK_SIZE=$(stat -f%z "$APK_PATH" 2>/dev/null || stat -c%s "$APK_PATH")
            APK_SIZE_MB=$((APK_SIZE / 1024 / 1024))
            print_success "Android APK built successfully"
            print_info "APK size: ${APK_SIZE_MB} MB"
            print_info "APK location: $APK_PATH"
        fi
    else
        flutter build apk --debug $VERBOSE_FLAG
        print_success "Android APK (debug) built successfully"
    fi
}

# Function to build Android App Bundle
build_android_aab() {
    print_info "Building Android App Bundle ($BUILD_MODE mode)..."

    if [[ "$BUILD_MODE" == "release" ]]; then
        flutter build appbundle --release $VERBOSE_FLAG

        # Get AAB size
        AAB_PATH="build/app/outputs/bundle/release/app-release.aab"
        if [[ -f "$AAB_PATH" ]]; then
            AAB_SIZE=$(stat -f%z "$AAB_PATH" 2>/dev/null || stat -c%s "$AAB_PATH")
            AAB_SIZE_MB=$((AAB_SIZE / 1024 / 1024))
            print_success "Android App Bundle built successfully"
            print_info "AAB size: ${AAB_SIZE_MB} MB"
            print_info "AAB location: $AAB_PATH"
        fi
    else
        flutter build appbundle --debug $VERBOSE_FLAG
        print_success "Android App Bundle (debug) built successfully"
    fi
}

# Function to build iOS
build_ios() {
    print_info "Building iOS app ($BUILD_MODE mode)..."

    # Check if running on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_warning "iOS builds are only supported on macOS"
        return
    fi

    if [[ "$BUILD_MODE" == "release" ]]; then
        flutter build ios --release $VERBOSE_FLAG
    else
        flutter build ios --debug --no-codesign $VERBOSE_FLAG
    fi

    print_success "iOS build completed"
}

# Function to build web
build_web() {
    print_info "Building web app ($BUILD_MODE mode)..."

    if [[ "$BUILD_MODE" == "release" ]]; then
        flutter build web --release $VERBOSE_FLAG
    else
        flutter build web --debug $VERBOSE_FLAG
    fi

    print_success "Web build completed"
    print_info "Web build location: build/web/"
}

# Main build function
build_platform() {
    local platform=$1

    case $platform in
        android)
            build_android_apk
            ;;
        android-aab)
            build_android_aab
            ;;
        ios)
            build_ios
            ;;
        web)
            build_web
            ;;
        all)
            build_android_apk
            build_android_aab
            build_ios
            build_web
            ;;
        *)
            print_error "Unknown platform: $platform"
            exit 1
            ;;
    esac
}

# Main execution
main() {
    print_info "Starting build process for $PLATFORM platform(s) in $BUILD_MODE mode"

    # Pre-build checks
    check_flutter
    clean_build
    get_dependencies
    run_analysis
    run_tests

    # Build
    build_platform "$PLATFORM"

    print_success "Build process completed successfully! 🎉"
}

# Run main function
main