import 'package:bookread/AppColors.dart';
import 'package:bookread/Apptheme.dart';
import 'package:bookread/Favourites.dart';
import 'package:bookread/Profile.dart';
import 'package:bookread/downloads.dart';
import 'package:bookread/signin.dart';
import 'package:bookread/signup.dart';
import 'package:bookread/toread.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Signin(), // Set the FavouritesScreen as the home screen
      theme: AppTheme.lightTheme, // Use the light theme from AppTheme
      debugShowCheckedModeBanner: false,
      routes: {
        '/signin': (context) => Signin(),
        '/signup': (context) => Signup(),
        '/favourites': (context) => FavouritesScreen(),
        '/downloads': (context) => DownloadsScreen(),
        '/toread': (context) => ToReadScreen(),
        '/main': (context) => MyApp(),
        '/profile': (context) => Profile(),
      },
    ),
  );
}

List<String> name = [
  "Hundred Loops of War",
  "The Art of War",
  "The Kite Runner",
  "Pakistan: A hard Country",
  "The Prince BY Niccolo Machiavelli",
  "The Book Thief",
  "The Alchemist",
  "The Great Gatsby",
  "The Catcher in the Rye",
  "To Kill a Mockingbird",
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/App.png', height: 50),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: name.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/default_book.png',
                              ), // Use a valid asset or network image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
                      // Example: Open a dialog or navigate to a Rate Us screen
                      Navigator.pushNamed(context, '/rateus');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text('Share'),
                    onTap: () {
                      // You might open a share dialog here instead of navigation
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
