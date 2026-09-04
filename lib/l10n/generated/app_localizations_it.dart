// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get resetToDefaultsTooltip => 'Ripristina impostazioni predefinite';

  @override
  String get settingsResetSuccess =>
      'Impostazioni ripristinate ai valori predefiniti';

  @override
  String settingsResetError(String error) {
    return 'Errore durante il ripristino delle impostazioni: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'Errore durante il caricamento delle impostazioni: $error';
  }

  @override
  String get textToSpeechSection => 'Sintesi vocale';

  @override
  String get speechRateLabel => 'Velocità del parlato';

  @override
  String get speechRateSubtitle => 'Quanto velocemente viene letto il testo';

  @override
  String get pitchLabel => 'Tono';

  @override
  String get pitchSubtitle => 'Livello di tono della voce';

  @override
  String get volumeLabel => 'Volume';

  @override
  String get volumeSubtitle => 'Volume di riproduzione';

  @override
  String get readingExperienceSection => 'Esperienza di lettura';

  @override
  String get fontSizeLabel => 'Dimensione carattere';

  @override
  String get fontSizeSubtitle => 'Dimensione del testo per la lettura';

  @override
  String get lineHeightLabel => 'Interlinea';

  @override
  String get lineHeightSubtitle => 'Spazio tra le righe di testo';

  @override
  String get languageSection => 'Lingua';

  @override
  String get languageSubtitle => 'Scegli la tua lingua preferita';

  @override
  String get themeSection => 'Aspetto';

  @override
  String get themeSubtitle => 'Scegli l\'aspetto di BookRead';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonChange => 'Cambia';

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonShare => 'Condividi';

  @override
  String get commonOk => 'OK';

  @override
  String get myBooksTitle => 'I Miei Libri';

  @override
  String get loadingYourBooks => 'Caricamento dei tuoi libri...';

  @override
  String get storageAccessRequiredTitle =>
      'Accesso all\'archiviazione richiesto';

  @override
  String get storageAccessRequiredBody =>
      'Questa app necessita dell\'autorizzazione di archiviazione per accedere e gestire i tuoi file di libri.';

  @override
  String get storageAccessRequiredHint =>
      'Abilita l\'autorizzazione di archiviazione nelle impostazioni del dispositivo.';

  @override
  String get openSettingsButton => 'Apri Impostazioni';

  @override
  String get showAsListTooltip => 'Mostra come Elenco';

  @override
  String get showAsGridTooltip => 'Mostra come Griglia';

  @override
  String get pickBookFilesTooltip => 'Scegli File di Libri';

  @override
  String get booksFolderPathLabel => 'Percorso della Cartella Libri';

  @override
  String get changeBooksFolderPathTitle =>
      'Cambia Percorso della Cartella Libri';

  @override
  String get selectBooksFolderTitle => 'Seleziona Cartella Libri';

  @override
  String get browseForFolderTooltip => 'Sfoglia per cartella';

  @override
  String get noBooksMessage =>
      'Nessun file di libro nella cartella personalizzata o selezionato. Tocca + per aggiungere file.';

  @override
  String modifiedLabel(String date) {
    return 'Modificato: $date';
  }

  @override
  String get readLaterTooltip => 'Leggi Più Tardi';

  @override
  String get removeFromListTooltip => 'Rimuovi dall\'Elenco';

  @override
  String get removeFromFavouritesTooltip => 'Rimuovi dai Preferiti';

  @override
  String get addToFavouritesTooltip => 'Aggiungi ai Preferiti';

  @override
  String get removeFromCompletedTooltip => 'Rimuovi dai Completati';

  @override
  String get markAsCompletedTooltip => 'Segna come Completato';

  @override
  String get fileAlreadyExistsMessage => 'Il file esiste già';

  @override
  String get signInTitle => 'Accedi';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Inserisci la tua email';

  @override
  String get emailRequiredError => 'L\'email è obbligatoria';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Inserisci la tua password';

  @override
  String get passwordRequiredError => 'La password è obbligatoria';

  @override
  String get signInButton => 'Accedi';

  @override
  String get signInSuccessMessage => 'Accesso effettuato con successo!';

  @override
  String get signInWithGoogleButton => 'Accedi con Google';

  @override
  String get googleSignInSuccessMessage => 'Accesso con Google riuscito!';

  @override
  String get googleSignInFailedMessage => 'Accesso con Google non riuscito.';

  @override
  String get noAccountSignUpPrompt => 'Non hai un account? Registrati';

  @override
  String get commonOther => 'Altro';

  @override
  String get phoneNumberLabel => 'Numero di telefono';

  @override
  String get phoneNumberHint => 'Inserisci il tuo numero di telefono';

  @override
  String get phoneRequiredError => 'Il numero di telefono è obbligatorio';

  @override
  String get invalidPhoneError => 'Inserisci un numero di telefono valido';

  @override
  String get invalidEmailError => 'Inserisci un indirizzo email valido';

  @override
  String get emailAlreadyExistsFieldError => 'Questa email esiste già.';

  @override
  String get countryLabel => 'Paese';

  @override
  String get selectCountryHint => 'Seleziona il tuo paese';

  @override
  String get countryPakistan => 'Pakistan';

  @override
  String get countryIndia => 'India';

  @override
  String get countryUnitedStates => 'Stati Uniti';

  @override
  String get countryUnitedKingdom => 'Regno Unito';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryAustralia => 'Australia';

  @override
  String get confirmPasswordLabel => 'Conferma Password';

  @override
  String get confirmPasswordHint => 'Reinserisci la tua password';

  @override
  String get confirmPasswordRequiredError =>
      'La conferma della password è obbligatoria';

  @override
  String get passwordsDoNotMatchError => 'Le password non corrispondono';

  @override
  String get passwordTooShortError =>
      'La password deve contenere almeno 6 caratteri';

  @override
  String get userTypeLabel => 'Sono...';

  @override
  String get selectUserTypeHint => 'Seleziona il tuo tipo di utente';

  @override
  String get userTypeStudent => 'Studente';

  @override
  String get userTypeTeacher => 'Insegnante';

  @override
  String get userTypeProfessional => 'Professionista';

  @override
  String get userTypeResearcher => 'Ricercatore';

  @override
  String get signUpButton => 'Registrati';

  @override
  String get signUpSuccessMessage => 'Registrazione avvenuta con successo!';

  @override
  String get alreadyHaveAccountSignInPrompt => 'Hai già un account? Accedi';

  @override
  String get profileTitle => 'Profilo';

  @override
  String get refreshProfileTooltip => 'Aggiorna Profilo';

  @override
  String get loadingProfile => 'Caricamento del profilo...';

  @override
  String get noPhoneNumber => 'Nessun numero di telefono';

  @override
  String get noCountry => 'Nessun paese';

  @override
  String get noUserType => 'Nessun tipo di utente';

  @override
  String get noEmail => 'Nessuna email';

  @override
  String get profileIncompleteMessage =>
      'Completa il tuo profilo aggiungendo paese, tipo di utente e numero di telefono.';

  @override
  String failedToLoadProfileError(String error) {
    return 'Impossibile caricare i dati del profilo: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'Errore durante l\'aggiornamento del profilo: $error';
  }

  @override
  String get phoneFieldLabel => 'Telefono';

  @override
  String get phoneFieldHint => 'Inserisci il tuo telefono';

  @override
  String get countryFieldHint => 'Inserisci il tuo paese';

  @override
  String get userTypeFieldLabel => 'Tipo di Utente';

  @override
  String get userTypeFieldHint => 'Inserisci il tipo di utente';

  @override
  String get editProfileButton => 'Modifica Profilo';

  @override
  String get signOutButton => 'Esci';

  @override
  String get signOutConfirmMessage => 'Sei sicuro di voler uscire?';
}
