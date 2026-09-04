// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get resetToDefaultsTooltip => 'Auf Standard zurücksetzen';

  @override
  String get settingsResetSuccess => 'Einstellungen auf Standard zurückgesetzt';

  @override
  String settingsResetError(String error) {
    return 'Fehler beim Zurücksetzen der Einstellungen: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'Fehler beim Laden der Einstellungen: $error';
  }

  @override
  String get textToSpeechSection => 'Text-zu-Sprache';

  @override
  String get speechRateLabel => 'Sprechgeschwindigkeit';

  @override
  String get speechRateSubtitle => 'Wie schnell der Text vorgelesen wird';

  @override
  String get pitchLabel => 'Tonhöhe';

  @override
  String get pitchSubtitle => 'Tonhöhe der Stimme';

  @override
  String get volumeLabel => 'Lautstärke';

  @override
  String get volumeSubtitle => 'Wiedergabelautstärke';

  @override
  String get readingExperienceSection => 'Leseerlebnis';

  @override
  String get fontSizeLabel => 'Schriftgröße';

  @override
  String get fontSizeSubtitle => 'Textgröße zum Lesen';

  @override
  String get lineHeightLabel => 'Zeilenhöhe';

  @override
  String get lineHeightSubtitle => 'Abstand zwischen den Textzeilen';

  @override
  String get languageSection => 'Sprache';

  @override
  String get languageSubtitle => 'Wählen Sie Ihre bevorzugte Sprache';
}
