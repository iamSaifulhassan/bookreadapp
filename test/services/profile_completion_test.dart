import 'package:flutter_test/flutter_test.dart';
import 'package:thebookread/services/profile_image_utils.dart';

void main() {
  group('Profile Completion Tests', () {
    test('should detect incomplete profile with missing country', () {
      bool isIncomplete = ProfileImageUtils.isProfileIncomplete(
        '', // missing country
        'Student',
        '1234567890',
      );
      expect(isIncomplete, true);
    });

    test('should detect incomplete profile with missing user type', () {
      bool isIncomplete = ProfileImageUtils.isProfileIncomplete(
        'Pakistan',
        '', // missing user type
        '1234567890',
      );
      expect(isIncomplete, true);
    });

    test('should detect incomplete profile with missing phone', () {
      bool isIncomplete = ProfileImageUtils.isProfileIncomplete(
        'Pakistan',
        'Student',
        '', // missing phone
      );
      expect(isIncomplete, true);
    });

    test('should detect incomplete profile with "No" values', () {
      bool isIncomplete = ProfileImageUtils.isProfileIncomplete(
        'No country',
        'No user type',
        'No phone number',
      );
      expect(isIncomplete, true);
    });

    test('should detect complete profile', () {
      bool isIncomplete = ProfileImageUtils.isProfileIncomplete(
        'Pakistan',
        'Student',
        '1234567890',
      );
      expect(isIncomplete, false);
    });

    test(
      'should generate appropriate completion message for missing fields',
      () {
        String message = ProfileImageUtils.getProfileCompletionMessage(
          '',
          'Student',
          '1234567890',
        );
        expect(message, contains('Country'));
      },
    );

    test('should generate message for multiple missing fields', () {
      String message = ProfileImageUtils.getProfileCompletionMessage(
        '',
        '',
        '1234567890',
      );
      expect(message, contains('Country'));
      expect(message, contains('User Type'));
    });

    test('should generate initials from name', () {
      String initials = ProfileImageUtils.generateInitials(
        'John Doe',
        'john@example.com',
      );
      expect(initials, 'JD');
    });

    test('should generate initials from single name', () {
      String initials = ProfileImageUtils.generateInitials(
        'John',
        'john@example.com',
      );
      expect(initials, 'JO');
    });

    test('should fallback to email for initials', () {
      String initials = ProfileImageUtils.generateInitials(
        '',
        'john@example.com',
      );
      expect(initials, 'JO');
    });

    test('should use ultimate fallback for initials', () {
      String initials = ProfileImageUtils.generateInitials('', '');
      expect(initials, 'U');
    });
  });
}
