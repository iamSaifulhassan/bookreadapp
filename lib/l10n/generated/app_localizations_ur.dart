// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get resetToDefaultsTooltip => 'ڈیفالٹ پر ری سیٹ کریں';

  @override
  String get settingsResetSuccess => 'ترتیبات ڈیفالٹ پر ری سیٹ کر دی گئیں';

  @override
  String settingsResetError(String error) {
    return 'ترتیبات ری سیٹ کرنے میں خرابی: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'ترتیبات لوڈ کرنے میں خرابی: $error';
  }

  @override
  String get textToSpeechSection => 'متن سے تقریر';

  @override
  String get speechRateLabel => 'بولنے کی رفتار';

  @override
  String get speechRateSubtitle => 'متن کتنی تیزی سے پڑھا جاتا ہے';

  @override
  String get pitchLabel => 'پچ';

  @override
  String get pitchSubtitle => 'آواز کی پچ کی سطح';

  @override
  String get volumeLabel => 'والیوم';

  @override
  String get volumeSubtitle => 'پلے بیک والیوم';

  @override
  String get readingExperienceSection => 'پڑھنے کا تجربہ';

  @override
  String get fontSizeLabel => 'فونٹ سائز';

  @override
  String get fontSizeSubtitle => 'پڑھنے کے لیے متن کا سائز';

  @override
  String get lineHeightLabel => 'لائن کی اونچائی';

  @override
  String get lineHeightSubtitle => 'متن کی سطروں کے درمیان فاصلہ';

  @override
  String get languageSection => 'زبان';

  @override
  String get languageSubtitle => 'اپنی پسندیدہ زبان منتخب کریں';
}
