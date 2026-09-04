// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get resetToDefaultsTooltip => 'Réinitialiser les valeurs par défaut';

  @override
  String get settingsResetSuccess =>
      'Paramètres réinitialisés aux valeurs par défaut';

  @override
  String settingsResetError(String error) {
    return 'Erreur lors de la réinitialisation des paramètres : $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'Erreur lors du chargement des paramètres : $error';
  }

  @override
  String get textToSpeechSection => 'Synthèse vocale';

  @override
  String get speechRateLabel => 'Vitesse de la voix';

  @override
  String get speechRateSubtitle => 'Vitesse à laquelle le texte est lu';

  @override
  String get pitchLabel => 'Tonalité';

  @override
  String get pitchSubtitle => 'Niveau de tonalité de la voix';

  @override
  String get volumeLabel => 'Volume';

  @override
  String get volumeSubtitle => 'Volume de lecture';

  @override
  String get readingExperienceSection => 'Expérience de lecture';

  @override
  String get fontSizeLabel => 'Taille de police';

  @override
  String get fontSizeSubtitle => 'Taille du texte pour la lecture';

  @override
  String get lineHeightLabel => 'Interligne';

  @override
  String get lineHeightSubtitle => 'Espace entre les lignes de texte';

  @override
  String get languageSection => 'Langue';

  @override
  String get languageSubtitle => 'Choisissez votre langue préférée';
}
