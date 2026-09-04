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
  String get themeSection => 'ظاہری شکل';

  @override
  String get themeSubtitle => 'منتخب کریں کہ BookRead کیسا دکھے';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String get themeSystem => 'سسٹم';

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

  @override
  String get signInTitle => 'سائن ان کریں';

  @override
  String get emailLabel => 'ای میل';

  @override
  String get emailHint => 'اپنا ای میل درج کریں';

  @override
  String get emailRequiredError => 'ای میل درکار ہے';

  @override
  String get passwordLabel => 'پاس ورڈ';

  @override
  String get passwordHint => 'اپنا پاس ورڈ درج کریں';

  @override
  String get passwordRequiredError => 'پاس ورڈ درکار ہے';

  @override
  String get signInButton => 'سائن ان کریں';

  @override
  String get signInSuccessMessage => 'سائن ان کامیاب رہا!';

  @override
  String get signInWithGoogleButton => 'Google کے ساتھ سائن ان کریں';

  @override
  String get googleSignInSuccessMessage => 'Google سائن ان کامیاب رہا!';

  @override
  String get googleSignInFailedMessage => 'Google سائن ان ناکام رہا۔';

  @override
  String get noAccountSignUpPrompt => 'اکاؤنٹ نہیں ہے؟ سائن اپ کریں';

  @override
  String get commonOther => 'دیگر';

  @override
  String get phoneNumberLabel => 'فون نمبر';

  @override
  String get phoneNumberHint => 'اپنا فون نمبر درج کریں';

  @override
  String get phoneRequiredError => 'فون نمبر درکار ہے';

  @override
  String get invalidPhoneError => 'ایک درست فون نمبر درج کریں';

  @override
  String get invalidEmailError => 'ایک درست ای میل ایڈریس درج کریں';

  @override
  String get emailAlreadyExistsFieldError => 'یہ ای میل پہلے سے موجود ہے۔';

  @override
  String get countryLabel => 'ملک';

  @override
  String get selectCountryHint => 'اپنا ملک منتخب کریں';

  @override
  String get countryPakistan => 'پاکستان';

  @override
  String get countryIndia => 'بھارت';

  @override
  String get countryUnitedStates => 'ریاستہائے متحدہ';

  @override
  String get countryUnitedKingdom => 'برطانیہ';

  @override
  String get countryCanada => 'کینیڈا';

  @override
  String get countryAustralia => 'آسٹریلیا';

  @override
  String get confirmPasswordLabel => 'پاس ورڈ کی تصدیق کریں';

  @override
  String get confirmPasswordHint => 'اپنا پاس ورڈ دوبارہ درج کریں';

  @override
  String get confirmPasswordRequiredError => 'پاس ورڈ کی تصدیق درکار ہے';

  @override
  String get passwordsDoNotMatchError => 'پاس ورڈز مماثل نہیں ہیں';

  @override
  String get passwordTooShortError => 'پاس ورڈ کم از کم 6 حروف کا ہونا چاہیے';

  @override
  String get userTypeLabel => 'میں ہوں...';

  @override
  String get selectUserTypeHint => 'اپنی صارف قسم منتخب کریں';

  @override
  String get userTypeStudent => 'طالب علم';

  @override
  String get userTypeTeacher => 'استاد';

  @override
  String get userTypeProfessional => 'پیشہ ور';

  @override
  String get userTypeResearcher => 'محقق';

  @override
  String get signUpButton => 'سائن اپ کریں';

  @override
  String get signUpSuccessMessage => 'سائن اپ کامیاب رہا!';

  @override
  String get alreadyHaveAccountSignInPrompt =>
      'پہلے سے اکاؤنٹ ہے؟ سائن ان کریں';

  @override
  String get profileTitle => 'پروفائل';

  @override
  String get refreshProfileTooltip => 'پروفائل ریفریش کریں';

  @override
  String get loadingProfile => 'پروفائل لوڈ ہو رہی ہے...';

  @override
  String get noPhoneNumber => 'کوئی فون نمبر نہیں';

  @override
  String get noCountry => 'کوئی ملک نہیں';

  @override
  String get noUserType => 'کوئی صارف قسم نہیں';

  @override
  String get noEmail => 'کوئی ای میل نہیں';

  @override
  String get profileIncompleteMessage =>
      'براہ کرم اپنا ملک، صارف قسم اور فون نمبر شامل کر کے اپنی پروفائل مکمل کریں۔';

  @override
  String failedToLoadProfileError(String error) {
    return 'پروفائل ڈیٹا لوڈ کرنے میں ناکامی: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'پروفائل اپ ڈیٹ کرنے میں خرابی: $error';
  }

  @override
  String get phoneFieldLabel => 'فون';

  @override
  String get phoneFieldHint => 'اپنا فون درج کریں';

  @override
  String get countryFieldHint => 'اپنا ملک درج کریں';

  @override
  String get userTypeFieldLabel => 'صارف قسم';

  @override
  String get userTypeFieldHint => 'صارف قسم درج کریں';

  @override
  String get editProfileButton => 'پروفائل میں ترمیم کریں';

  @override
  String get signOutButton => 'سائن آؤٹ کریں';

  @override
  String get signOutConfirmMessage => 'کیا آپ واقعی سائن آؤٹ کرنا چاہتے ہیں؟';
}
