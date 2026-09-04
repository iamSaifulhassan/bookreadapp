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

  /// No description provided for @downloadsTitle.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloadsTitle;

  /// No description provided for @noDownloadsFound.
  ///
  /// In en, this message translates to:
  /// **'No downloads found'**
  String get noDownloadsFound;

  /// No description provided for @errorLoadingDownloads.
  ///
  /// In en, this message translates to:
  /// **'Error loading downloads: {error}'**
  String errorLoadingDownloads(String error);

  /// No description provided for @favouritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favouritesTitle;

  /// No description provided for @listViewTooltip.
  ///
  /// In en, this message translates to:
  /// **'List View'**
  String get listViewTooltip;

  /// No description provided for @gridViewTooltip.
  ///
  /// In en, this message translates to:
  /// **'Grid View'**
  String get gridViewTooltip;

  /// No description provided for @noFavouriteBooksYet.
  ///
  /// In en, this message translates to:
  /// **'No favourite books yet'**
  String get noFavouriteBooksYet;

  /// No description provided for @addBooksToFavouritesHint.
  ///
  /// In en, this message translates to:
  /// **'Add books to favourites from the My Books screen'**
  String get addBooksToFavouritesHint;

  /// No description provided for @readLaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Read Later'**
  String get readLaterTitle;

  /// No description provided for @favouriteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favouriteTooltip;

  /// No description provided for @removeFromReadLaterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from Read Later'**
  String get removeFromReadLaterTooltip;

  /// No description provided for @noBooksToReadLater.
  ///
  /// In en, this message translates to:
  /// **'No books to read later'**
  String get noBooksToReadLater;

  /// No description provided for @addBooksToReadLaterHint.
  ///
  /// In en, this message translates to:
  /// **'Add books to read later from the My Books screen'**
  String get addBooksToReadLaterHint;

  /// No description provided for @completedBooksTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed Books'**
  String get completedBooksTitle;

  /// No description provided for @completedStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStatusLabel;

  /// No description provided for @noCompletedBooksYet.
  ///
  /// In en, this message translates to:
  /// **'No completed books yet'**
  String get noCompletedBooksYet;

  /// No description provided for @completedBooksHint.
  ///
  /// In en, this message translates to:
  /// **'Books you\'ve finished reading will appear here'**
  String get completedBooksHint;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutBio.
  ///
  /// In en, this message translates to:
  /// **'A Flutter developer with a passion for creating beautiful and functional applications. This app is built using Flutter and Firebase with Local Data Storage, showcasing skills in mobile development.'**
  String get aboutBio;

  /// No description provided for @connectWithMeSection.
  ///
  /// In en, this message translates to:
  /// **'Connect with me'**
  String get connectWithMeSection;

  /// No description provided for @loadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingLabel;

  /// No description provided for @pleaseWaitLabel.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWaitLabel;

  /// No description provided for @bookReaderLabel.
  ///
  /// In en, this message translates to:
  /// **'Book Reader'**
  String get bookReaderLabel;

  /// No description provided for @userLabel.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userLabel;

  /// No description provided for @logoutNav.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutNav;

  /// No description provided for @ttsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'TTS Error: {message}'**
  String ttsErrorMessage(String message);

  /// No description provided for @ttsControlErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error controlling TTS: {error}'**
  String ttsControlErrorMessage(String error);

  /// No description provided for @ttsSpeakErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error speaking sentence: {error}'**
  String ttsSpeakErrorMessage(String error);

  /// No description provided for @pageBookmarkedMessage.
  ///
  /// In en, this message translates to:
  /// **'Page {page} bookmarked'**
  String pageBookmarkedMessage(int page);

  /// No description provided for @bookmarkRemovedMessage.
  ///
  /// In en, this message translates to:
  /// **'Bookmark removed'**
  String get bookmarkRemovedMessage;

  /// No description provided for @noBookmarksYetMessage.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get noBookmarksYetMessage;

  /// No description provided for @bookmarksDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarksDialogTitle;

  /// No description provided for @pageLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String pageLabel(int page);

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @snapshotFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to capture snapshot: {error}'**
  String snapshotFailedMessage(String error);

  /// No description provided for @snapshotSaveFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to save snapshot: {error}'**
  String snapshotSaveFailedMessage(String error);

  /// No description provided for @snapshotSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Snapshot Saved'**
  String get snapshotSavedTitle;

  /// No description provided for @snapshotSavedBody.
  ///
  /// In en, this message translates to:
  /// **'Snapshot has been saved successfully!'**
  String get snapshotSavedBody;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location:'**
  String get locationLabel;

  /// No description provided for @goToPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Go to Page'**
  String get goToPageTitle;

  /// No description provided for @pageNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Page Number (1-{total})'**
  String pageNumberLabel(int total);

  /// No description provided for @invalidPageNumberMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid page number'**
  String get invalidPageNumberMessage;

  /// No description provided for @goButton.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get goButton;

  /// No description provided for @toggleTextBufferTooltip.
  ///
  /// In en, this message translates to:
  /// **'Toggle Text Buffer'**
  String get toggleTextBufferTooltip;

  /// No description provided for @ttsSettingsMenuItem.
  ///
  /// In en, this message translates to:
  /// **'TTS Settings'**
  String get ttsSettingsMenuItem;

  /// No description provided for @reloadMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reloadMenuItem;

  /// No description provided for @loadingFileMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading {fileName}...'**
  String loadingFileMessage(String fileName);

  /// No description provided for @initializingViewerMessage.
  ///
  /// In en, this message translates to:
  /// **'Initializing PDF viewer and TTS engine'**
  String get initializingViewerMessage;

  /// No description provided for @failedToLoadContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Content'**
  String get failedToLoadContentTitle;

  /// No description provided for @unknownErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred'**
  String get unknownErrorMessage;

  /// No description provided for @readingBufferLabel.
  ///
  /// In en, this message translates to:
  /// **'Reading Buffer'**
  String get readingBufferLabel;

  /// No description provided for @noSentencesAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'No sentences available'**
  String get noSentencesAvailableMessage;

  /// No description provided for @sentenceStatusRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get sentenceStatusRead;

  /// No description provided for @sentenceStatusCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get sentenceStatusCurrent;

  /// No description provided for @sentenceStatusNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get sentenceStatusNext;

  /// No description provided for @pausedLabel.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get pausedLabel;

  /// No description provided for @playingLabel.
  ///
  /// In en, this message translates to:
  /// **'Playing'**
  String get playingLabel;

  /// No description provided for @previousSentenceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous Sentence'**
  String get previousSentenceTooltip;

  /// No description provided for @resumeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeTooltip;

  /// No description provided for @pauseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseTooltip;

  /// No description provided for @playTooltip.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get playTooltip;

  /// No description provided for @stopTooltip.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopTooltip;

  /// No description provided for @nextSentenceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Next Sentence'**
  String get nextSentenceTooltip;

  /// No description provided for @ttsSettingsSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'TTS Settings'**
  String get ttsSettingsSheetTitle;

  /// No description provided for @speechRateWithValue.
  ///
  /// In en, this message translates to:
  /// **'Speech Rate: {value}'**
  String speechRateWithValue(String value);

  /// No description provided for @pitchWithValue.
  ///
  /// In en, this message translates to:
  /// **'Pitch: {value}'**
  String pitchWithValue(String value);

  /// No description provided for @volumeWithValue.
  ///
  /// In en, this message translates to:
  /// **'Volume: {value}%'**
  String volumeWithValue(String value);

  /// No description provided for @resetToDefaultButton.
  ///
  /// In en, this message translates to:
  /// **'Reset to Default'**
  String get resetToDefaultButton;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @zoomInLabel.
  ///
  /// In en, this message translates to:
  /// **'Zoom In'**
  String get zoomInLabel;

  /// No description provided for @zoomOutLabel.
  ///
  /// In en, this message translates to:
  /// **'Zoom Out'**
  String get zoomOutLabel;

  /// No description provided for @resetLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetLabel;

  /// No description provided for @bookmarkLabel.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmarkLabel;

  /// No description provided for @snapshotLabel.
  ///
  /// In en, this message translates to:
  /// **'Snapshot'**
  String get snapshotLabel;

  /// No description provided for @goToPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Go to Page'**
  String get goToPageLabel;

  /// No description provided for @moreLabel.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreLabel;

  /// No description provided for @pageOfPagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageOfPagesLabel(int current, int total);

  /// No description provided for @unableToExtractTextMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to extract text from this page.'**
  String get unableToExtractTextMessage;

  /// No description provided for @noReadableTextMessage.
  ///
  /// In en, this message translates to:
  /// **'No readable text found.'**
  String get noReadableTextMessage;

  /// No description provided for @noSentencesFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'No sentences found.'**
  String get noSentencesFoundMessage;

  /// No description provided for @unsupportedFileFormatMessage.
  ///
  /// In en, this message translates to:
  /// **'Unsupported file format. Only PDF and TXT files are supported.'**
  String get unsupportedFileFormatMessage;

  /// No description provided for @subscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'BookRead Premium'**
  String get subscriptionTitle;

  /// No description provided for @subscriptionUnlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock the full BookRead experience'**
  String get subscriptionUnlockPremium;

  /// No description provided for @subscriptionRestoreButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get subscriptionRestoreButton;

  /// No description provided for @subscriptionPurchaseSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Subscription activated. Enjoy BookRead Premium!'**
  String get subscriptionPurchaseSuccessMessage;

  /// No description provided for @subscriptionPurchaseCancelledMessage.
  ///
  /// In en, this message translates to:
  /// **'Purchase cancelled.'**
  String get subscriptionPurchaseCancelledMessage;

  /// No description provided for @subscriptionPurchaseFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed: {error}'**
  String subscriptionPurchaseFailedMessage(String error);

  /// No description provided for @subscriptionAlreadyActiveMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'re already subscribed to BookRead Premium.'**
  String get subscriptionAlreadyActiveMessage;

  /// No description provided for @subscriptionNoOfferingsMessage.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions aren\'t available right now. Please try again later.'**
  String get subscriptionNoOfferingsMessage;

  /// No description provided for @subscriptionRestoreSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your purchase has been restored.'**
  String get subscriptionRestoreSuccessMessage;

  /// No description provided for @subscriptionRestoreFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String subscriptionRestoreFailedMessage(String error);

  /// No description provided for @subscriptionSubscribeButton.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscriptionSubscribeButton;

  /// No description provided for @premiumNav.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get premiumNav;
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
