import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waste_sorting_assistant/core/utils/helpers.dart';

void main() {
  group('Helpers', () {
    group('formatFileSize', () {
      test('should format bytes correctly', () {
        expect(Helpers.formatFileSize(0), equals('0 B'));
        expect(Helpers.formatFileSize(512), equals('512 B'));
        expect(Helpers.formatFileSize(1024), equals('1 KB'));
        expect(Helpers.formatFileSize(1536), equals('2 KB')); // 1.5KB rounded
        expect(Helpers.formatFileSize(1024 * 1024), equals('1.0 MB'));
        expect(Helpers.formatFileSize(1024 * 1024 * 1024), equals('1.0 GB'));
      });

      test('should handle negative values', () {
        expect(Helpers.formatFileSize(-100), equals('0 B'));
      });
    });

    group('formatNumber', () {
      test('should add commas to large numbers', () {
        expect(Helpers.formatNumber(1234), equals('1,234'));
        expect(Helpers.formatNumber(1234567), equals('1,234,567'));
        expect(Helpers.formatNumber(1234567890), equals('1,234,567,890'));
      });

      test('should handle small numbers without commas', () {
        expect(Helpers.formatNumber(123), equals('123'));
        expect(Helpers.formatNumber(0), equals('0'));
      });

      test('should handle decimal numbers', () {
        expect(Helpers.formatNumber(1234.56), equals('1,234.56'));
      });
    });

    group('formatPercentage', () {
      test('should format percentage with default decimals', () {
        expect(Helpers.formatPercentage(0.1234), equals('12.3%'));
        expect(Helpers.formatPercentage(0.5), equals('50.0%'));
        expect(Helpers.formatPercentage(1.0), equals('100.0%'));
      });

      test('should format percentage with custom decimals', () {
        expect(Helpers.formatPercentage(0.1234, decimals: 2), equals('12.34%'));
        expect(Helpers.formatPercentage(0.1234, decimals: 0), equals('12%'));
      });
    });

    group('formatDateTime', () {
      test('should format today correctly', () {
        final now = DateTime.now();
        final result = Helpers.formatDateTime(now);
        expect(result, contains('Today'));
        expect(result, contains(':'));
      });

      test('should format yesterday correctly', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final result = Helpers.formatDateTime(yesterday);
        expect(result, contains('Yesterday'));
      });

      test('should format older dates with date', () {
        final oldDate = DateTime(2023, 1, 15, 14, 30);
        final result = Helpers.formatDateTime(oldDate);
        expect(result, contains('15/1/2023'));
      });

      test('should exclude time when requested', () {
        final now = DateTime.now();
        final result = Helpers.formatDateTime(now, includeTime: false);
        expect(result, equals('Today'));
        expect(result, isNot(contains(':')));
      });
    });

    group('formatTimeAgo', () {
      test('should format recent times correctly', () {
        final now = DateTime.now();

        expect(
          Helpers.formatTimeAgo(now.subtract(const Duration(seconds: 30))),
          equals('Just now'),
        );

        expect(
          Helpers.formatTimeAgo(now.subtract(const Duration(minutes: 5))),
          equals('5m ago'),
        );

        expect(
          Helpers.formatTimeAgo(now.subtract(const Duration(hours: 2))),
          equals('2h ago'),
        );

        expect(
          Helpers.formatTimeAgo(now.subtract(const Duration(days: 3))),
          equals('3d ago'),
        );
      });

      test('should format longer time periods', () {
        final now = DateTime.now();

        expect(
          Helpers.formatTimeAgo(now.subtract(const Duration(days: 14))),
          equals('2w ago'),
        );

        expect(
          Helpers.formatTimeAgo(now.subtract(const Duration(days: 60))),
          equals('2mo ago'),
        );

        expect(
          Helpers.formatTimeAgo(now.subtract(const Duration(days: 400))),
          equals('1y ago'),
        );
      });
    });

    group('truncateText', () {
      test('should truncate long text', () {
        const longText = 'This is a very long text that should be truncated';
        expect(
          Helpers.truncateText(longText, 20),
          equals('This is a very lo...'),
        );
      });

      test('should not truncate short text', () {
        const shortText = 'Short text';
        expect(
          Helpers.truncateText(shortText, 20),
          equals(shortText),
        );
      });

      test('should use custom suffix', () {
        const text = 'This is a long text';
        expect(
          Helpers.truncateText(text, 10, suffix: '>>>'),
          equals('This i>>>'),
        );
      });
    });

    group('capitalizeFirst', () {
      test('should capitalize first letter', () {
        expect(Helpers.capitalizeFirst('hello'), equals('Hello'));
        expect(Helpers.capitalizeFirst('WORLD'), equals('World'));
        expect(Helpers.capitalizeFirst('tEST'), equals('Test'));
      });

      test('should handle empty string', () {
        expect(Helpers.capitalizeFirst(''), equals(''));
      });

      test('should handle single character', () {
        expect(Helpers.capitalizeFirst('a'), equals('A'));
      });
    });

    group('capitalizeWords', () {
      test('should capitalize each word', () {
        expect(
          Helpers.capitalizeWords('hello world'),
          equals('Hello World'),
        );
        expect(
          Helpers.capitalizeWords('THIS IS A TEST'),
          equals('This Is A Test'),
        );
      });

      test('should handle empty string', () {
        expect(Helpers.capitalizeWords(''), equals(''));
      });

      test('should handle extra spaces', () {
        expect(
          Helpers.capitalizeWords('hello  world'),
          equals('Hello  World'),
        );
      });
    });

    group('generateRandomString', () {
      test('should generate string of correct length', () {
        expect(Helpers.generateRandomString(10).length, equals(10));
        expect(Helpers.generateRandomString(5).length, equals(5));
        expect(Helpers.generateRandomString(0).length, equals(0));
      });

      test('should generate different strings', () {
        final string1 = Helpers.generateRandomString(10);
        final string2 = Helpers.generateRandomString(10);
        expect(string1, isNot(equals(string2)));
      });

      test('should contain only alphanumeric characters', () {
        final randomString = Helpers.generateRandomString(20);
        final validPattern = RegExp(r'^[a-zA-Z0-9]+$');
        expect(validPattern.hasMatch(randomString), isTrue);
      });
    });

    group('getWasteCategoryColor', () {
      test('should return correct colors for waste categories', () {
        expect(
          Helpers.getWasteCategoryColor('recyclable'),
          equals(const Color(0xFF4CAF50)),
        );
        expect(
          Helpers.getWasteCategoryColor('plastic'),
          equals(const Color(0xFFFF9800)),
        );
        expect(
          Helpers.getWasteCategoryColor('paper'),
          equals(const Color(0xFF795548)),
        );
      });

      test('should be case insensitive', () {
        expect(
          Helpers.getWasteCategoryColor('RECYCLABLE'),
          equals(Helpers.getWasteCategoryColor('recyclable')),
        );
      });

      test('should return default color for unknown category', () {
        expect(
          Helpers.getWasteCategoryColor('unknown'),
          equals(const Color(0xFF9E9E9E)), // AppColors.grey
        );
      });
    });

    group('isNumeric', () {
      test('should return true for numeric strings', () {
        expect(Helpers.isNumeric('123'), isTrue);
        expect(Helpers.isNumeric('123.45'), isTrue);
        expect(Helpers.isNumeric('-123'), isTrue);
        expect(Helpers.isNumeric('0'), isTrue);
      });

      test('should return false for non-numeric strings', () {
        expect(Helpers.isNumeric('abc'), isFalse);
        expect(Helpers.isNumeric('12a3'), isFalse);
        expect(Helpers.isNumeric(''), isFalse);
        expect(Helpers.isNumeric(' '), isFalse);
      });
    });

    group('isValidEmail', () {
      test('should return true for valid emails', () {
        expect(Helpers.isValidEmail('test@example.com'), isTrue);
        expect(Helpers.isValidEmail('user.name@domain.co.uk'), isTrue);
      });

      test('should return false for invalid emails', () {
        expect(Helpers.isValidEmail('invalid-email'), isFalse);
        expect(Helpers.isValidEmail('@example.com'), isFalse);
        expect(Helpers.isValidEmail('test@'), isFalse);
      });
    });

    group('getFileExtension', () {
      test('should extract file extension correctly', () {
        expect(Helpers.getFileExtension('file.txt'), equals('txt'));
        expect(Helpers.getFileExtension('image.jpg'), equals('jpg'));
        expect(Helpers.getFileExtension('document.pdf'), equals('pdf'));
      });

      test('should handle files without extension', () {
        expect(Helpers.getFileExtension('filename'), equals(''));
      });

      test('should handle multiple dots', () {
        expect(Helpers.getFileExtension('file.name.txt'), equals('txt'));
      });

      test('should convert to lowercase', () {
        expect(Helpers.getFileExtension('FILE.TXT'), equals('txt'));
      });
    });

    group('isImageFile', () {
      test('should return true for image files', () {
        const imageFiles = ['test.jpg', 'image.png', 'photo.gif', 'pic.webp'];
        for (final file in imageFiles) {
          expect(Helpers.isImageFile(file), isTrue);
        }
      });

      test('should return false for non-image files', () {
        const nonImageFiles = ['doc.pdf', 'video.mp4', 'audio.mp3', 'data.txt'];
        for (final file in nonImageFiles) {
          expect(Helpers.isImageFile(file), isFalse);
        }
      });
    });

    group('getInitials', () {
      test('should extract initials from full name', () {
        expect(Helpers.getInitials('John Doe'), equals('JD'));
        expect(Helpers.getInitials('Alice Bob Charlie'), equals('AB'));
      });

      test('should handle single name', () {
        expect(Helpers.getInitials('Alice'), equals('A'));
      });

      test('should handle empty string', () {
        expect(Helpers.getInitials(''), equals(''));
      });

      test('should handle extra spaces', () {
        expect(Helpers.getInitials('  John   Doe  '), equals('JD'));
      });
    });

    group('calculateCO2Savings', () {
      test('should calculate CO2 savings for different waste types', () {
        expect(Helpers.calculateCO2Savings('paper', 1.0), equals(3.3));
        expect(Helpers.calculateCO2Savings('plastic', 2.0), equals(4.0));
        expect(Helpers.calculateCO2Savings('unknown', 1.0), equals(1.0));
      });

      test('should handle zero weight', () {
        expect(Helpers.calculateCO2Savings('paper', 0.0), equals(0.0));
      });

      test('should be case insensitive', () {
        expect(
          Helpers.calculateCO2Savings('PAPER', 1.0),
          equals(Helpers.calculateCO2Savings('paper', 1.0)),
        );
      });
    });
  });
}