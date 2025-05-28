import 'package:flutter/material.dart';
import '../AppColors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundLight,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // User Profile Header
                  Container(
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
                        CircleAvatar(
                          backgroundColor: AppColors.onPrimary,
                          radius: 30,
                          child: Text(
                            'S',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saif',
                                style: TextStyle(
                                  color: AppColors.onPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Book Reader',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    icon: Icons.share,
                    title: 'Share App',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Implement share functionality
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.star,
                    title: 'Rate Us',
                    onTap: () => Navigator.pushNamed(context, '/rateus'),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.info,
                    title: 'About',
                    onTap: () => Navigator.pushNamed(context, '/about'),
                  ),

                  Divider(height: 32, color: AppColors.border),
                  // Logout
                  _buildDrawerItem(
                    context,
                    icon: Icons.logout,
                    title: 'Logout',
                    iconColor: AppColors.error,
                    onTap:
                        () =>
                            Navigator.pushReplacementNamed(context, '/signin'),
                  ),
                ],
              ),
            ),
          ),
        ],
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
