import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 80, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: const Text(
                'Saif UL Hassan',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: const Text(
                'Flutter Developer',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'About',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              'A Flutter developer with a passion for creating beautiful and functional applications. This app is built using Flutter and Firebase with Local Data Storage, showcasing skills in mobile development.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            const Text(
              'Connect with me',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildContactCard(
              icon: Icons.code,
              title: 'GitHub',
              subtitle: 'github.com/iamSaifulhassan',
              color: Colors.black,
              onTap: () async {
                final url = Uri.parse('https://github.com/iamSaifulhassan');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
            const SizedBox(height: 10),
            _buildContactCard(
              icon: Icons.work,
              title: 'LinkedIn',
              subtitle: 'linkedin.com/in/saif-ul-hassan-03aa80287/',
              color: Colors.blue,
              onTap: () async {
                final url = Uri.parse(
                  'https://linkedin.com/in/imSaifulhassan/',
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
            const SizedBox(height: 10),
            _buildContactCard(
              icon: Icons.military_tech,
              title: 'CodeWars',
              subtitle: 'codewars.com/users/Saifulhassan2004',
              color: Colors.red,
              onTap: () async {
                final url = Uri.parse(
                  'https://www.codewars.com/users/Saifulhassan2004',
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.open_in_new),
        onTap: onTap,
      ),
    );
  }
}
