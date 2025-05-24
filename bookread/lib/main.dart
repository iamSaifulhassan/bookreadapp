import 'package:bookread/Apptheme.dart';
import 'package:bookread/screens/splash/splash_screen.dart';
import 'package:bookread/screens/home/home_screen.dart';
import 'package:bookread/screens/signin/signin_screen.dart';
import 'package:bookread/screens/signup/signup_screen.dart';
import 'package:bookread/screens/profile/profile_screen.dart';
import 'package:bookread/screens/downloads/downloads_screen.dart';
import 'package:bookread/screens/favourites/favourites_screen.dart';
import 'package:bookread/screens/toread/toread_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bookread/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      home: SplashScreen(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => const SignupScreen(),
        '/profile': (context) => ProfileScreen(),
        '/downloads': (context) => const DownloadsScreen(),
        '/favourites': (context) => const FavouritesScreen(),
        '/toread': (context) => const ToReadScreen(),
      },
    ),
  );
}
