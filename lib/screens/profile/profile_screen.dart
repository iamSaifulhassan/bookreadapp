import '../../services/app_logger.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_drawer.dart';
import '../../services/local_image_storage_service.dart';
import '../../services/user_service.dart';
import '../../services/profile_image_utils.dart';
import '../../models/user_model.dart';
import 'edit_profile_screen.dart';
import '../../l10n/generated/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _countryController;
  late final TextEditingController _userTypeController;
  String? _profileImageUrl;
  bool _isLoading = true;
  bool _isProfileIncomplete = false;
  String _completionMessage = '';
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _countryController = TextEditingController();
    _userTypeController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Check if user is still authenticated before loading data
    if (!_userService.isAuthenticated) {
      AppLogger.log('ProfileScreen: User not authenticated, skipping data load');
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      }); // Load user profile data from Firebase
      final UserModel? userModel = await _userService.getCurrentUserProfile();

      // Load profile image from local storage
      final String? imagePath =
          await LocalImageStorageService.getProfileImagePath();
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        setState(() {
          if (userModel != null) {
            _emailController.text = userModel.email;
            _phoneController.text =
                userModel.phone.isEmpty ? l10n.noPhoneNumber : userModel.phone;
            _countryController.text =
                userModel.country.isEmpty ? l10n.noCountry : userModel.country;
            _userTypeController.text =
                userModel.userType.isEmpty
                    ? l10n.noUserType
                    : userModel.userType;
            _profileImageUrl = userModel.profileImageUrl ?? imagePath;

            AppLogger.log('ProfileScreen: Loaded profile data:');
            AppLogger.log('  - Email: ${userModel.email}');
            AppLogger.log('  - Phone: ${userModel.phone}');
            AppLogger.log('  - Country: ${userModel.country}');
            AppLogger.log('  - UserType: ${userModel.userType}');
            AppLogger.log(
              '  - UserModel.profileImageUrl: ${userModel.profileImageUrl}',
            );
            AppLogger.log('  - Storage imagePath: $imagePath');
            AppLogger.log('  - Final _profileImageUrl: $_profileImageUrl');

            // Check profile completion
            _isProfileIncomplete = ProfileImageUtils.isProfileIncomplete(
              userModel.country,
              userModel.userType,
              userModel.phone,
            );
            _completionMessage = ProfileImageUtils.getProfileCompletionMessage(
              userModel.country,
              userModel.userType,
              userModel.phone,
            );
          } else {
            // Fallback to auth user email if no profile data exists
            _emailController.text = _userService.userEmail ?? l10n.noEmail;
            _phoneController.text = l10n.noPhoneNumber;
            _countryController.text = l10n.noCountry;
            _userTypeController.text = l10n.noUserType;
            _profileImageUrl = imagePath;
            _isProfileIncomplete = true;
            _completionMessage = l10n.profileIncompleteMessage;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      AppLogger.log('Error loading user data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.failedToLoadProfileError(
                e.toString(),
              ),
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _userTypeController.dispose();
    super.dispose();
  }

  void _updateProfileData(Map<String, String> data) async {
    try {
      AppLogger.log('ProfileScreen: Received data: $data');

      setState(() {
        _emailController.text = data['email']?.trim() ?? _emailController.text;
        _phoneController.text = data['phone']?.trim() ?? _phoneController.text;
        _countryController.text =
            data['country']?.trim() ?? _countryController.text;
        _userTypeController.text =
            data['userType']?.trim() ?? _userTypeController.text;

        // Handle profileImageUrl properly - always update it from returned data
        final imagePath = data['profileImageUrl'];
        AppLogger.log('ProfileScreen: Updating profile image path:');
        AppLogger.log('  - Current _profileImageUrl: $_profileImageUrl');
        AppLogger.log('  - Returned imagePath: $imagePath');
        if (imagePath != null) {
          _profileImageUrl = imagePath.isEmpty ? null : imagePath;
          AppLogger.log('  - Updated _profileImageUrl: $_profileImageUrl');
        }

        // Update profile completion status
        _isProfileIncomplete = ProfileImageUtils.isProfileIncomplete(
          data['country'],
          data['userType'],
          data['phone'],
        );
        _completionMessage = ProfileImageUtils.getProfileCompletionMessage(
          data['country'],
          data['userType'],
          data['phone'],
        );
      });

      // Save updated data to Firebase
      try {
        final UserModel updatedUser = UserModel(
          email: _emailController.text,
          phone: _phoneController.text,
          country: _countryController.text,
          userType: _userTypeController.text,
          profileImageUrl: _profileImageUrl,
        );

        await _userService.updateUserProfile(updatedUser);
        AppLogger.log('ProfileScreen: Profile data saved successfully');
      } catch (e) {
        AppLogger.log('Error saving updated profile data: $e');
      }
    } catch (e) {
      AppLogger.log('ProfileScreen: Error updating profile data: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.errorUpdatingProfileError(
              e.toString(),
            ),
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Widget _buildProfileAvatar() {
    // If we have a local file path, show local image
    if (_profileImageUrl != null &&
        _profileImageUrl!.isNotEmpty &&
        !_profileImageUrl!.startsWith('http')) {
      final imageFile = File(_profileImageUrl!);
      return CircleAvatar(
        radius: 48,
        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
        child: ClipOval(
          child: Image.file(
            imageFile,
            width: 96,
            height: 96,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              AppLogger.log('Error loading local profile image: $error');
              return _buildFallbackAvatar();
            },
          ),
        ),
      );
    }

    // Use ProfileImageUtils for network URLs or fallback
    return ProfileImageUtils.createProfileAvatar(
      imageUrl:
          _profileImageUrl?.startsWith('http') == true
              ? _profileImageUrl
              : null,
      name: _userService.getUserDisplayName(),
      email: _emailController.text,
      radius: 48,
    );
  }

  Widget _buildFallbackAvatar() {
    return ProfileImageUtils.createProfileAvatar(
      imageUrl: null,
      name: _userService.getUserDisplayName(),
      email: _emailController.text,
      radius: 48,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _userService.isAuthenticated ? _loadUserData : null,
            tooltip: l10n.refreshProfileTooltip,
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        child:
            _isLoading
                ? Center(
                  key: const ValueKey('loading'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.loadingProfile,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
                : Center(
                  key: const ValueKey('loaded'),
                  child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Card(
                    color: AppColors.surface,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Profile completion warning
                          if (_isProfileIncomplete)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.warning.shade100,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.warning.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: AppColors.warning.shade700,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _completionMessage,
                                      style: TextStyle(
                                        color: AppColors.warning.shade800,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Center(child: _buildProfileAvatar()),
                          const SizedBox(height: 24),
                          CustomTextField(
                            controller: _emailController,
                            label: l10n.emailLabel,
                            hint: l10n.emailHint,
                            icon: Icons.email,
                            validator: (_) => null,
                            keyboardType: TextInputType.emailAddress,
                            readOnly: true,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _phoneController,
                            label: l10n.phoneFieldLabel,
                            hint: l10n.phoneFieldHint,
                            icon: Icons.phone,
                            validator: (_) => null,
                            keyboardType: TextInputType.phone,
                            readOnly: true,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _countryController,
                            label: l10n.countryLabel,
                            hint: l10n.countryFieldHint,
                            icon: Icons.flag,
                            validator: (_) => null,
                            readOnly: true,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _userTypeController,
                            label: l10n.userTypeFieldLabel,
                            hint: l10n.userTypeFieldHint,
                            icon: Icons.person_outline,
                            validator: (_) => null,
                            readOnly: true,
                          ),
                          const SizedBox(height: 32),
                          CustomButton(
                            onPressed: () async {
                              if (!mounted) return;
                              final result =
                                  await Navigator.push<Map<String, String>>(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => EditProfileScreen(
                                            currentEmail: _emailController.text,
                                            currentPhone: _phoneController.text,
                                            currentCountry:
                                                _countryController.text,
                                            currentUserType:
                                                _userTypeController.text,
                                            currentProfileImagePath:
                                                _profileImageUrl,
                                          ),
                                    ),
                                  );

                              if (mounted && result != null) {
                                _updateProfileData(result);
                              }
                            },
                            child: Text(l10n.editProfileButton),
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      backgroundColor: AppColors.surface,
                                      title: Text(
                                        l10n.signOutButton,
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      content: Text(
                                        l10n.signOutConfirmMessage,
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            if (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text(
                                            l10n.commonCancel,
                                            style: TextStyle(
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            // Close dialog first
                                            if (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }

                                            // Sign out using UserService
                                            await _userService.signOut();

                                            // Navigate to login screen and clear navigation stack
                                            if (context.mounted) {
                                              Navigator.of(
                                                context,
                                              ).pushReplacementNamed('/');
                                            }
                                          },
                                          child: Text(
                                            l10n.signOutButton,
                                            style: TextStyle(
                                              color: AppColors.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            child: Text(l10n.signOutButton),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

// Guidance:
// - Profile Screen now displays Firebase Storage profile images
// - Automatically loads profile image on screen initialization
// - Updates profile data including image URL when returning from edit screen
// - Uses AppColors consistently throughout
// - Integrates with CustomDrawer for navigation
// 
// SETUP REQUIRED:
// 1. Run: flutter pub get (to install firebase_storage)
// 2. Ensure Firebase Storage is configured in your Firebase project
// 
// TODO: Replace hardcoded controllers with BLoC/user state
// TODO: Use BLoC for edit and sign out actions
// TODO: Add offline caching for profile images
// TODO: Keep UI consistent with other screens using reusable widgets
// TODO: Remove TODOs as you implement logic
