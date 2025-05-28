import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../AppColors.dart';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  /// Show image picker dialog and return selected image file
  static Future<File?> pickProfileImage(BuildContext context) async {
    return await showModalBottomSheet<File?>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Profile Picture',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Camera Option
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.primary),
                title: Text(
                  'Take Photo',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                onTap: () async {
                  try {
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );
                    if (context.mounted) {
                      Navigator.of(
                        context,
                      ).pop(image != null ? File(image.path) : null);
                    }
                  } catch (e) {
                    print('Error picking image from camera: $e');
                    if (context.mounted) {
                      Navigator.of(context).pop(null);
                    }
                  }
                },
              ),

              // Gallery Option
              ListTile(
                leading: Icon(Icons.photo_library, color: AppColors.primary),
                title: Text(
                  'Choose from Gallery',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                onTap: () async {
                  try {
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );
                    if (context.mounted) {
                      Navigator.of(
                        context,
                      ).pop(image != null ? File(image.path) : null);
                    }
                  } catch (e) {
                    print('Error picking image from gallery: $e');
                    if (context.mounted) {
                      Navigator.of(context).pop(null);
                    }
                  }
                },
              ),

              const SizedBox(height: 10),

              // Cancel Button
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Pick image from camera
  static Future<File?> pickFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error picking image from camera: $e');
      return null;
    }
  }

  /// Pick image from gallery
  static Future<File?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error picking image from gallery: $e');
      return null;
    }
  }
}
