// -----------------------------------------------------------------------------
// Main entry point for TheBookRead app
// - Follows BLoC architecture, modular folder structure, and reusable widgets
// - All UI, navigation, and business logic are organized in lib/screens/, lib/widgets/, lib/blocs/, etc.
// - App theme and colors are defined in AppTheme and AppColors
// -----------------------------------------------------------------------------

import 'package:bookread/Apptheme.dart';
import 'package:bookread/services/auth_wrapper.dart';
import 'package:bookread/screens/home/home_screen.dart';
import 'package:bookread/screens/signin/signin_screen.dart';
import 'package:bookread/screens/signup/signup_screen.dart';
import 'package:bookread/screens/profile/profile_screen.dart';
import 'package:bookread/screens/downloads/downloads_screen.dart';
import 'package:bookread/screens/favourites/favourites_screen.dart';
import 'package:bookread/screens/toread/toread_screen.dart';
import 'package:bookread/screens/completed/completed_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      home: const AuthWrapper(), // Use AuthWrapper instead of SplashScreen
      theme: AppTheme.lightTheme, // Uses app-wide theme and color scheme
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => const SignupScreen(),
        '/profile': (context) => ProfileScreen(),
        '/downloads': (context) => const DownloadsScreen(),
        '/favourites': (context) => const FavouritesScreen(),
        '/toread': (context) => const ToReadScreen(),
        '/completed': (context) => const CompletedScreen(),
        // Add other routes here as needed for new features/screens
      },
    ),
  );
}
