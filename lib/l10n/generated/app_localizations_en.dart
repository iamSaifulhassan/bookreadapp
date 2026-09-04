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
}
