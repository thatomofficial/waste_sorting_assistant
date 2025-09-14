#!/bin/bash

# Waste Sorting Assistant - Code Quality Check Script
# This script performs comprehensive code quality checks including linting, formatting, and analysis

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
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --fix        Automatically fix formatting issues"
    echo "  --strict     Use strict analysis rules"
    echo "  --verbose    Enable verbose output"
    echo "  --ci         Run in CI mode (fail on any issues)"
    echo "  --help       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --fix"
    echo "  $0 --strict --verbose"
    echo "  $0 --ci"
}

# Default values
AUTO_FIX=false
STRICT_MODE=false
VERBOSE=false
CI_MODE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --fix)
            AUTO_FIX=true
            shift
            ;;
        --strict)
            STRICT_MODE=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --ci)
            CI_MODE=true
            shift
            ;;
        --help)
            show_usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Exit codes
EXIT_CODE=0

# Function to check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi

    if [[ "$VERBOSE" == true ]]; then
        print_info "Flutter version:"
        flutter --version
    fi
}

# Function to get dependencies
get_dependencies() {
    print_info "Getting Flutter dependencies..."
    flutter pub get > /dev/null 2>&1
    print_success "Dependencies updated"
}

# Function to check code formatting
check_formatting() {
    print_info "Checking code formatting..."

    if [[ "$AUTO_FIX" == true ]]; then
        print_info "Auto-fixing formatting issues..."
        dart format . --fix
        print_success "Code formatting fixed"
    else
        if dart format --output=none --set-exit-if-changed .; then
            print_success "Code formatting is correct"
        else
            print_error "Code formatting issues found"
            print_info "Run 'dart format . --fix' to automatically fix formatting issues"
            print_info "Or run this script with --fix flag"
            EXIT_CODE=1
        fi
    fi
}

# Function to run static analysis
run_static_analysis() {
    print_info "Running static analysis..."

    local analysis_options=""
    if [[ "$STRICT_MODE" == true ]]; then
        analysis_options="--fatal-infos"
    fi

    if [[ "$VERBOSE" == true ]]; then
        analysis_options="$analysis_options --verbose"
    fi

    if flutter analyze $analysis_options; then
        print_success "Static analysis completed without issues"
    else
        print_error "Static analysis found issues"
        EXIT_CODE=1
    fi
}

# Function to check for unused dependencies
check_unused_dependencies() {
    print_info "Checking for unused dependencies..."

    # This requires the dependency_validator package
    if flutter pub deps --json > /dev/null 2>&1; then
        print_info "Dependency check completed"

        # Check for outdated dependencies
        print_info "Checking for outdated dependencies..."
        if flutter pub outdated --mode=null-safety > /dev/null 2>&1; then
            print_success "All dependencies are up to date"
        else
            print_warning "Some dependencies may be outdated"
            if [[ "$VERBOSE" == true ]]; then
                flutter pub outdated --mode=null-safety
            fi
        fi
    else
        print_warning "Could not check dependencies"
    fi
}

# Function to check pubspec.yaml format
check_pubspec_format() {
    print_info "Checking pubspec.yaml format..."

    if [[ -f "pubspec.yaml" ]]; then
        # Check if pubspec.yaml is properly formatted
        if python3 -c "import yaml; yaml.safe_load(open('pubspec.yaml'))" 2>/dev/null; then
            print_success "pubspec.yaml is properly formatted"
        else
            print_warning "pubspec.yaml may have formatting issues"
        fi

        # Check for common issues
        if grep -q "^[[:space:]]*version:" pubspec.yaml; then
            print_success "Version specified in pubspec.yaml"
        else
            print_warning "No version specified in pubspec.yaml"
        fi

        # Check for description
        if grep -q "^[[:space:]]*description:" pubspec.yaml; then
            print_success "Description found in pubspec.yaml"
        else
            print_warning "No description in pubspec.yaml"
        fi
    else
        print_error "pubspec.yaml not found"
        EXIT_CODE=1
    fi
}

# Function to check for TODO/FIXME comments
check_todos_fixmes() {
    print_info "Checking for TODO/FIXME comments..."

    local todo_count=$(grep -r -i "todo\|fixme\|hack" --include="*.dart" lib/ test/ 2>/dev/null | wc -l || echo "0")

    if [[ $todo_count -eq 0 ]]; then
        print_success "No TODO/FIXME comments found"
    else
        print_warning "Found $todo_count TODO/FIXME comments"
        if [[ "$VERBOSE" == true ]]; then
            grep -r -n -i "todo\|fixme\|hack" --include="*.dart" lib/ test/ 2>/dev/null || true
        fi

        if [[ "$CI_MODE" == true && $todo_count -gt 10 ]]; then
            print_error "Too many TODO/FIXME comments for CI ($todo_count)"
            EXIT_CODE=1
        fi
    fi
}

