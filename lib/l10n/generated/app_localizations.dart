import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('ur'),
    Locale('zh'),
  ];

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @resetToDefaultsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get resetToDefaultsTooltip;

  /// No description provided for @settingsResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Settings reset to defaults'**
  String get settingsResetSuccess;

  /// No description provided for @settingsResetError.
  ///
  /// In en, this message translates to:
  /// **'Error resetting settings: {error}'**
  String settingsResetError(String error);

  /// No description provided for @settingsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading settings: {error}'**
  String settingsLoadError(String error);

  /// No description provided for @textToSpeechSection.
  ///
  /// In en, this message translates to:
  /// **'Text-to-Speech'**
  String get textToSpeechSection;

  /// No description provided for @speechRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Speech Rate'**
  String get speechRateLabel;

  /// No description provided for @speechRateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How fast the text is spoken'**
  String get speechRateSubtitle;

  /// No description provided for @pitchLabel.
  ///
  /// In en, this message translates to:
  /// **'Pitch'**
  String get pitchLabel;

  /// No description provided for @pitchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Voice pitch level'**
  String get pitchSubtitle;

  /// No description provided for @volumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volumeLabel;

  /// No description provided for @volumeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Playback volume'**
  String get volumeSubtitle;

  /// No description provided for @readingExperienceSection.
  ///
  /// In en, this message translates to:
  /// **'Reading Experience'**
  String get readingExperienceSection;

  /// No description provided for @fontSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSizeLabel;

  /// No description provided for @fontSizeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Text size for reading'**
  String get fontSizeSubtitle;

  /// No description provided for @lineHeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Line Height'**
  String get lineHeightLabel;

  /// No description provided for @lineHeightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Space between lines of text'**
  String get lineHeightSubtitle;

  /// No description provided for @languageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSection;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get languageSubtitle;

  /// No description provided for @themeSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeSection;

  /// No description provided for @themeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how BookRead looks'**
  String get themeSubtitle;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get commonChange;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @myBooksTitle.
  ///
  /// In en, this message translates to:
  /// **'My Books'**
  String get myBooksTitle;

  /// No description provided for @loadingYourBooks.
  ///
  /// In en, this message translates to:
  /// **'Loading your books...'**
  String get loadingYourBooks;

  /// No description provided for @storageAccessRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Storage Access Required'**
  String get storageAccessRequiredTitle;

  /// No description provided for @storageAccessRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'This app needs storage permission to access and manage your book files.'**
  String get storageAccessRequiredBody;

  /// No description provided for @storageAccessRequiredHint.
  ///
  /// In en, this message translates to:
  /// **'Please enable storage permission in your device settings.'**
  String get storageAccessRequiredHint;

  /// No description provided for @openSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettingsButton;

  /// No description provided for @showAsListTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show as List'**
  String get showAsListTooltip;

  /// No description provided for @showAsGridTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show as Grid'**
  String get showAsGridTooltip;

  /// No description provided for @pickBookFilesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pick Book Files'**
  String get pickBookFilesTooltip;

  /// No description provided for @booksFolderPathLabel.
  ///
  /// In en, this message translates to:
  /// **'Books Folder Path'**
  String get booksFolderPathLabel;

  /// No description provided for @changeBooksFolderPathTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Books Folder Path'**
  String get changeBooksFolderPathTitle;

  /// No description provided for @selectBooksFolderTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Books Folder'**
  String get selectBooksFolderTitle;

  /// No description provided for @browseForFolderTooltip.
  ///
  /// In en, this message translates to:
  /// **'Browse for folder'**
  String get browseForFolderTooltip;

  /// No description provided for @noBooksMessage.
  ///
  /// In en, this message translates to:
  /// **'No book files in custom folder or picked. Tap + to add files.'**
  String get noBooksMessage;

  /// No description provided for @modifiedLabel.
  ///
  /// In en, this message translates to:
  /// **'Modified: {date}'**
  String modifiedLabel(String date);

  /// No description provided for @readLaterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Read Later'**
  String get readLaterTooltip;

  /// No description provided for @removeFromListTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from List'**
  String get removeFromListTooltip;

  /// No description provided for @removeFromFavouritesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favourites'**
  String get removeFromFavouritesTooltip;

  /// No description provided for @addToFavouritesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add to Favourites'**
  String get addToFavouritesTooltip;

  /// No description provided for @removeFromCompletedTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from Completed'**
  String get removeFromCompletedTooltip;

  /// No description provided for @markAsCompletedTooltip.
  ///
  /// In en, this message translates to:
  /// **'Mark as Completed'**
  String get markAsCompletedTooltip;

  /// No description provided for @fileAlreadyExistsMessage.
  ///
  /// In en, this message translates to:
  /// **'File already exists'**
  String get fileAlreadyExistsMessage;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @emailRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequiredError;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequiredError;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @signInSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Sign-in successful!'**
  String get signInSuccessMessage;

  /// No description provided for @signInWithGoogleButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogleButton;

  /// No description provided for @googleSignInSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in successful!'**
  String get googleSignInSuccessMessage;

  /// No description provided for @googleSignInFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed.'**
  String get googleSignInFailedMessage;

  /// No description provided for @noAccountSignUpPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? Sign Up'**
  String get noAccountSignUpPrompt;

  /// No description provided for @commonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get commonOther;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneNumberHint;

  /// No description provided for @phoneRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequiredError;

  /// No description provided for @invalidPhoneError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get invalidPhoneError;

  /// No description provided for @invalidEmailError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmailError;

  /// No description provided for @emailAlreadyExistsFieldError.
  ///
  /// In en, this message translates to:
  /// **'Email already exists.'**
  String get emailAlreadyExistsFieldError;

  /// No description provided for @countryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get countryLabel;

  /// No description provided for @selectCountryHint.
  ///
  /// In en, this message translates to:
  /// **'Select your country'**
  String get selectCountryHint;

  /// No description provided for @countryPakistan.
  ///
  /// In en, this message translates to:
  /// **'Pakistan'**
  String get countryPakistan;

  /// No description provided for @countryIndia.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get countryIndia;

  /// No description provided for @countryUnitedStates.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get countryUnitedStates;

  /// No description provided for @countryUnitedKingdom.
  ///
  /// In en, this message translates to:
  /// **'United Kingdom'**
  String get countryUnitedKingdom;

  /// No description provided for @countryCanada.
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get countryCanada;

  /// No description provided for @countryAustralia.
  ///
  /// In en, this message translates to:
  /// **'Australia'**
  String get countryAustralia;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// No description provided for @confirmPasswordRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password is required'**
  String get confirmPasswordRequiredError;

  /// No description provided for @passwordsDoNotMatchError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatchError;

  /// No description provided for @passwordTooShortError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShortError;

  /// No description provided for @userTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'I am a...'**
  String get userTypeLabel;

  /// No description provided for @selectUserTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Select User type'**
  String get selectUserTypeHint;

  /// No description provided for @userTypeStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get userTypeStudent;

  /// No description provided for @userTypeTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get userTypeTeacher;

  /// No description provided for @userTypeProfessional.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get userTypeProfessional;

  /// No description provided for @userTypeResearcher.
  ///
  /// In en, this message translates to:
  /// **'Researcher'**
  String get userTypeResearcher;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @signUpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Sign-up successful!'**
  String get signUpSuccessMessage;

  /// No description provided for @alreadyHaveAccountSignInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get alreadyHaveAccountSignInPrompt;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @refreshProfileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh Profile'**
  String get refreshProfileTooltip;

  /// No description provided for @loadingProfile.
  ///
  /// In en, this message translates to:
  /// **'Loading profile...'**
  String get loadingProfile;

  /// No description provided for @noPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'No phone number'**
  String get noPhoneNumber;

  /// No description provided for @noCountry.
  ///
  /// In en, this message translates to:
  /// **'No country'**
  String get noCountry;

  /// No description provided for @noUserType.
  ///
  /// In en, this message translates to:
  /// **'No user type'**
  String get noUserType;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No email'**
  String get noEmail;

  /// No description provided for @profileIncompleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Please complete your profile by adding your Country, User Type, and Phone Number.'**
  String get profileIncompleteMessage;

  /// No description provided for @failedToLoadProfileError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile data: {error}'**
  String failedToLoadProfileError(String error);

  /// No description provided for @errorUpdatingProfileError.
  ///
  /// In en, this message translates to:
  /// **'Error updating profile: {error}'**
  String errorUpdatingProfileError(String error);

  /// No description provided for @phoneFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneFieldLabel;

  /// No description provided for @phoneFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone'**
  String get phoneFieldHint;

  /// No description provided for @countryFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your country'**
  String get countryFieldHint;

  /// No description provided for @userTypeFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'User Type'**
  String get userTypeFieldLabel;

  /// No description provided for @userTypeFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter user type'**
  String get userTypeFieldHint;

  /// No description provided for @editProfileButton.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileButton;

  /// No description provided for @signOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutButton;

  /// No description provided for @signOutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmMessage;

  /// No description provided for @tapToChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to change profile picture'**
  String get tapToChangePhoto;

  /// No description provided for @profileImageSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile image saved successfully!'**
  String get profileImageSavedMessage;

  /// No description provided for @failedToSaveImageMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to save image. Please try again.'**
  String get failedToSaveImageMessage;

  /// No description provided for @failedToPickImageMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image. Please try again.'**
  String get failedToPickImageMessage;

  /// No description provided for @profileUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedMessage;

  /// No description provided for @failedToUpdateProfileMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile. Please try again.'**
  String get failedToUpdateProfileMessage;

  /// No description provided for @genericErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String genericErrorMessage(String error);

  /// No description provided for @emailAddressSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddressSectionLabel;

  /// No description provided for @emailAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailAddressHint;

  /// No description provided for @pleaseEnterEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get pleaseEnterEmailError;

  /// No description provided for @pleaseEnterValidEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get pleaseEnterValidEmailError;

  /// No description provided for @pleaseEnterPhoneError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhoneError;

  /// No description provided for @updatingButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updatingButtonLabel;

  /// No description provided for @updateProfileButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfileButtonLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'pt',
    'ru',
    'ur',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
