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

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonChange => 'Ändern';

  @override
  String get commonRetry => 'Wiederholen';

  @override
  String get commonShare => 'Teilen';

  @override
  String get commonOk => 'OK';

  @override
  String get myBooksTitle => 'Meine Bücher';

  @override
  String get loadingYourBooks => 'Deine Bücher werden geladen...';

  @override
  String get storageAccessRequiredTitle => 'Speicherzugriff erforderlich';

  @override
  String get storageAccessRequiredBody =>
      'Diese App benötigt die Speicherberechtigung, um auf deine Buchdateien zuzugreifen und sie zu verwalten.';

  @override
  String get storageAccessRequiredHint =>
      'Bitte aktiviere die Speicherberechtigung in den Geräteeinstellungen.';

  @override
  String get openSettingsButton => 'Einstellungen öffnen';

  @override
  String get showAsListTooltip => 'Als Liste anzeigen';

  @override
  String get showAsGridTooltip => 'Als Raster anzeigen';

  @override
  String get pickBookFilesTooltip => 'Buchdateien auswählen';

  @override
  String get booksFolderPathLabel => 'Pfad des Bücherordners';

  @override
  String get changeBooksFolderPathTitle => 'Pfad des Bücherordners ändern';

  @override
  String get selectBooksFolderTitle => 'Bücherordner auswählen';

  @override
  String get browseForFolderTooltip => 'Nach Ordner suchen';

  @override
  String get noBooksMessage =>
      'Keine Buchdateien im benutzerdefinierten Ordner oder ausgewählt. Tippe auf +, um Dateien hinzuzufügen.';

  @override
  String modifiedLabel(String date) {
    return 'Geändert: $date';
  }

  @override
  String get readLaterTooltip => 'Später lesen';

  @override
  String get removeFromListTooltip => 'Aus Liste entfernen';

  @override
  String get removeFromFavouritesTooltip => 'Aus Favoriten entfernen';

  @override
  String get addToFavouritesTooltip => 'Zu Favoriten hinzufügen';

  @override
  String get removeFromCompletedTooltip => 'Aus Abgeschlossen entfernen';

  @override
  String get markAsCompletedTooltip => 'Als abgeschlossen markieren';

  @override
  String get fileAlreadyExistsMessage => 'Die Datei existiert bereits';
}
