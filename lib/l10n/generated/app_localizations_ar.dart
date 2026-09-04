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
  String get themeSection => 'المظهر';

  @override
  String get themeSubtitle => 'اختر مظهر التطبيق';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeSystem => 'النظام';

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

  @override
  String get signInTitle => 'تسجيل الدخول';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get emailRequiredError => 'البريد الإلكتروني مطلوب';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get passwordRequiredError => 'كلمة المرور مطلوبة';

  @override
  String get signInButton => 'تسجيل الدخول';

  @override
  String get signInSuccessMessage => 'تم تسجيل الدخول بنجاح!';

  @override
  String get signInWithGoogleButton => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get googleSignInSuccessMessage => 'تم تسجيل الدخول عبر جوجل بنجاح!';

  @override
  String get googleSignInFailedMessage => 'فشل تسجيل الدخول عبر جوجل.';

  @override
  String get noAccountSignUpPrompt => 'ليس لديك حساب؟ إنشاء حساب';

  @override
  String get commonOther => 'أخرى';

  @override
  String get phoneNumberLabel => 'رقم الهاتف';

  @override
  String get phoneNumberHint => 'أدخل رقم هاتفك';

  @override
  String get phoneRequiredError => 'رقم الهاتف مطلوب';

  @override
  String get invalidPhoneError => 'أدخل رقم هاتف صالح';

  @override
  String get invalidEmailError => 'أدخل عنوان بريد إلكتروني صالح';

  @override
  String get emailAlreadyExistsFieldError =>
      'هذا البريد الإلكتروني موجود بالفعل.';

  @override
  String get countryLabel => 'الدولة';

  @override
  String get selectCountryHint => 'اختر دولتك';

  @override
  String get countryPakistan => 'باكستان';

  @override
  String get countryIndia => 'الهند';

  @override
  String get countryUnitedStates => 'الولايات المتحدة';

  @override
  String get countryUnitedKingdom => 'المملكة المتحدة';

  @override
  String get countryCanada => 'كندا';

  @override
  String get countryAustralia => 'أستراليا';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordHint => 'أعد إدخال كلمة المرور';

  @override
  String get confirmPasswordRequiredError => 'تأكيد كلمة المرور مطلوب';

  @override
  String get passwordsDoNotMatchError => 'كلمتا المرور غير متطابقتين';

  @override
  String get passwordTooShortError =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get userTypeLabel => 'أنا...';

  @override
  String get selectUserTypeHint => 'اختر نوع المستخدم';

  @override
  String get userTypeStudent => 'طالب';

  @override
  String get userTypeTeacher => 'معلم';

  @override
  String get userTypeProfessional => 'محترف';

  @override
  String get userTypeResearcher => 'باحث';

  @override
  String get signUpButton => 'إنشاء حساب';

  @override
  String get signUpSuccessMessage => 'تم إنشاء الحساب بنجاح!';

  @override
  String get alreadyHaveAccountSignInPrompt => 'لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get refreshProfileTooltip => 'تحديث الملف الشخصي';

  @override
  String get loadingProfile => 'جارٍ تحميل الملف الشخصي...';

  @override
  String get noPhoneNumber => 'لا يوجد رقم هاتف';

  @override
  String get noCountry => 'لا توجد دولة';

  @override
  String get noUserType => 'لا يوجد نوع مستخدم';

  @override
  String get noEmail => 'لا يوجد بريد إلكتروني';

  @override
  String get profileIncompleteMessage =>
      'يرجى إكمال ملفك الشخصي بإضافة دولتك ونوع المستخدم ورقم الهاتف.';

  @override
  String failedToLoadProfileError(String error) {
    return 'فشل تحميل بيانات الملف الشخصي: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'خطأ أثناء تحديث الملف الشخصي: $error';
  }

  @override
  String get phoneFieldLabel => 'الهاتف';

  @override
  String get phoneFieldHint => 'أدخل هاتفك';

  @override
  String get countryFieldHint => 'أدخل دولتك';

  @override
  String get userTypeFieldLabel => 'نوع المستخدم';

  @override
  String get userTypeFieldHint => 'أدخل نوع المستخدم';

  @override
  String get editProfileButton => 'تعديل الملف الشخصي';

  @override
  String get signOutButton => 'تسجيل الخروج';

  @override
  String get signOutConfirmMessage => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get tapToChangePhoto => 'اضغط لتغيير صورة الملف الشخصي';

  @override
  String get profileImageSavedMessage => 'تم حفظ صورة الملف الشخصي بنجاح!';

  @override
  String get failedToSaveImageMessage =>
      'فشل حفظ الصورة. يرجى المحاولة مرة أخرى.';

  @override
  String get failedToPickImageMessage =>
      'فشل اختيار الصورة. يرجى المحاولة مرة أخرى.';

  @override
  String get profileUpdatedMessage => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get failedToUpdateProfileMessage =>
      'فشل تحديث الملف الشخصي. يرجى المحاولة مرة أخرى.';

  @override
  String genericErrorMessage(String error) {
    return 'خطأ: $error';
  }

  @override
  String get emailAddressSectionLabel => 'عنوان البريد الإلكتروني';

  @override
  String get emailAddressHint => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get pleaseEnterEmailError => 'يرجى إدخال عنوان بريدك الإلكتروني';

  @override
  String get pleaseEnterValidEmailError =>
      'يرجى إدخال عنوان بريد إلكتروني صالح';

  @override
  String get pleaseEnterPhoneError => 'يرجى إدخال رقم هاتفك';

  @override
  String get updatingButtonLabel => 'جارٍ التحديث...';

  @override
  String get updateProfileButtonLabel => 'تحديث الملف الشخصي';

  @override
  String get downloadsTitle => 'التنزيلات';

  @override
  String get noDownloadsFound => 'لم يتم العثور على تنزيلات';

  @override
  String errorLoadingDownloads(String error) {
    return 'خطأ أثناء تحميل التنزيلات: $error';
  }

  @override
  String get favouritesTitle => 'المفضلة';

  @override
  String get listViewTooltip => 'عرض القائمة';

  @override
  String get gridViewTooltip => 'عرض الشبكة';

  @override
  String get noFavouriteBooksYet => 'لا توجد كتب مفضلة بعد';

  @override
  String get addBooksToFavouritesHint => 'أضف كتبًا إلى المفضلة من شاشة كتبي';

  @override
  String get readLaterTitle => 'القراءة لاحقًا';

  @override
  String get favouriteTooltip => 'مفضلة';

  @override
  String get removeFromReadLaterTooltip => 'إزالة من القراءة لاحقًا';

  @override
  String get noBooksToReadLater => 'لا توجد كتب للقراءة لاحقًا';

  @override
  String get addBooksToReadLaterHint => 'أضف كتبًا للقراءة لاحقًا من شاشة كتبي';

  @override
  String get completedBooksTitle => 'الكتب المكتملة';

  @override
  String get completedStatusLabel => 'مكتمل';

  @override
  String get noCompletedBooksYet => 'لا توجد كتب مكتملة بعد';

  @override
  String get completedBooksHint => 'ستظهر هنا الكتب التي انتهيت من قراءتها';

  @override
  String get aboutTitle => 'حول';

  @override
  String get aboutBio =>
      'مطور Flutter شغوف بإنشاء تطبيقات جميلة وعملية. تم بناء هذا التطبيق باستخدام Flutter و Firebase مع تخزين بيانات محلي، مما يُظهر مهارات في تطوير تطبيقات الجوال.';

  @override
  String get connectWithMeSection => 'تواصل معي';
}
