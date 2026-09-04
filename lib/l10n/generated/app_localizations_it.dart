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
}
