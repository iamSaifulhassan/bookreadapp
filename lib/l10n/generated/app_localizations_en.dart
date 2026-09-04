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
}
