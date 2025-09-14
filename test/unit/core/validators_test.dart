import 'package:flutter_test/flutter_test.dart';
import 'package:waste_sorting_assistant/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateEmail', () {
      test('should return null for valid email addresses', () {
        const validEmails = [
          'test@example.com',
          'user123@domain.co.uk',
          'first.last@subdomain.example.org',
          'user+tag@example.com',
        ];

        for (final email in validEmails) {
          expect(Validators.validateEmail(email), isNull);
        }
      });

      test('should return error for invalid email addresses', () {
        const invalidEmails = [
          'invalid-email',
          '@example.com',
          'user@',
          'user.example.com',
          '',
        ];

        for (final email in invalidEmails) {
          expect(Validators.validateEmail(email), isNotNull);
        }
      });

      test('should return error for null email', () {
        expect(Validators.validateEmail(null), isNotNull);
      });
    });

    group('validatePassword', () {
      test('should return null for valid passwords', () {
        const validPasswords = [
          'password123',
          'strongPassword!',
          '123456',
          'aaaaaa', // exactly 6 characters
        ];

        for (final password in validPasswords) {
          expect(Validators.validatePassword(password), isNull);
        }
      });

      test('should return error for short passwords', () {
        const shortPasswords = [
          '12345',
          'abc',
          '',
        ];

        for (final password in shortPasswords) {
          expect(Validators.validatePassword(password), isNotNull);
        }
      });

      test('should return error for null password', () {
        expect(Validators.validatePassword(null), isNotNull);
      });
    });

    group('validateConfirmPassword', () {
      test('should return null when passwords match', () {
        const password = 'testpassword123';
        expect(
          Validators.validateConfirmPassword(password, password),
          isNull,
        );
      });

      test('should return error when passwords do not match', () {
        expect(
          Validators.validateConfirmPassword('password1', 'password2'),
          isNotNull,
        );
      });

      test('should return error for null confirm password', () {
        expect(
          Validators.validateConfirmPassword(null, 'password'),
          isNotNull,
        );
      });
    });

    group('validateName', () {
      test('should return null for valid names', () {
        const validNames = [
          'John Doe',
          'Alice',
          'Bob Smith Jr',
        ];

        for (final name in validNames) {
          expect(Validators.validateName(name), isNull);
        }
      });

      test('should return error for invalid names', () {
        const invalidNames = [
          'A', // too short
          '', // empty
          '123', // numbers
          'Name!', // special characters
          'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', // too long (51 characters)
        ];

        for (final name in invalidNames) {
          expect(Validators.validateName(name), isNotNull);
        }
      });
    });

    group('validatePhoneNumber', () {
      test('should return null for valid phone numbers', () {
        const validPhones = [
          '+1234567890',
          '(123) 456-7890',
          '123-456-7890',
          '1234567890',
        ];

        for (final phone in validPhones) {
          expect(Validators.validatePhoneNumber(phone), isNull);
        }
      });

      test('should return null for empty phone (optional)', () {
        expect(Validators.validatePhoneNumber(''), isNull);
        expect(Validators.validatePhoneNumber(null), isNull);
      });

      test('should return error for invalid phone numbers', () {
        const invalidPhones = [
          '123', // too short
          'abc123def456', // letters
          '12345678901234567890', // too long
        ];

        for (final phone in invalidPhones) {
          expect(Validators.validatePhoneNumber(phone), isNotNull);
        }
      });
    });

    group('validateWasteCategory', () {
      test('should return null for valid waste categories', () {
        const validCategories = [
          'recyclable',
          'organic',
          'hazardous',
          'general',
          'electronic',
          'glass',
          'plastic',
          'paper',
          'metal',
        ];

        for (final category in validCategories) {
          expect(Validators.validateWasteCategory(category), isNull);
        }
      });

      test('should return null for valid categories in different case', () {
        const categories = [
          'RECYCLABLE',
          'Organic',
          'HaZaRdOuS',
        ];

        for (final category in categories) {
          expect(Validators.validateWasteCategory(category), isNull);
        }
      });

      test('should return error for invalid waste categories', () {
        const invalidCategories = [
          'invalid',
          '',
          'unknown',
        ];

        for (final category in invalidCategories) {
          expect(Validators.validateWasteCategory(category), isNotNull);
        }
      });
    });

    group('validateFileSize', () {
      test('should return null for acceptable file sizes', () {
        const acceptableSizes = [
          1024, // 1KB
          1024 * 1024, // 1MB
          5 * 1024 * 1024, // 5MB
          10 * 1024 * 1024, // 10MB (default limit)
        ];

        for (final size in acceptableSizes) {
          expect(Validators.validateFileSize(size), isNull);
        }
      });

      test('should return error for oversized files', () {
        const oversizedFiles = [
          11 * 1024 * 1024, // 11MB (over default 10MB limit)
          50 * 1024 * 1024, // 50MB
        ];

        for (final size in oversizedFiles) {
          expect(Validators.validateFileSize(size), isNotNull);
        }
      });

      test('should respect custom size limits', () {
        const fileSize = 3 * 1024 * 1024; // 3MB

        // Should pass with 5MB limit
        expect(Validators.validateFileSize(fileSize, maxSizeInMB: 5), isNull);

        // Should fail with 2MB limit
        expect(
          Validators.validateFileSize(fileSize, maxSizeInMB: 2),
          isNotNull,
        );
      });
    });

    group('validateImageFile', () {
      test('should return null for valid image files', () {
        const validImageFiles = [
          'image.jpg',
          'photo.jpeg',
          'picture.png',
          'animated.gif',
          'bitmap.bmp',
          'modern.webp',
        ];

        for (final fileName in validImageFiles) {
          expect(Validators.validateImageFile(fileName), isNull);
        }
      });

      test('should return error for invalid image files', () {
        const invalidImageFiles = [
          'document.pdf',
          'video.mp4',
          'audio.mp3',
          'text.txt',
          '',
        ];

        for (final fileName in invalidImageFiles) {
          expect(Validators.validateImageFile(fileName), isNotNull);
        }
      });

      test('should be case insensitive', () {
        const mixedCaseFiles = [
          'IMAGE.JPG',
          'Photo.JPEG',
          'Picture.PNG',
        ];

        for (final fileName in mixedCaseFiles) {
          expect(Validators.validateImageFile(fileName), isNull);
        }
      });
    });

    group('combineValidators', () {
      test('should return first validation error', () {
        final validators = [
          (String? value) => value == 'error1' ? 'First error' : null,
          (String? value) => value == 'error2' ? 'Second error' : null,
        ];

        expect(
          Validators.combineValidators('error1', validators),
          equals('First error'),
        );
      });

      test('should return null if all validators pass', () {
        final validators = [
          (String? value) => value?.isEmpty == true ? 'Empty' : null,
          (String? value) => value?.length == 1 ? 'Too short' : null,
        ];

        expect(
          Validators.combineValidators('valid input', validators),
          isNull,
        );
      });

      test('should work with empty validator list', () {
        expect(
          Validators.combineValidators('any value', []),
          isNull,
        );
      });
    });
  });
}