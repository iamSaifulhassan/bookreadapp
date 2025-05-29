import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  // Settings Keys - Simplified to only essential settings
  static const String _ttsSpeechRateKey = 'tts_speech_rate';
  static const String _ttsPitchKey = 'tts_pitch';
  static const String _ttsVolumeKey = 'tts_volume';

  static const String _readingFontSizeKey = 'reading_font_size';
  static const String _readingLineHeightKey = 'reading_line_height';

  // TTS Settings
  Future<double> getTTSSpeechRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_ttsSpeechRateKey) ?? 0.5;
  }

  Future<void> setTTSSpeechRate(double rate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_ttsSpeechRateKey, rate);
  }

  Future<double> getTTSPitch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_ttsPitchKey) ?? 1.0;
  }

  Future<void> setTTSPitch(double pitch) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_ttsPitchKey, pitch);
  }

  Future<double> getTTSVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_ttsVolumeKey) ?? 0.8;
  }

  Future<void> setTTSVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_ttsVolumeKey, volume);
  }

  // Reading Settings
  Future<double> getReadingFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_readingFontSizeKey) ?? 16.0;
  }

  Future<void> setReadingFontSize(double fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_readingFontSizeKey, fontSize);
  }

  Future<double> getReadingLineHeight() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_readingLineHeightKey) ?? 1.5;
  }

  Future<void> setReadingLineHeight(double lineHeight) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_readingLineHeightKey, lineHeight);
  }

  // Utility methods
  Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();

    // Reset TTS settings
    await prefs.remove(_ttsSpeechRateKey);
    await prefs.remove(_ttsPitchKey);
    await prefs.remove(_ttsVolumeKey);

    // Reset reading settings
    await prefs.remove(_readingFontSizeKey);
    await prefs.remove(_readingLineHeightKey);
  }

  Future<Map<String, dynamic>> exportSettings() async {
    return {
      'tts': {
        'speechRate': await getTTSSpeechRate(),
        'pitch': await getTTSPitch(),
        'volume': await getTTSVolume(),
      },
      'reading': {
        'fontSize': await getReadingFontSize(),
        'lineHeight': await getReadingLineHeight(),
      },
    };
  }
}
