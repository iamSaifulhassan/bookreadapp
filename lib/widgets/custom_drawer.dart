import '../services/app_logger.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';
import '../l10n/generated/app_localizations.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

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
      AppLogger.log('Error loading user data in CustomDrawer: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = <_DrawerEntry>[
      _DrawerEntry(
        icon: Icons.home,
        title: l10n.myBooksTitle,
        onTap: () => Navigator.pushReplacementNamed(context, '/home'),
      ),
      _DrawerEntry(
        icon: Icons.favorite,
        title: l10n.favouritesTitle,
        iconColor: AppColors.error,
        onTap: () => Navigator.pushReplacementNamed(context, '/favourites'),
      ),
      _DrawerEntry(
        icon: Icons.bookmark,
        title: l10n.readLaterTitle,
        iconColor: AppColors.secondary,
        onTap: () => Navigator.pushNamed(context, '/toread'),
      ),
      _DrawerEntry(
        icon: Icons.check_circle,
        title: l10n.completedBooksTitle,
        iconColor: AppColors.success,
        onTap: () => Navigator.pushNamed(context, '/completed'),
      ),
      _DrawerEntry.divider(),
      _DrawerEntry(
        icon: Icons.workspace_premium,
        title: l10n.premiumNav,
        iconColor: AppColors.premiumAccent,
        onTap: () => Navigator.pushNamed(context, '/subscription'),
      ),
      _DrawerEntry.divider(),
      _DrawerEntry(
        icon: Icons.account_circle,
        title: l10n.profileTitle,
        onTap: () => Navigator.pushReplacementNamed(context, '/profile'),
      ),
      _DrawerEntry(
        icon: Icons.settings,
        title: l10n.settingsTitle,
        onTap: () => Navigator.pushNamed(context, '/settings'),
      ),
      _DrawerEntry(
        icon: Icons.info,
        title: l10n.aboutTitle,
        onTap: () => Navigator.pushNamed(context, '/about'),
      ),
      _DrawerEntry.divider(),
      _DrawerEntry(
        icon: Icons.logout,
        title: l10n.logoutNav,
        iconColor: AppColors.error,
        onTap: () async {
          Navigator.pop(context); // Close drawer first
          await _userService.signOut();
        },
      ),
    ];

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
                    AppColors.primary.withValues(alpha: 0.8),
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
                              ? l10n.loadingLabel
                              : _userService.getUserDisplayName() ??
                                  _userService.userEmail?.split('@')[0] ??
                                  l10n.userLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _isLoading
                              ? l10n.pleaseWaitLabel
                              : _userModel?.userType ?? l10n.bookReaderLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.onPrimary.withValues(alpha: 0.8),
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
                  for (int i = 0; i < items.length; i++)
                    TweenAnimationBuilder<double>(
                      key: ValueKey(i),
                      tween: Tween(begin: 0, end: 1),
                      duration: Duration(milliseconds: 200 + i * 35),
                      curve: Curves.easeOutCubic,
                      builder:
                          (context, value, child) => Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset((1 - value) * -16, 0),
                              child: child,
                            ),
                          ),
                      child:
                          items[i].isDivider
                              ? Divider(height: 32, color: AppColors.border)
                              : _buildDrawerItem(
                                context,
                                icon: items[i].icon!,
                                title: items[i].title!,
                                iconColor: items[i].iconColor,
                                onTap: items[i].onTap!,
                              ),
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

/// A drawer row, or a divider when [isDivider] is true (via [_DrawerEntry.divider]).
class _DrawerEntry {
  final IconData? icon;
  final String? title;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isDivider;

  _DrawerEntry({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
  }) : isDivider = false;

  _DrawerEntry.divider()
    : icon = null,
      title = null,
      iconColor = null,
      onTap = null,
      isDivider = true;
}
