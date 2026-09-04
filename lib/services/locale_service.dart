import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The 12 locales the app ships UI translations for.
/// Arabic and Urdu are RTL; Flutter derives text direction from these
/// automatically once they're registered as supportedLocales.
class SupportedLocale {
  final Locale locale;
  final String nativeName;

  const SupportedLocale(this.locale, this.nativeName);
}

const List<SupportedLocale> kSupportedLocales = [
  SupportedLocale(Locale('en'), 'English'),
  SupportedLocale(Locale('es'), 'Español'),
  SupportedLocale(Locale('fr'), 'Français'),
  SupportedLocale(Locale('de'), 'Deutsch'),
  SupportedLocale(Locale('pt'), 'Português'),
  SupportedLocale(Locale('it'), 'Italiano'),
  SupportedLocale(Locale('ar'), 'العربية'),
  SupportedLocale(Locale('hi'), 'हिन्दी'),
  SupportedLocale(Locale('ur'), 'اردو'),
  SupportedLocale(Locale('zh'), '简体中文'),
  SupportedLocale(Locale('ja'), '日本語'),
  SupportedLocale(Locale('ru'), 'Русский'),
];

/// Persists the user's chosen app language and notifies listeners
/// (main.dart's MaterialApp) so the change applies immediately.
class LocaleService {
  static final LocaleService _instance = LocaleService._internal();
  factory LocaleService() => _instance;
  LocaleService._internal();

  static const String _localeKey = 'app_locale';

  /// Null means "follow system locale".
  final ValueNotifier<Locale?> currentLocale = ValueNotifier<Locale?>(null);

  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);
    if (code != null) {
      currentLocale.value = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
    currentLocale.value = locale;
  }
}
