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

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonChange => 'تغيير';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String get commonShare => 'مشاركة';

  @override
  String get commonOk => 'موافق';

  @override
  String get myBooksTitle => 'كتبي';

  @override
  String get loadingYourBooks => 'جارٍ تحميل كتبك...';

  @override
  String get storageAccessRequiredTitle => 'مطلوب الوصول إلى وحدة التخزين';

  @override
  String get storageAccessRequiredBody =>
      'يحتاج هذا التطبيق إلى إذن التخزين للوصول إلى ملفات كتبك وإدارتها.';

  @override
  String get storageAccessRequiredHint =>
      'يرجى تمكين إذن التخزين في إعدادات جهازك.';

  @override
  String get openSettingsButton => 'فتح الإعدادات';

  @override
  String get showAsListTooltip => 'عرض كقائمة';

  @override
  String get showAsGridTooltip => 'عرض كشبكة';

  @override
  String get pickBookFilesTooltip => 'اختيار ملفات الكتب';

  @override
  String get booksFolderPathLabel => 'مسار مجلد الكتب';

  @override
  String get changeBooksFolderPathTitle => 'تغيير مسار مجلد الكتب';

  @override
  String get selectBooksFolderTitle => 'اختيار مجلد الكتب';

  @override
  String get browseForFolderTooltip => 'تصفح للبحث عن مجلد';

  @override
  String get noBooksMessage =>
      'لا توجد ملفات كتب في المجلد المخصص أو المختارة. اضغط على + لإضافة ملفات.';

  @override
  String modifiedLabel(String date) {
    return 'تم التعديل: $date';
  }

  @override
  String get readLaterTooltip => 'القراءة لاحقًا';

  @override
  String get removeFromListTooltip => 'إزالة من القائمة';

  @override
  String get removeFromFavouritesTooltip => 'إزالة من المفضلة';

  @override
  String get addToFavouritesTooltip => 'إضافة إلى المفضلة';

  @override
  String get removeFromCompletedTooltip => 'إزالة من المكتملة';

  @override
  String get markAsCompletedTooltip => 'تعليم كمكتمل';

  @override
  String get fileAlreadyExistsMessage => 'الملف موجود بالفعل';
}
