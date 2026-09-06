// -----------------------------------------------------------------------------
// Main entry point for TheBookRead app
// - Follows BLoC architecture, modular folder structure, and reusable widgets
// - All UI, navigation, and business logic are organized in lib/screens/, lib/widgets/, lib/blocs/, etc.
// - App theme and colors are defined in AppTheme and AppColors
// -----------------------------------------------------------------------------

import 'package:bookread/screens/about/about_screen.dart';
import 'package:bookread/services/auth_wrapper.dart';
import 'package:bookread/services/locale_service.dart';
import 'package:bookread/services/theme_service.dart';
import 'package:bookread/services/subscription_service.dart';
import 'package:bookread/screens/subscription/subscription_screen.dart';
import 'package:bookread/screens/home/home_screen.dart';
import 'package:bookread/screens/signin/signin_screen.dart';
import 'package:bookread/screens/signup/signup_screen.dart';
import 'package:bookread/screens/profile/profile_screen.dart';
import 'package:bookread/screens/downloads/downloads_screen.dart';
import 'package:bookread/screens/book_list/book_list_screen.dart';
import 'package:bookread/repositories/book_list_repository.dart';
import 'package:bookread/screens/settings/settings_screen.dart';
import 'package:bookread/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_options.dart';
import 'l10n/generated/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocaleService().loadSavedLocale();
  await ThemeService().loadSavedThemeMode();
  await SubscriptionService().initialize();
  runApp(const BookReadApp());
}

class BookReadApp extends StatelessWidget {
  const BookReadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: LocaleService().currentLocale,
      builder: (context, locale, _) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeService().themeMode,
          builder: (context, themeMode, _) {
            // Urdu is conventionally set in Nastaliq, which a generic Naskh
            // font renders illegibly — apply Google's open-source Noto
            // Nastaliq Urdu across the whole app's UI chrome (not just book
            // content) whenever Urdu is the selected app language.
            final isUrdu = locale?.languageCode == 'ur';
            final lightTheme =
                isUrdu
                    ? AppTheme.lightTheme.copyWith(
                      textTheme: GoogleFonts.notoNastaliqUrduTextTheme(
                        AppTheme.lightTheme.textTheme,
                      ),
                      primaryTextTheme: GoogleFonts.notoNastaliqUrduTextTheme(
                        AppTheme.lightTheme.primaryTextTheme,
                      ),
                    )
                    : AppTheme.lightTheme;
            final darkTheme =
                isUrdu
                    ? AppTheme.darkTheme.copyWith(
                      textTheme: GoogleFonts.notoNastaliqUrduTextTheme(
                        AppTheme.darkTheme.textTheme,
                      ),
                      primaryTextTheme: GoogleFonts.notoNastaliqUrduTextTheme(
                        AppTheme.darkTheme.primaryTextTheme,
                      ),
                    )
                    : AppTheme.darkTheme;
            return MaterialApp(
              home:
                  const AuthWrapper(), // Use AuthWrapper instead of SplashScreen
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              locale: locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: kSupportedLocales.map((l) => l.locale).toList(),
              routes: {
                '/home': (context) => const HomeScreen(),
                '/signin': (context) => SignInScreen(),
                '/signup': (context) => const SignupScreen(),
                '/profile': (context) => ProfileScreen(),
                '/downloads': (context) => const DownloadsScreen(),
                '/favourites':
                    (context) =>
                        const BookListScreen(type: BookListType.favourites),
                '/toread':
                    (context) =>
                        const BookListScreen(type: BookListType.readLater),
                '/completed':
                    (context) =>
                        const BookListScreen(type: BookListType.completed),
                '/settings': (context) => const SettingsScreen(),
                '/about': (context) => const AboutScreen(),
                '/subscription': (context) => const SubscriptionScreen(),
                // Add other routes here as needed for new features/screens
              },
            );
          },
        );
      },
    );
  }
}
