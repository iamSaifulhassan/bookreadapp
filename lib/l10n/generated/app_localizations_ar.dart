// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get resetToDefaultsTooltip => 'إعادة التعيين إلى الافتراضي';

  @override
  String get settingsResetSuccess =>
      'تمت إعادة تعيين الإعدادات إلى الوضع الافتراضي';

  @override
  String settingsResetError(String error) {
    return 'خطأ أثناء إعادة تعيين الإعدادات: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'خطأ أثناء تحميل الإعدادات: $error';
  }

  @override
  String get textToSpeechSection => 'تحويل النص إلى كلام';

  @override
  String get speechRateLabel => 'سرعة الكلام';

  @override
  String get speechRateSubtitle => 'مدى سرعة نطق النص';

  @override
  String get pitchLabel => 'طبقة الصوت';

  @override
  String get pitchSubtitle => 'مستوى طبقة الصوت';

  @override
  String get volumeLabel => 'مستوى الصوت';

  @override
  String get volumeSubtitle => 'مستوى صوت التشغيل';

  @override
  String get readingExperienceSection => 'تجربة القراءة';

  @override
  String get fontSizeLabel => 'حجم الخط';

  @override
  String get fontSizeSubtitle => 'حجم النص للقراءة';

  @override
  String get lineHeightLabel => 'تباعد الأسطر';

  @override
  String get lineHeightSubtitle => 'المسافة بين أسطر النص';

  @override
  String get languageSection => 'اللغة';

  @override
  String get languageSubtitle => 'اختر لغتك المفضلة';
}
