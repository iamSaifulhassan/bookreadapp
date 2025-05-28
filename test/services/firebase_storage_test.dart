import 'package:flutter_test/flutter_test.dart';
import 'package:bookread/services/firebase_storage_service.dart';
import 'package:bookread/services/image_picker_service.dart';

void main() {
  group('Firebase Storage Service Tests', () {
    test('Firebase Storage Service can be instantiated', () {
      final firebaseStorageService = FirebaseStorageService();
      expect(firebaseStorageService, isNotNull);
    });

    test('Image Picker Service can be instantiated', () {
      final imagePickerService = ImagePickerService();
      expect(imagePickerService, isNotNull);
    });
  });
}
