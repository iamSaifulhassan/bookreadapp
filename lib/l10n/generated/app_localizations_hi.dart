// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get resetToDefaultsTooltip => 'डिफ़ॉल्ट पर रीसेट करें';

  @override
  String get settingsResetSuccess => 'सेटिंग्स डिफ़ॉल्ट पर रीसेट कर दी गई हैं';

  @override
  String settingsResetError(String error) {
    return 'सेटिंग्स रीसेट करने में त्रुटि: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'सेटिंग्स लोड करने में त्रुटि: $error';
  }

  @override
  String get textToSpeechSection => 'टेक्स्ट-टू-स्पीच';

  @override
  String get speechRateLabel => 'बोलने की गति';

  @override
  String get speechRateSubtitle => 'टेक्स्ट कितनी तेज़ी से बोला जाता है';

  @override
  String get pitchLabel => 'पिच';

  @override
  String get pitchSubtitle => 'आवाज़ की पिच का स्तर';

  @override
  String get volumeLabel => 'वॉल्यूम';

  @override
  String get volumeSubtitle => 'प्लेबैक वॉल्यूम';

  @override
  String get readingExperienceSection => 'पठन अनुभव';

  @override
  String get fontSizeLabel => 'फ़ॉन्ट आकार';

  @override
  String get fontSizeSubtitle => 'पढ़ने के लिए टेक्स्ट का आकार';

  @override
  String get lineHeightLabel => 'लाइन की ऊँचाई';

  @override
  String get lineHeightSubtitle => 'टेक्स्ट की पंक्तियों के बीच की दूरी';

  @override
  String get languageSection => 'भाषा';

  @override
  String get languageSubtitle => 'अपनी पसंदीदा भाषा चुनें';
}
