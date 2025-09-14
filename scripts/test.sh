#!/bin/bash

# Waste Sorting Assistant - Test Script
# This script runs comprehensive testing including unit, widget, and integration tests

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
    echo "Usage: $0 [OPTIONS] [TEST_TYPE]"
    echo ""
    echo "Test Types:"
    echo "  unit         Run unit tests only"
    echo "  widget       Run widget tests only"
    echo "  integration  Run integration tests only"
    echo "  all          Run all tests (default)"
    echo ""
    echo "Options:"
    echo "  --coverage   Generate coverage report"
    echo "  --watch      Run tests in watch mode"
    echo "  --verbose    Enable verbose output"
    echo "  --no-sound-null-safety  Disable null safety"
    echo "  --help       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --coverage"
    echo "  $0 unit --verbose"
    echo "  $0 integration --watch"
}

# Default values
TEST_TYPE="all"
GENERATE_COVERAGE=false
WATCH_MODE=false
VERBOSE=false
NULL_SAFETY="--sound-null-safety"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --coverage)
            GENERATE_COVERAGE=true
            shift
            ;;
        --watch)
            WATCH_MODE=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --no-sound-null-safety)
            NULL_SAFETY="--no-sound-null-safety"
            shift
            ;;
        --help)
            show_usage
            exit 0
            ;;
        unit|widget|integration|all)
            TEST_TYPE=$1
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Set verbose flag
VERBOSE_FLAG=""
if [[ "$VERBOSE" == true ]]; then
    VERBOSE_FLAG="--reporter=expanded"
fi

# Set coverage flag
COVERAGE_FLAG=""
if [[ "$GENERATE_COVERAGE" == true ]]; then
    COVERAGE_FLAG="--coverage"
fi

# Set watch flag
WATCH_FLAG=""
if [[ "$WATCH_MODE" == true ]]; then
    WATCH_FLAG="--watch"
fi

# Function to check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi
}

# Function to get dependencies
get_dependencies() {
    print_info "Getting Flutter dependencies..."
    flutter pub get
    print_success "Dependencies updated"
}

# Function to run unit tests
run_unit_tests() {
    print_info "Running unit tests..."

    if [[ -d "test/unit" ]] || [[ -f "test/unit_test.dart" ]]; then
        flutter test test/unit/ $VERBOSE_FLAG $COVERAGE_FLAG $WATCH_FLAG $NULL_SAFETY || \
        flutter test test/ --name="*unit*" $VERBOSE_FLAG $COVERAGE_FLAG $WATCH_FLAG $NULL_SAFETY
        print_success "Unit tests completed"
    else
        print_warning "No unit tests found in test/unit/ directory"
    fi
}

# Function to run widget tests
run_widget_tests() {
    print_info "Running widget tests..."

    if [[ -d "test/widget" ]] || [[ -f "test/widget_test.dart" ]]; then
        flutter test test/widget/ $VERBOSE_FLAG $COVERAGE_FLAG $WATCH_FLAG $NULL_SAFETY || \
        flutter test test/ --name="*widget*" $VERBOSE_FLAG $COVERAGE_FLAG $WATCH_FLAG $NULL_SAFETY
        print_success "Widget tests completed"
    else
        print_warning "No widget tests found in test/widget/ directory"
    fi
}

# Function to run integration tests
run_integration_tests() {
    print_info "Running integration tests..."

    if [[ -d "integration_test" ]]; then
        # Check if Android emulator or iOS simulator is available
        if command -v adb &> /dev/null && adb devices | grep -q "device"; then
            print_info "Android device detected, running integration tests on Android..."
            flutter test integration_test/ $VERBOSE_FLAG $NULL_SAFETY
        elif [[ "$OSTYPE" == "darwin"* ]] && xcrun simctl list devices | grep -q "Booted"; then
            print_info "iOS simulator detected, running integration tests on iOS..."
            flutter test integration_test/ $VERBOSE_FLAG $NULL_SAFETY
        else
            print_warning "No connected device or running simulator found"
            print_info "Starting integration tests without device (may fail)..."
            flutter test integration_test/ $VERBOSE_FLAG $NULL_SAFETY || true
        fi
        print_success "Integration tests completed"
    else
        print_warning "No integration tests found in integration_test/ directory"
    fi
}

# Function to run all tests
run_all_tests() {
    print_info "Running all tests..."

    # Run unit tests first (fastest)
    run_unit_tests

    # Run widget tests
    run_widget_tests

    # Run integration tests last (slowest)
    run_integration_tests

    print_success "All tests completed"
}

# Function to generate coverage report
generate_coverage_report() {
    if [[ "$GENERATE_COVERAGE" == true ]]; then
        print_info "Generating coverage report..."

        # Check if coverage directory exists
        if [[ -d "coverage" ]]; then
            # Install lcov if not available (for HTML report generation)
            if command -v genhtml &> /dev/null; then
                genhtml coverage/lcov.info -o coverage/html
                print_success "HTML coverage report generated in coverage/html/"
                print_info "Open coverage/html/index.html in your browser to view the report"
            else
                print_warning "genhtml not found. Install lcov to generate HTML reports: brew install lcov (macOS) or apt-get install lcov (Linux)"
            fi

            # Show coverage summary
            if command -v lcov &> /dev/null; then
                lcov --summary coverage/lcov.info
            else
                print_info "Coverage data saved to coverage/lcov.info"
            fi
        else
            print_warning "No coverage data found. Make sure to run tests with --coverage flag"
        fi
    fi
}

# Function to run specific test type
run_tests() {
    case $TEST_TYPE in
        unit)
            run_unit_tests
            ;;
        widget)
            run_widget_tests
            ;;
        integration)
            run_integration_tests
            ;;
        all)
            run_all_tests
            ;;
        *)
            print_error "Unknown test type: $TEST_TYPE"
            exit 1
            ;;
    esac
}

# Function to show test statistics
show_test_stats() {
    print_info "Test Statistics:"

    # Count test files
    UNIT_TEST_COUNT=$(find test/ -name "*test.dart" -type f 2>/dev/null | wc -l || echo "0")
    INTEGRATION_TEST_COUNT=$(find integration_test/ -name "*test.dart" -type f 2>/dev/null | wc -l || echo "0")

    print_info "Unit/Widget test files: $UNIT_TEST_COUNT"
    print_info "Integration test files: $INTEGRATION_TEST_COUNT"

    # Show coverage if available
    if [[ -f "coverage/lcov.info" ]]; then
        print_info "Coverage report available: coverage/lcov.info"
    fi
}

# Main execution
main() {
    print_info "Starting test execution for: $TEST_TYPE"

    # Pre-test checks
    check_flutter
    get_dependencies

    # Run tests
    run_tests

    # Generate coverage report if requested
    generate_coverage_report

    # Show statistics
    show_test_stats

    print_success "Test execution completed! 🧪"
}

# Run main function
main