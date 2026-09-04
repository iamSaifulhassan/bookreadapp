// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'Settings';

  @override
  String get resetToDefaultsTooltip => 'Reset to defaults';

  @override
  String get settingsResetSuccess => 'Settings reset to defaults';

  @override
  String settingsResetError(String error) {
    return 'Error resetting settings: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'Error loading settings: $error';
  }

  @override
  String get textToSpeechSection => 'Text-to-Speech';

  @override
  String get speechRateLabel => 'Speech Rate';

  @override
  String get speechRateSubtitle => 'How fast the text is spoken';

  @override
  String get pitchLabel => 'Pitch';

  @override
  String get pitchSubtitle => 'Voice pitch level';

  @override
  String get volumeLabel => 'Volume';

  @override
  String get volumeSubtitle => 'Playback volume';

  @override
  String get readingExperienceSection => 'Reading Experience';

  @override
  String get fontSizeLabel => 'Font Size';

  @override
  String get fontSizeSubtitle => 'Text size for reading';

  @override
  String get lineHeightLabel => 'Line Height';

  @override
  String get lineHeightSubtitle => 'Space between lines of text';

  @override
  String get languageSection => 'Language';

  @override
  String get languageSubtitle => 'Choose your preferred language';

  @override
  String get themeSection => 'Appearance';

  @override
  String get themeSubtitle => 'Choose how BookRead looks';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonChange => 'Change';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonShare => 'Share';

  @override
  String get commonOk => 'OK';

  @override
  String get myBooksTitle => 'My Books';

  @override
  String get loadingYourBooks => 'Loading your books...';

  @override
  String get storageAccessRequiredTitle => 'Storage Access Required';

  @override
  String get storageAccessRequiredBody =>
      'This app needs storage permission to access and manage your book files.';

  @override
  String get storageAccessRequiredHint =>
      'Please enable storage permission in your device settings.';

  @override
  String get openSettingsButton => 'Open Settings';

  @override
  String get showAsListTooltip => 'Show as List';

  @override
  String get showAsGridTooltip => 'Show as Grid';

  @override
  String get pickBookFilesTooltip => 'Pick Book Files';

  @override
  String get booksFolderPathLabel => 'Books Folder Path';

  @override
  String get changeBooksFolderPathTitle => 'Change Books Folder Path';

  @override
  String get selectBooksFolderTitle => 'Select Books Folder';

  @override
  String get browseForFolderTooltip => 'Browse for folder';

  @override
  String get noBooksMessage =>
      'No book files in custom folder or picked. Tap + to add files.';

  @override
  String modifiedLabel(String date) {
    return 'Modified: $date';
  }

  @override
  String get readLaterTooltip => 'Read Later';

  @override
  String get removeFromListTooltip => 'Remove from List';

  @override
  String get removeFromFavouritesTooltip => 'Remove from Favourites';

  @override
  String get addToFavouritesTooltip => 'Add to Favourites';

  @override
  String get removeFromCompletedTooltip => 'Remove from Completed';

  @override
  String get markAsCompletedTooltip => 'Mark as Completed';

  @override
  String get fileAlreadyExistsMessage => 'File already exists';

  @override
  String get signInTitle => 'Sign In';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get emailRequiredError => 'Email is required';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get passwordRequiredError => 'Password is required';

  @override
  String get signInButton => 'Sign In';

  @override
  String get signInSuccessMessage => 'Sign-in successful!';

  @override
  String get signInWithGoogleButton => 'Sign in with Google';

  @override
  String get googleSignInSuccessMessage => 'Google sign-in successful!';

  @override
  String get googleSignInFailedMessage => 'Google sign-in failed.';

  @override
  String get noAccountSignUpPrompt => 'Don’t have an account? Sign Up';

  @override
  String get commonOther => 'Other';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get phoneNumberHint => 'Enter your phone number';

  @override
  String get phoneRequiredError => 'Phone number is required';

  @override
  String get invalidPhoneError => 'Enter a valid phone number';

  @override
  String get invalidEmailError => 'Enter a valid email address';

  @override
  String get emailAlreadyExistsFieldError => 'Email already exists.';

  @override
  String get countryLabel => 'Country';

  @override
  String get selectCountryHint => 'Select your country';

  @override
  String get countryPakistan => 'Pakistan';

  @override
  String get countryIndia => 'India';

  @override
  String get countryUnitedStates => 'United States';

  @override
  String get countryUnitedKingdom => 'United Kingdom';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryAustralia => 'Australia';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get confirmPasswordRequiredError => 'Confirm Password is required';

  @override
  String get passwordsDoNotMatchError => 'Passwords do not match';

  @override
  String get passwordTooShortError => 'Password must be at least 6 characters';

  @override
  String get userTypeLabel => 'I am a...';

  @override
  String get selectUserTypeHint => 'Select User type';

  @override
  String get userTypeStudent => 'Student';

  @override
  String get userTypeTeacher => 'Teacher';

  @override
  String get userTypeProfessional => 'Professional';

  @override
  String get userTypeResearcher => 'Researcher';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get signUpSuccessMessage => 'Sign-up successful!';

  @override
  String get alreadyHaveAccountSignInPrompt =>
      'Already have an account? Sign In';

  @override
  String get profileTitle => 'Profile';

  @override
  String get refreshProfileTooltip => 'Refresh Profile';

  @override
  String get loadingProfile => 'Loading profile...';

  @override
  String get noPhoneNumber => 'No phone number';

  @override
  String get noCountry => 'No country';

  @override
  String get noUserType => 'No user type';

  @override
  String get noEmail => 'No email';

  @override
  String get profileIncompleteMessage =>
      'Please complete your profile by adding your Country, User Type, and Phone Number.';

  @override
  String failedToLoadProfileError(String error) {
    return 'Failed to load profile data: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'Error updating profile: $error';
  }

  @override
  String get phoneFieldLabel => 'Phone';

  @override
  String get phoneFieldHint => 'Enter your phone';

  @override
  String get countryFieldHint => 'Enter your country';

  @override
  String get userTypeFieldLabel => 'User Type';

  @override
  String get userTypeFieldHint => 'Enter user type';

  @override
  String get editProfileButton => 'Edit Profile';

  @override
  String get signOutButton => 'Sign Out';

  @override
  String get signOutConfirmMessage => 'Are you sure you want to sign out?';
}
