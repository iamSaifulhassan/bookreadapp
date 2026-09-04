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
  String get themeSection => 'Erscheinungsbild';

  @override
  String get themeSubtitle => 'Wähle, wie BookRead aussieht';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeSystem => 'System';

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

  @override
  String get signInTitle => 'Anmelden';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get emailHint => 'Gib deine E-Mail ein';

  @override
  String get emailRequiredError => 'E-Mail ist erforderlich';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get passwordHint => 'Gib dein Passwort ein';

  @override
  String get passwordRequiredError => 'Passwort ist erforderlich';

  @override
  String get signInButton => 'Anmelden';

  @override
  String get signInSuccessMessage => 'Anmeldung erfolgreich!';

  @override
  String get signInWithGoogleButton => 'Mit Google anmelden';

  @override
  String get googleSignInSuccessMessage => 'Google-Anmeldung erfolgreich!';

  @override
  String get googleSignInFailedMessage => 'Google-Anmeldung fehlgeschlagen.';

  @override
  String get noAccountSignUpPrompt => 'Noch kein Konto? Registrieren';

  @override
  String get commonOther => 'Andere';

  @override
  String get phoneNumberLabel => 'Telefonnummer';

  @override
  String get phoneNumberHint => 'Gib deine Telefonnummer ein';

  @override
  String get phoneRequiredError => 'Telefonnummer ist erforderlich';

  @override
  String get invalidPhoneError => 'Gib eine gültige Telefonnummer ein';

  @override
  String get invalidEmailError => 'Gib eine gültige E-Mail-Adresse ein';

  @override
  String get emailAlreadyExistsFieldError => 'Diese E-Mail existiert bereits.';

  @override
  String get countryLabel => 'Land';

  @override
  String get selectCountryHint => 'Wähle dein Land';

  @override
  String get countryPakistan => 'Pakistan';

  @override
  String get countryIndia => 'Indien';

  @override
  String get countryUnitedStates => 'Vereinigte Staaten';

  @override
  String get countryUnitedKingdom => 'Vereinigtes Königreich';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryAustralia => 'Australien';

  @override
  String get confirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get confirmPasswordHint => 'Passwort erneut eingeben';

  @override
  String get confirmPasswordRequiredError =>
      'Passwortbestätigung ist erforderlich';

  @override
  String get passwordsDoNotMatchError => 'Die Passwörter stimmen nicht überein';

  @override
  String get passwordTooShortError =>
      'Das Passwort muss mindestens 6 Zeichen lang sein';

  @override
  String get userTypeLabel => 'Ich bin...';

  @override
  String get selectUserTypeHint => 'Wähle deinen Benutzertyp';

  @override
  String get userTypeStudent => 'Student';

  @override
  String get userTypeTeacher => 'Lehrer';

  @override
  String get userTypeProfessional => 'Berufstätiger';

  @override
  String get userTypeResearcher => 'Forscher';

  @override
  String get signUpButton => 'Registrieren';

  @override
  String get signUpSuccessMessage => 'Registrierung erfolgreich!';

  @override
  String get alreadyHaveAccountSignInPrompt => 'Bereits ein Konto? Anmelden';

  @override
  String get profileTitle => 'Profil';

  @override
  String get refreshProfileTooltip => 'Profil aktualisieren';

  @override
  String get loadingProfile => 'Profil wird geladen...';

  @override
  String get noPhoneNumber => 'Keine Telefonnummer';

  @override
  String get noCountry => 'Kein Land';

  @override
  String get noUserType => 'Kein Benutzertyp';

  @override
  String get noEmail => 'Keine E-Mail';

  @override
  String get profileIncompleteMessage =>
      'Bitte vervollständige dein Profil, indem du Land, Benutzertyp und Telefonnummer angibst.';

  @override
  String failedToLoadProfileError(String error) {
    return 'Profildaten konnten nicht geladen werden: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'Fehler beim Aktualisieren des Profils: $error';
  }

  @override
  String get phoneFieldLabel => 'Telefon';

  @override
  String get phoneFieldHint => 'Gib dein Telefon ein';

  @override
  String get countryFieldHint => 'Gib dein Land ein';

  @override
  String get userTypeFieldLabel => 'Benutzertyp';

  @override
  String get userTypeFieldHint => 'Gib den Benutzertyp ein';

  @override
  String get editProfileButton => 'Profil bearbeiten';

  @override
  String get signOutButton => 'Abmelden';

  @override
  String get signOutConfirmMessage => 'Möchtest du dich wirklich abmelden?';

  @override
  String get tapToChangePhoto => 'Tippen, um das Profilbild zu ändern';

  @override
  String get profileImageSavedMessage => 'Profilbild erfolgreich gespeichert!';

  @override
  String get failedToSaveImageMessage =>
      'Bild konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get failedToPickImageMessage =>
      'Bild konnte nicht ausgewählt werden. Bitte versuche es erneut.';

  @override
  String get profileUpdatedMessage => 'Profil erfolgreich aktualisiert!';

  @override
  String get failedToUpdateProfileMessage =>
      'Profil konnte nicht aktualisiert werden. Bitte versuche es erneut.';

  @override
  String genericErrorMessage(String error) {
    return 'Fehler: $error';
  }

  @override
  String get emailAddressSectionLabel => 'E-Mail-Adresse';

  @override
  String get emailAddressHint => 'Gib deine E-Mail-Adresse ein';

  @override
  String get pleaseEnterEmailError => 'Bitte gib deine E-Mail-Adresse ein';

  @override
  String get pleaseEnterValidEmailError =>
      'Bitte gib eine gültige E-Mail-Adresse ein';

  @override
  String get pleaseEnterPhoneError => 'Bitte gib deine Telefonnummer ein';

  @override
  String get updatingButtonLabel => 'Wird aktualisiert...';

  @override
  String get updateProfileButtonLabel => 'Profil aktualisieren';

  @override
  String get downloadsTitle => 'Downloads';

  @override
  String get noDownloadsFound => 'Keine Downloads gefunden';

  @override
  String errorLoadingDownloads(String error) {
    return 'Fehler beim Laden der Downloads: $error';
  }

  @override
  String get favouritesTitle => 'Favoriten';

  @override
  String get listViewTooltip => 'Listenansicht';

  @override
  String get gridViewTooltip => 'Rasteransicht';

  @override
  String get noFavouriteBooksYet => 'Noch keine Lieblingsbücher';

  @override
  String get addBooksToFavouritesHint =>
      'Füge Bücher über den Bildschirm „Meine Bücher“ zu den Favoriten hinzu';
}
