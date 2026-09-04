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
}
