import 'dart:async';
import 'package:flutter/material.dart';
import '../home/home_screen.dart'; // Import HomeScreen instead of PermissionGate

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/App_splash.png',
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            Text('Welcome to BookRead', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

// Guidance:
// - Add navigation logic to main/home after splash.
// - Use BLoC for splash state if needed.
// - Remove TODOs as you implement logic.
