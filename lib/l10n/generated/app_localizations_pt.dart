// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get resetToDefaultsTooltip => 'Restaurar padrões';

  @override
  String get settingsResetSuccess =>
      'Configurações restauradas para os padrões';

  @override
  String settingsResetError(String error) {
    return 'Erro ao restaurar as configurações: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'Erro ao carregar as configurações: $error';
  }

  @override
  String get textToSpeechSection => 'Texto para fala';

  @override
  String get speechRateLabel => 'Velocidade da fala';

  @override
  String get speechRateSubtitle => 'Velocidade com que o texto é lido';

  @override
  String get pitchLabel => 'Tom';

  @override
  String get pitchSubtitle => 'Nível de tom da voz';

  @override
  String get volumeLabel => 'Volume';

  @override
  String get volumeSubtitle => 'Volume de reprodução';

  @override
  String get readingExperienceSection => 'Experiência de leitura';

  @override
  String get fontSizeLabel => 'Tamanho da fonte';

  @override
  String get fontSizeSubtitle => 'Tamanho do texto para leitura';

  @override
  String get lineHeightLabel => 'Altura da linha';

  @override
  String get lineHeightSubtitle => 'Espaço entre linhas de texto';

  @override
  String get languageSection => 'Idioma';

  @override
  String get languageSubtitle => 'Escolha seu idioma preferido';
}
