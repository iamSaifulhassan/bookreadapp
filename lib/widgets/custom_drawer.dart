import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Saif'),
                    subtitle: const Text('ABC Dev.'),
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 44, 94, 4),
                      child: Text('S', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/main');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('My Books'),
                    onTap: () {
                      Navigator.pushNamed(context, '/mybooks');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favorites'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/favourites');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text('To Read'),
                    onTap: () {
                      Navigator.pushNamed(context, '/toread');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.download),
                    title: const Text('Downloads'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/downloads');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Rate Us'),
                    onTap: () {
                      Navigator.pushNamed(context, '/rateus');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text('Share'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.feedback),
                    title: const Text('Feedback'),
                    onTap: () {
                      Navigator.pushNamed(context, '/feedback');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.security),
                    title: const Text('Privacy Policy'),
                    onTap: () {
                      Navigator.pushNamed(context, '/privacy-policy');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text('Terms of Service'),
                    onTap: () {
                      Navigator.pushNamed(context, '/terms-of-service');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    onTap: () {
                      Navigator.pushNamed(context, '/language');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notifications'),
                    onTap: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Change Password'),
                    onTap: () {
                      Navigator.pushNamed(context, '/change-password');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bookmark),
                    title: const Text('Bookmarks'),
                    onTap: () {
                      Navigator.pushNamed(context, '/bookmarks');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.cloud_upload),
                    title: const Text('Upload Book'),
                    onTap: () {
                      Navigator.pushNamed(context, '/upload-book');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About'),
                    onTap: () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_page),
                    title: const Text('Contact Us'),
                    onTap: () {
                      Navigator.pushNamed(context, '/contact-us');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signin');
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
}