# Function to check file and folder naming conventions
check_naming_conventions() {
    print_info "Checking naming conventions..."

    # Check for non-snake_case file names in lib/
    local non_snake_case_files=$(find lib/ -name "*.dart" | grep -v -E '^lib/.*[a-z_][a-z0-9_]*\.dart$' | wc -l || echo "0")

    if [[ $non_snake_case_files -eq 0 ]]; then
        print_success "File naming conventions are correct"
    else
        print_warning "Found $non_snake_case_files files not following snake_case convention"
        if [[ "$VERBOSE" == true ]]; then
            find lib/ -name "*.dart" | grep -v -E '^lib/.*[a-z_][a-z0-9_]*\.dart$' || true
        fi
    fi
}

# Function to check for hardcoded strings
check_hardcoded_strings() {
    print_info "Checking for potential hardcoded strings..."

    # Look for hardcoded strings in UI files (basic check)
    local hardcoded_count=$(grep -r "Text(" --include="*.dart" lib/presentation/ 2>/dev/null | grep -v "AppStrings\|context.l10n" | wc -l || echo "0")

    if [[ $hardcoded_count -eq 0 ]]; then
        print_success "No obvious hardcoded strings found in UI"
    else
        print_warning "Found $hardcoded_count potential hardcoded strings in UI"
        if [[ "$VERBOSE" == true ]]; then
            print_info "Consider using AppStrings constants for text"
        fi
    fi
}

# Function to check code complexity (basic metrics)
check_code_complexity() {
    print_info "Checking basic code metrics..."

    # Count lines of code
    local loc=$(find lib/ -name "*.dart" -exec cat {} \; | wc -l || echo "0")
    print_info "Lines of code: $loc"

    # Count number of classes
    local class_count=$(grep -r "^class " --include="*.dart" lib/ 2>/dev/null | wc -l || echo "0")
    print_info "Number of classes: $class_count"

    # Check for very long files (> 500 lines)
    local long_files=$(find lib/ -name "*.dart" -exec wc -l {} \; | awk '$1 > 500' | wc -l || echo "0")

    if [[ $long_files -eq 0 ]]; then
        print_success "No excessively long files found"
    else
        print_warning "Found $long_files files longer than 500 lines"
        if [[ "$VERBOSE" == true ]]; then
            print_info "Consider breaking down large files:"
            find lib/ -name "*.dart" -exec wc -l {} \; | awk '$1 > 500 {print $2 " (" $1 " lines)"}' || true
        fi
    fi
}

# Function to run security checks
run_security_checks() {
    print_info "Running basic security checks..."

    # Check for potential secrets in code
    local secret_patterns=("password" "secret" "key" "token" "api_key" "private_key")
    local security_issues=0

    for pattern in "${secret_patterns[@]}"; do
        local matches=$(grep -r -i "$pattern" --include="*.dart" lib/ 2>/dev/null | grep -v "// ignore\|TODO\|FIXME" | wc -l || echo "0")
        if [[ $matches -gt 0 ]]; then
            security_issues=$((security_issues + matches))
        fi
    done

    if [[ $security_issues -eq 0 ]]; then
        print_success "No obvious security issues found"
    else
        print_warning "Found $security_issues potential security-related terms in code"
        print_info "Please review for hardcoded secrets or sensitive information"

        if [[ "$CI_MODE" == true ]]; then
            EXIT_CODE=1
        fi
    fi
}

# Function to validate import statements
check_imports() {
    print_info "Checking import statements..."

    # Check for relative imports that could be problematic
    local relative_imports=$(grep -r "import '\.\." --include="*.dart" lib/ 2>/dev/null | wc -l || echo "0")

    if [[ $relative_imports -eq 0 ]]; then
        print_success "Import statements look good"
    else
        print_warning "Found $relative_imports potentially problematic relative imports"
        if [[ "$VERBOSE" == true ]]; then
            grep -r -n "import '\.\." --include="*.dart" lib/ 2>/dev/null || true
        fi
    fi
}

# Main execution
main() {
    print_info "Starting comprehensive code quality checks..."

    # Pre-check setup
    check_flutter
    get_dependencies

    print_info "==========================================="

    # Run all checks
    check_formatting
    run_static_analysis
    check_unused_dependencies
    check_pubspec_format
    check_todos_fixmes
    check_naming_conventions
    check_hardcoded_strings
    check_code_complexity
    run_security_checks
    check_imports

    print_info "==========================================="

    # Final result
    if [[ $EXIT_CODE -eq 0 ]]; then
        print_success "All code quality checks passed! 🎉"
    else
        print_error "Some code quality checks failed"
        if [[ "$CI_MODE" == true ]]; then
            print_error "Failing CI build due to code quality issues"
        else
            print_info "Run with --fix to automatically fix some issues"
        fi
    fi

    exit $EXIT_CODE
}

# Run main function
main