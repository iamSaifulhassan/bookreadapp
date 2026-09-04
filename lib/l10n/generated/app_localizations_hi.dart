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

  @override
  String get downloadsTitle => 'डाउनलोड्स';

  @override
  String get noDownloadsFound => 'कोई डाउनलोड नहीं मिला';

  @override
  String errorLoadingDownloads(String error) {
    return 'डाउनलोड लोड करने में त्रुटि: $error';
  }

  @override
  String get favouritesTitle => 'पसंदीदा';

  @override
  String get listViewTooltip => 'सूची दृश्य';

  @override
  String get gridViewTooltip => 'ग्रिड दृश्य';

  @override
  String get noFavouriteBooksYet => 'अभी तक कोई पसंदीदा किताब नहीं';

  @override
  String get addBooksToFavouritesHint =>
      'मेरी किताबें स्क्रीन से किताबों को पसंदीदा में जोड़ें';

  @override
  String get readLaterTitle => 'बाद में पढ़ें';

  @override
  String get favouriteTooltip => 'पसंदीदा';

  @override
  String get removeFromReadLaterTooltip => 'बाद में पढ़ें से हटाएं';

  @override
  String get noBooksToReadLater => 'बाद में पढ़ने के लिए कोई किताब नहीं';

  @override
  String get addBooksToReadLaterHint =>
      'मेरी किताबें स्क्रीन से किताबें बाद में पढ़ने के लिए जोड़ें';

  @override
  String get completedBooksTitle => 'पूर्ण की गई किताबें';

  @override
  String get completedStatusLabel => 'पूर्ण';

  @override
  String get noCompletedBooksYet => 'अभी तक कोई पूर्ण की गई किताब नहीं';

  @override
  String get completedBooksHint => 'आपकी पढ़ी हुई किताबें यहाँ दिखाई देंगी';

  @override
  String get aboutTitle => 'परिचय';

  @override
  String get aboutBio =>
      'एक Flutter डेवलपर जो सुंदर और कार्यात्मक एप्लिकेशन बनाने का शौकीन है। यह ऐप Flutter और Firebase के साथ स्थानीय डेटा स्टोरेज का उपयोग करके बनाया गया है, जो मोबाइल डेवलपमेंट में कौशल दर्शाता है।';

  @override
  String get connectWithMeSection => 'मुझसे जुड़ें';

  @override
  String get loadingLabel => 'लोड हो रहा है...';

  @override
  String get pleaseWaitLabel => 'कृपया प्रतीक्षा करें...';

  @override
  String get bookReaderLabel => 'पुस्तक पाठक';

  @override
  String get userLabel => 'उपयोगकर्ता';

  @override
  String get logoutNav => 'लॉगआउट';

  @override
  String ttsErrorMessage(String message) {
    return 'TTS त्रुटि: $message';
  }

  @override
  String ttsControlErrorMessage(String error) {
    return 'TTS को नियंत्रित करने में त्रुटि: $error';
  }

  @override
  String ttsSpeakErrorMessage(String error) {
    return 'वाक्य बोलने में त्रुटि: $error';
  }

  @override
  String pageBookmarkedMessage(int page) {
    return 'पृष्ठ $page बुकमार्क किया गया';
  }

  @override
  String get bookmarkRemovedMessage => 'बुकमार्क हटा दिया गया';

  @override
  String get noBookmarksYetMessage => 'अभी तक कोई बुकमार्क नहीं';

  @override
  String get bookmarksDialogTitle => 'बुकमार्क्स';

  @override
  String pageLabel(int page) {
    return 'पृष्ठ $page';
  }

  @override
  String get closeButton => 'बंद करें';

  @override
  String snapshotFailedMessage(String error) {
    return 'स्नैपशॉट कैप्चर करने में विफल: $error';
  }

  @override
  String snapshotSaveFailedMessage(String error) {
    return 'स्नैपशॉट सहेजने में विफल: $error';
  }

  @override
  String get snapshotSavedTitle => 'स्नैपशॉट सहेजा गया';

  @override
  String get snapshotSavedBody => 'स्नैपशॉट सफलतापूर्वक सहेजा गया है!';

  @override
  String get locationLabel => 'स्थान:';

  @override
  String get goToPageTitle => 'पृष्ठ पर जाएं';

  @override
  String pageNumberLabel(int total) {
    return 'पृष्ठ संख्या (1-$total)';
  }

  @override
  String get invalidPageNumberMessage => 'अमान्य पृष्ठ संख्या';

  @override
  String get goButton => 'जाएं';

  @override
  String get toggleTextBufferTooltip => 'टेक्स्ट बफर टॉगल करें';

  @override
  String get ttsSettingsMenuItem => 'आवाज़ सेटिंग्स';

  @override
  String get reloadMenuItem => 'पुनः लोड करें';

  @override
  String loadingFileMessage(String fileName) {
    return '$fileName लोड हो रहा है...';
  }

  @override
  String get initializingViewerMessage =>
      'PDF व्यूअर और TTS इंजन शुरू हो रहा है';

  @override
  String get failedToLoadContentTitle => 'सामग्री लोड करने में विफल';

  @override
  String get unknownErrorMessage => 'एक अज्ञात त्रुटि हुई';

  @override
  String get readingBufferLabel => 'रीडिंग बफर';

  @override
  String get noSentencesAvailableMessage => 'कोई वाक्य उपलब्ध नहीं';

  @override
  String get sentenceStatusRead => 'पढ़ा गया';

  @override
  String get sentenceStatusCurrent => 'वर्तमान';

  @override
  String get sentenceStatusNext => 'अगला';

  @override
  String get pausedLabel => 'रुका हुआ';

  @override
  String get playingLabel => 'चल रहा है';

  @override
  String get previousSentenceTooltip => 'पिछला वाक्य';

  @override
  String get resumeTooltip => 'फिर से शुरू करें';

  @override
  String get pauseTooltip => 'रोकें';

  @override
  String get playTooltip => 'चलाएं';

  @override
  String get stopTooltip => 'रुकें';

  @override
  String get nextSentenceTooltip => 'अगला वाक्य';

  @override
  String get ttsSettingsSheetTitle => 'आवाज़ सेटिंग्स';

  @override
  String speechRateWithValue(String value) {
    return 'बोलने की गति: $value';
  }

  @override
  String pitchWithValue(String value) {
    return 'पिच: $value';
  }

  @override
  String volumeWithValue(String value) {
    return 'वॉल्यूम: $value%';
  }

  @override
  String get resetToDefaultButton => 'डिफ़ॉल्ट पर रीसेट करें';

  @override
  String get doneButton => 'हो गया';

  @override
  String get zoomInLabel => 'ज़ूम इन';

  @override
  String get zoomOutLabel => 'ज़ूम आउट';

  @override
  String get resetLabel => 'रीसेट करें';

  @override
  String get bookmarkLabel => 'बुकमार्क';

  @override
  String get snapshotLabel => 'स्नैपशॉट';

  @override
  String get goToPageLabel => 'पृष्ठ पर जाएं';

  @override
  String get moreLabel => 'अधिक';

  @override
  String pageOfPagesLabel(int current, int total) {
    return 'पृष्ठ $current / $total';
  }

  @override
  String get unableToExtractTextMessage =>
      'इस पृष्ठ से टेक्स्ट निकालने में असमर्थ।';

  @override
  String get noReadableTextMessage => 'कोई पठनीय टेक्स्ट नहीं मिला।';

  @override
  String get noSentencesFoundMessage => 'कोई वाक्य नहीं मिला।';

  @override
  String get unsupportedFileFormatMessage =>
      'असमर्थित फ़ाइल प्रारूप। केवल PDF और TXT फ़ाइलें समर्थित हैं।';

  @override
  String get subscriptionTitle => 'BookRead Premium';

  @override
  String get subscriptionUnlockPremium => 'BookRead का पूरा अनुभव अनलॉक करें';

  @override
  String get subscriptionRestoreButton => 'खरीदारी बहाल करें';

  @override
  String get subscriptionPurchaseSuccessMessage =>
      'सदस्यता सक्रिय हो गई। BookRead Premium का आनंद लें!';

  @override
  String get subscriptionPurchaseCancelledMessage => 'खरीदारी रद्द कर दी गई।';

  @override
  String subscriptionPurchaseFailedMessage(String error) {
    return 'खरीदारी विफल: $error';
  }

  @override
  String get subscriptionAlreadyActiveMessage =>
      'आप पहले से ही BookRead Premium के सदस्य हैं।';

  @override
  String get subscriptionNoOfferingsMessage =>
      'सदस्यताएं अभी उपलब्ध नहीं हैं। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get subscriptionRestoreSuccessMessage =>
      'आपकी खरीदारी बहाल कर दी गई है।';

  @override
  String subscriptionRestoreFailedMessage(String error) {
    return 'बहाली विफल: $error';
  }

  @override
  String get subscriptionSubscribeButton => 'सदस्यता लें';

  @override
  String get premiumNav => 'प्रीमियम लें';
}
