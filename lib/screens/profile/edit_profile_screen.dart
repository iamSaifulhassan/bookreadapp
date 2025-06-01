import 'dart:io';
import 'package:flutter/material.dart';
import '../../themes/AppColors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_dropdown.dart';
import '../../services/image_picker_service.dart';
import '../../services/local_image_storage_service.dart';
import '../../services/user_service.dart';
import '../../services/profile_image_utils.dart';
import '../../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentEmail;
  final String currentPhone;
  final String currentCountry;
  final String currentUserType;
  final String? currentProfileImagePath;

  const EditProfileScreen({
    super.key,
    required this.currentEmail,
    required this.currentPhone,
    required this.currentCountry,
    required this.currentUserType,
    this.currentProfileImagePath,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  String _selectedCountry = 'Pakistan';
  String _selectedUserType = 'Student';
  bool _isLoading = false;
  File? _selectedImage;
  String? _currentImagePath;
  bool _isUploadingImage = false;
  final UserService _userService = UserService();

  final List<String> _userTypes = [
    'Student',
    'Teacher',
    'Professional',
    'Researcher',
    'Other',
  ];

  final List<String> _countries = [
    'Pakistan',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'India',
    'Germany',
    'France',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.currentEmail);
    _phoneController = TextEditingController(text: widget.currentPhone);

    // Set selected values from current data
    if (widget.currentCountry.isNotEmpty &&
        widget.currentCountry != 'No country' &&
        _countries.contains(widget.currentCountry)) {
      _selectedCountry = widget.currentCountry;
    }

    if (widget.currentUserType.isNotEmpty &&
        widget.currentUserType != 'No user type' &&
        _userTypes.contains(widget.currentUserType)) {
      _selectedUserType = widget.currentUserType;
    }

    _loadCurrentProfileImage();
  }

  Future<void> _loadCurrentProfileImage() async {
    try {
      // First use the current profile image path passed from profile screen
      if (widget.currentProfileImagePath != null &&
          widget.currentProfileImagePath!.isNotEmpty) {
        setState(() {
          _currentImagePath = widget.currentProfileImagePath;
        });
        return;
      }

      // Fallback to loading from local storage if no path was passed
      final String? imagePath =
          await LocalImageStorageService.getProfileImagePath();
      if (mounted && imagePath != null) {
        setState(() {
          _currentImagePath = imagePath;
        });
      }
    } catch (e) {
      print('Error loading current profile image: $e');
    }
  }

  Future<void> _pickAndSaveImage() async {
    try {
      final File? pickedImage = await ImagePickerService.pickProfileImage(
        context,
      );
      if (pickedImage != null) {
        setState(() {
          _selectedImage = pickedImage;
          _isUploadingImage = true;
        });

        // Save to local storage
        print('EditProfile: Starting save to local storage...');
        final String? savedImagePath =
            await LocalImageStorageService.saveProfileImage(pickedImage);
        print('EditProfile: Save completed. Result: $savedImagePath');

        if (mounted) {
          setState(() {
            _isUploadingImage = false;
            if (savedImagePath != null && savedImagePath.isNotEmpty) {
              print('EditProfile: Save successful, path: $savedImagePath');
              _currentImagePath = savedImagePath;
              _selectedImage = null; // Clear local file to show saved image
              print(
                'EditProfile: Cleared _selectedImage, now showing saved image',
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Profile image saved successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            } else {
              print('EditProfile: Save failed or returned null/empty path');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Failed to save image. Please try again.',
                  ),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isUploadingImage = false;
        });
        print('Error picking and saving image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to pick image. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedUser = UserModel(
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        country: _selectedCountry,
        userType: _selectedUserType,
        profileImageUrl: _currentImagePath, // Use local path for now
      );

      final success = await _userService.updateUserProfile(updatedUser);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Profile updated successfully!'),
              backgroundColor: AppColors.success,
            ),
          ); // Return the updated profile data to the profile screen
          Navigator.of(context).pop({
            'email': _emailController.text.trim(),
            'phone': _phoneController.text.trim(),
            'country': _selectedCountry,
            'userType': _selectedUserType,
            'profileImageUrl': _currentImagePath ?? '',
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Failed to update profile. Please try again.',
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildProfileImageSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: _isUploadingImage ? null : _pickAndSaveImage,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 3),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: _buildImageWidget(),
                ),
                if (_isUploadingImage)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Tap to change profile picture',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildImageWidget() {
    // Show selected image first (while uploading)
    if (_selectedImage != null) {
      return Image.file(
        _selectedImage!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    }

    // Show current saved image
    if (_currentImagePath != null && _currentImagePath!.isNotEmpty) {
      final imageFile = File(_currentImagePath!);
      return Image.file(
        imageFile,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading saved image: $error');
          return _buildDefaultAvatar();
        },
      );
    }

    // Show default avatar
    return _buildDefaultAvatar();
  }

  Widget _buildDefaultAvatar() {
    return ProfileImageUtils.createProfileAvatar(
      imageUrl: null,
      name: null,
      email: _emailController.text,
      radius: 60,
    );
  }

  // Helper method to convert List<String> to List<DropdownMenuItem<String>>
  List<DropdownMenuItem<String>> _buildDropdownItems(List<String> items) {
    return items.map((String value) {
      return DropdownMenuItem<String>(value: value, child: Text(value));
    }).toList();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _buildProfileImageSection()),
              const SizedBox(height: 32),

              Text(
                'Email Address',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter your email address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              Text(
                'Phone Number',
                style: TextStyle(
                  color: const Color.fromARGB(255, 95, 91, 91),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _phoneController,
                label: 'Phone',
                hint: 'Enter your phone number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              Text(
                'Country',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              CustomDropdown<String>(
                label: 'Country',
                value: _selectedCountry,
                items: _buildDropdownItems(_countries),
                hint: 'Select your country',
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountry = newValue ?? 'Pakistan';
                  });
                },
              ),
              const SizedBox(height: 20),

              Text(
                'User Type',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              CustomDropdown<String>(
                label: 'User Type',
                value: _selectedUserType,
                items: _buildDropdownItems(_userTypes),
                hint: 'Select user type',
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUserType = newValue ?? 'Student';
                  });
                },
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: _isLoading ? null : _updateProfile,
                  isLoading: _isLoading,
                  child: Text(_isLoading ? 'Updating...' : 'Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
