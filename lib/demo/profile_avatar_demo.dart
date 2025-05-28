import 'package:flutter/material.dart';
import '../services/profile_image_utils.dart';

/// Demo widget to showcase ProfileImageUtils functionality
class ProfileAvatarDemo extends StatelessWidget {
  const ProfileAvatarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Avatar Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Demo with network image
            ProfileImageUtils.createProfileAvatar(
              imageUrl: 'https://example.com/profile.jpg',
              name: 'John Doe',
              email: 'john.doe@example.com',
              radius: 50,
            ),
            const SizedBox(height: 20),

            // Demo with initials only
            ProfileImageUtils.createProfileAvatar(
              imageUrl: null,
              name: 'Sarah Wilson',
              email: 'sarah.wilson@example.com',
              radius: 50,
            ),
            const SizedBox(height: 20),

            // Demo with email only
            ProfileImageUtils.createProfileAvatar(
              imageUrl: null,
              name: null,
              email: 'mike.jones@example.com',
              radius: 50,
            ),
            const SizedBox(height: 20),

            // Demo with app icon fallback
            ProfileImageUtils.createProfileAvatar(
              imageUrl: null,
              name: null,
              email: 'test@example.com',
              radius: 50,
              useAppIconFallback: true,
            ),
            const SizedBox(height: 20),

            // Profile completion examples
            Text(
              'Profile Completion Examples:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),

            // Complete profile
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Complete Profile: ${ProfileImageUtils.isProfileIncomplete('Pakistan', 'Student', '+1234567890') ? 'Incomplete' : 'Complete'}',
              ),
            ),
            const SizedBox(height: 10),

            // Incomplete profile
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Incomplete Profile: ${ProfileImageUtils.getProfileCompletionMessage('', 'No user type', 'No phone number')}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
