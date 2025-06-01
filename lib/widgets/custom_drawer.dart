import 'dart:io';
import 'package:flutter/material.dart';
import '../themes/AppColors.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final UserService _userService = UserService();
  UserModel? _userModel;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userModel = await _userService.getCurrentUserProfile();
      if (mounted) {
        setState(() {
          _userModel = userModel;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data in CustomDrawer: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundLight,
      child: Column(
        children: [
          // SafeArea for the header
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                ),
              ),
              child: Row(
                children: [
                  _buildProfileAvatar(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isLoading
                              ? 'Loading...'
                              : _userService.getUserDisplayName() ??
                                  _userService.userEmail?.split('@')[0] ??
                                  'User',
                          style: TextStyle(
                            color: AppColors.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _isLoading
                              ? 'Please wait...'
                              : _userModel?.userType ?? 'Book Reader',
                          style: TextStyle(
                            color: AppColors.onPrimary.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Main Navigation
                  _buildDrawerItem(
                    context,
                    icon: Icons.home,
                    title: 'My Books',
                    onTap:
                        () => Navigator.pushReplacementNamed(context, '/home'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.favorite,
                    title: 'Favourites',
                    iconColor: AppColors.error,
                    onTap:
                        () => Navigator.pushReplacementNamed(
                          context,
                          '/favourites',
                        ),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.bookmark,
                    title: 'Read Later',
                    iconColor: AppColors.secondary,
                    onTap: () => Navigator.pushNamed(context, '/toread'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.check_circle,
                    title: 'Completed',
                    iconColor: AppColors.success,
                    onTap: () => Navigator.pushNamed(context, '/completed'),
                  ),

                  Divider(height: 32, color: AppColors.border),

                  // Secondary Navigation
                  _buildDrawerItem(
                    context,
                    icon: Icons.account_circle,
                    title: 'Profile',
                    onTap:
                        () =>
                            Navigator.pushReplacementNamed(context, '/profile'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.info,
                    title: 'About',
                    onTap: () => Navigator.pushNamed(context, '/about'),
                  ),
                  Divider(height: 32, color: AppColors.border), // Logout
                  _buildDrawerItem(
                    context,
                    icon: Icons.logout,
                    title: 'Logout',
                    iconColor: AppColors.error,
                    onTap: () async {
                      Navigator.pop(context); // Close drawer first
                      await _userService.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    if (_isLoading) {
      return CircleAvatar(
        backgroundColor: AppColors.onPrimary,
        radius: 30,
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2,
        ),
      );
    }

    // Try to get user initials
    final String initials = _userService.getUserInitials();

    // If user has a profile image path, try to load it
    if (_userModel?.profileImageUrl != null &&
        _userModel!.profileImageUrl!.isNotEmpty) {
      return CircleAvatar(
        backgroundColor: AppColors.primary,
        radius: 30,
        child: ClipOval(
          child: Image.file(
            File(_userModel!.profileImageUrl!),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If image loading fails, show initials
              return Text(
                initials,
                style: TextStyle(
                  color: AppColors.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      );
    }

    // Default: show initials
    return CircleAvatar(
      backgroundColor: AppColors.primary,
      radius: 30,
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.primary),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
