import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        drawer: Drawer(
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
                          child: Text(
                            'S',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('Home'),
                        onTap: () {
                          // Navigate to Home Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.book),
                        title: const Text('My Books'),
                        onTap: () {
                          // Navigate to My Books Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.favorite),
                        title: const Text('Favorites'),
                        onTap: () {
                          // Navigate to Favorites Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.history),
                        title: const Text('History'),
                        onTap: () {
                          // Navigate to History Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.download),
                        title: const Text('Downloads'),
                        onTap: () {
                          // Navigate to Downloads Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.star),
                        title: const Text('Rate Us'),
                        onTap: () {
                          // Navigate to Rate Us Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Share'),
                        onTap: () {
                          // Navigate to Share Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.feedback),
                        title: const Text('Feedback'),
                        onTap: () {
                          // Navigate to Feedback Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.security),
                        title: const Text('Privacy Policy'),
                        onTap: () {
                          // Navigate to Privacy Policy Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip),
                        title: const Text('Terms of Service'),
                        onTap: () {
                          // Navigate to Terms of Service Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: const Text('Language'),
                        onTap: () {
                          // Navigate to Language Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('Notifications'),
                        onTap: () {
                          // Navigate to Notifications Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: const Text('Profile'),
                        onTap: () {
                          // Navigate to Profile Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.lock),
                        title: const Text('Change Password'),
                        onTap: () {
                          // Navigate to Change Password Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.bookmark),
                        title: const Text('Bookmarks'),
                        onTap: () {
                          // Navigate to Bookmarks Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.cloud_upload),
                        title: const Text('Upload Book'),
                        onTap: () {
                          // Navigate to Upload Book Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {
                          // Navigate to Settings Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.info),
                        title: const Text('About'),
                        onTap: () {
                          // Navigate to About Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.contact_page),
                        title: const Text('Contact Us'),
                        onTap: () {
                          // Navigate to Contact Us Page
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        onTap: () {
                          // Handle Logout
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'R.',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.blue,
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
                                image: NetworkImage(''),
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
      ),
    );
  }
}
