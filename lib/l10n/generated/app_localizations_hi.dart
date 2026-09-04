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

  @override
  String get themeSection => 'रूप-रंग';

  @override
  String get themeSubtitle => 'चुनें कि BookRead कैसा दिखे';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeDark => 'गहरा';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonChange => 'बदलें';

  @override
  String get commonRetry => 'पुनः प्रयास करें';

  @override
  String get commonShare => 'साझा करें';

  @override
  String get commonOk => 'ठीक है';

  @override
  String get myBooksTitle => 'मेरी किताबें';

  @override
  String get loadingYourBooks => 'आपकी किताबें लोड हो रही हैं...';

  @override
  String get storageAccessRequiredTitle => 'स्टोरेज एक्सेस आवश्यक है';

  @override
  String get storageAccessRequiredBody =>
      'इस ऐप को आपकी किताब फ़ाइलों तक पहुँचने और उन्हें प्रबंधित करने के लिए स्टोरेज अनुमति की आवश्यकता है।';

  @override
  String get storageAccessRequiredHint =>
      'कृपया अपने डिवाइस की सेटिंग्स में स्टोरेज अनुमति सक्षम करें।';

  @override
  String get openSettingsButton => 'सेटिंग्स खोलें';

  @override
  String get showAsListTooltip => 'सूची के रूप में दिखाएं';

  @override
  String get showAsGridTooltip => 'ग्रिड के रूप में दिखाएं';

  @override
  String get pickBookFilesTooltip => 'किताब फ़ाइलें चुनें';

  @override
  String get booksFolderPathLabel => 'किताब फ़ोल्डर पथ';

  @override
  String get changeBooksFolderPathTitle => 'किताब फ़ोल्डर पथ बदलें';

  @override
  String get selectBooksFolderTitle => 'किताब फ़ोल्डर चुनें';

  @override
  String get browseForFolderTooltip => 'फ़ोल्डर के लिए ब्राउज़ करें';

  @override
  String get noBooksMessage =>
      'कस्टम फ़ोल्डर में या चुनी गई कोई किताब फ़ाइल नहीं है। फ़ाइलें जोड़ने के लिए + पर टैप करें।';

  @override
  String modifiedLabel(String date) {
    return 'संशोधित: $date';
  }

  @override
  String get readLaterTooltip => 'बाद में पढ़ें';

  @override
  String get removeFromListTooltip => 'सूची से हटाएं';

  @override
  String get removeFromFavouritesTooltip => 'पसंदीदा से हटाएं';

  @override
  String get addToFavouritesTooltip => 'पसंदीदा में जोड़ें';

  @override
  String get removeFromCompletedTooltip => 'पूर्ण से हटाएं';

  @override
  String get markAsCompletedTooltip => 'पूर्ण के रूप में चिह्नित करें';

  @override
  String get fileAlreadyExistsMessage => 'फ़ाइल पहले से मौजूद है';

  @override
  String get signInTitle => 'साइन इन करें';

  @override
  String get emailLabel => 'ईमेल';

  @override
  String get emailHint => 'अपना ईमेल दर्ज करें';

  @override
  String get emailRequiredError => 'ईमेल आवश्यक है';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get passwordHint => 'अपना पासवर्ड दर्ज करें';

  @override
  String get passwordRequiredError => 'पासवर्ड आवश्यक है';

  @override
  String get signInButton => 'साइन इन करें';

  @override
  String get signInSuccessMessage => 'साइन इन सफल रहा!';

  @override
  String get signInWithGoogleButton => 'Google से साइन इन करें';

  @override
  String get googleSignInSuccessMessage => 'Google साइन इन सफल रहा!';

  @override
  String get googleSignInFailedMessage => 'Google साइन इन विफल रहा।';

  @override
  String get noAccountSignUpPrompt => 'खाता नहीं है? साइन अप करें';

  @override
  String get commonOther => 'अन्य';

  @override
  String get phoneNumberLabel => 'फ़ोन नंबर';

  @override
  String get phoneNumberHint => 'अपना फ़ोन नंबर दर्ज करें';

  @override
  String get phoneRequiredError => 'फ़ोन नंबर आवश्यक है';

  @override
  String get invalidPhoneError => 'एक मान्य फ़ोन नंबर दर्ज करें';

  @override
  String get invalidEmailError => 'एक मान्य ईमेल पता दर्ज करें';

  @override
  String get emailAlreadyExistsFieldError => 'यह ईमेल पहले से मौजूद है।';

  @override
  String get countryLabel => 'देश';

  @override
  String get selectCountryHint => 'अपना देश चुनें';

  @override
  String get countryPakistan => 'पाकिस्तान';

  @override
  String get countryIndia => 'भारत';

  @override
  String get countryUnitedStates => 'संयुक्त राज्य अमेरिका';

  @override
  String get countryUnitedKingdom => 'यूनाइटेड किंगडम';

  @override
  String get countryCanada => 'कनाडा';

  @override
  String get countryAustralia => 'ऑस्ट्रेलिया';

  @override
  String get confirmPasswordLabel => 'पासवर्ड की पुष्टि करें';

  @override
  String get confirmPasswordHint => 'अपना पासवर्ड फिर से दर्ज करें';

  @override
  String get confirmPasswordRequiredError => 'पासवर्ड की पुष्टि आवश्यक है';

  @override
  String get passwordsDoNotMatchError => 'पासवर्ड मेल नहीं खाते';

  @override
  String get passwordTooShortError =>
      'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए';

  @override
  String get userTypeLabel => 'मैं हूं...';

  @override
  String get selectUserTypeHint => 'अपना उपयोगकर्ता प्रकार चुनें';

  @override
  String get userTypeStudent => 'छात्र';

  @override
  String get userTypeTeacher => 'शिक्षक';

  @override
  String get userTypeProfessional => 'पेशेवर';

  @override
  String get userTypeResearcher => 'शोधकर्ता';

  @override
  String get signUpButton => 'साइन अप करें';

  @override
  String get signUpSuccessMessage => 'साइन अप सफल रहा!';

  @override
  String get alreadyHaveAccountSignInPrompt => 'पहले से खाता है? साइन इन करें';

  @override
  String get profileTitle => 'प्रोफ़ाइल';

  @override
  String get refreshProfileTooltip => 'प्रोफ़ाइल रीफ्रेश करें';

  @override
  String get loadingProfile => 'प्रोफ़ाइल लोड हो रही है...';

  @override
  String get noPhoneNumber => 'कोई फ़ोन नंबर नहीं';

  @override
  String get noCountry => 'कोई देश नहीं';

  @override
  String get noUserType => 'कोई उपयोगकर्ता प्रकार नहीं';

  @override
  String get noEmail => 'कोई ईमेल नहीं';

  @override
  String get profileIncompleteMessage =>
      'कृपया अपना देश, उपयोगकर्ता प्रकार और फ़ोन नंबर जोड़कर अपनी प्रोफ़ाइल पूरी करें।';

  @override
  String failedToLoadProfileError(String error) {
    return 'प्रोफ़ाइल डेटा लोड करने में विफल: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'प्रोफ़ाइल अपडेट करने में त्रुटि: $error';
  }

  @override
  String get phoneFieldLabel => 'फ़ोन';

  @override
  String get phoneFieldHint => 'अपना फ़ोन दर्ज करें';

  @override
  String get countryFieldHint => 'अपना देश दर्ज करें';

  @override
  String get userTypeFieldLabel => 'उपयोगकर्ता प्रकार';

  @override
  String get userTypeFieldHint => 'उपयोगकर्ता प्रकार दर्ज करें';

  @override
  String get editProfileButton => 'प्रोफ़ाइल संपादित करें';

  @override
  String get signOutButton => 'साइन आउट करें';

  @override
  String get signOutConfirmMessage => 'क्या आप वाकई साइन आउट करना चाहते हैं?';

  @override
  String get tapToChangePhoto => 'प्रोफ़ाइल तस्वीर बदलने के लिए टैप करें';

  @override
  String get profileImageSavedMessage => 'प्रोफ़ाइल छवि सफलतापूर्वक सहेजी गई!';

  @override
  String get failedToSaveImageMessage =>
      'छवि सहेजने में विफल। कृपया पुनः प्रयास करें।';

  @override
  String get failedToPickImageMessage =>
      'छवि चुनने में विफल। कृपया पुनः प्रयास करें।';

  @override
  String get profileUpdatedMessage => 'प्रोफ़ाइल सफलतापूर्वक अपडेट की गई!';

  @override
  String get failedToUpdateProfileMessage =>
      'प्रोफ़ाइल अपडेट करने में विफल। कृपया पुनः प्रयास करें।';

  @override
  String genericErrorMessage(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get emailAddressSectionLabel => 'ईमेल पता';

  @override
  String get emailAddressHint => 'अपना ईमेल पता दर्ज करें';

  @override
  String get pleaseEnterEmailError => 'कृपया अपना ईमेल पता दर्ज करें';

  @override
  String get pleaseEnterValidEmailError => 'कृपया एक मान्य ईमेल पता दर्ज करें';

  @override
  String get pleaseEnterPhoneError => 'कृपया अपना फ़ोन नंबर दर्ज करें';

  @override
  String get updatingButtonLabel => 'अपडेट हो रहा है...';

  @override
  String get updateProfileButtonLabel => 'प्रोफ़ाइल अपडेट करें';
}
