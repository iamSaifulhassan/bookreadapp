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

  @override
  String get commonCancel => 'منسوخ کریں';

  @override
  String get commonChange => 'تبدیل کریں';

  @override
  String get commonRetry => 'دوبارہ کوشش کریں';

  @override
  String get commonShare => 'شیئر کریں';

  @override
  String get commonOk => 'ٹھیک ہے';

  @override
  String get myBooksTitle => 'میری کتابیں';

  @override
  String get loadingYourBooks => 'آپ کی کتابیں لوڈ ہو رہی ہیں...';

  @override
  String get storageAccessRequiredTitle => 'اسٹوریج تک رسائی درکار ہے';

  @override
  String get storageAccessRequiredBody =>
      'اس ایپ کو آپ کی کتاب فائلوں تک رسائی اور انہیں منظم کرنے کے لیے اسٹوریج کی اجازت درکار ہے۔';

  @override
  String get storageAccessRequiredHint =>
      'براہ کرم اپنے ڈیوائس کی ترتیبات میں اسٹوریج کی اجازت فعال کریں۔';

  @override
  String get openSettingsButton => 'ترتیبات کھولیں';

  @override
  String get showAsListTooltip => 'فہرست کے طور پر دکھائیں';

  @override
  String get showAsGridTooltip => 'گرڈ کے طور پر دکھائیں';

  @override
  String get pickBookFilesTooltip => 'کتاب فائلیں منتخب کریں';

  @override
  String get booksFolderPathLabel => 'کتاب فولڈر کا راستہ';

  @override
  String get changeBooksFolderPathTitle => 'کتاب فولڈر کا راستہ تبدیل کریں';

  @override
  String get selectBooksFolderTitle => 'کتاب فولڈر منتخب کریں';

  @override
  String get browseForFolderTooltip => 'فولڈر تلاش کریں';

  @override
  String get noBooksMessage =>
      'کسٹم فولڈر میں یا منتخب کردہ کوئی کتاب فائل نہیں ہے۔ فائلیں شامل کرنے کے لیے + پر ٹیپ کریں۔';

  @override
  String modifiedLabel(String date) {
    return 'ترمیم شدہ: $date';
  }

  @override
  String get readLaterTooltip => 'بعد میں پڑھیں';

  @override
  String get removeFromListTooltip => 'فہرست سے ہٹائیں';

  @override
  String get removeFromFavouritesTooltip => 'پسندیدہ سے ہٹائیں';

  @override
  String get addToFavouritesTooltip => 'پسندیدہ میں شامل کریں';

  @override
  String get removeFromCompletedTooltip => 'مکمل سے ہٹائیں';

  @override
  String get markAsCompletedTooltip => 'مکمل کے طور پر نشان زد کریں';

  @override
  String get fileAlreadyExistsMessage => 'فائل پہلے سے موجود ہے';
}
