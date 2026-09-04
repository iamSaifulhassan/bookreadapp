// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get resetToDefaultsTooltip => 'Restablecer valores predeterminados';

  @override
  String get settingsResetSuccess =>
      'Ajustes restablecidos a los valores predeterminados';

  @override
  String settingsResetError(String error) {
    return 'Error al restablecer los ajustes: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'Error al cargar los ajustes: $error';
  }

  @override
  String get textToSpeechSection => 'Texto a voz';

  @override
  String get speechRateLabel => 'Velocidad de voz';

  @override
  String get speechRateSubtitle => 'Qué tan rápido se lee el texto';

  @override
  String get pitchLabel => 'Tono';

  @override
  String get pitchSubtitle => 'Nivel de tono de voz';

  @override
  String get volumeLabel => 'Volumen';

  @override
  String get volumeSubtitle => 'Volumen de reproducción';

  @override
  String get readingExperienceSection => 'Experiencia de lectura';

  @override
  String get fontSizeLabel => 'Tamaño de fuente';

  @override
  String get fontSizeSubtitle => 'Tamaño del texto para leer';

  @override
  String get lineHeightLabel => 'Interlineado';

  @override
  String get lineHeightSubtitle => 'Espacio entre líneas de texto';

  @override
  String get languageSection => 'Idioma';

  @override
  String get languageSubtitle => 'Elige tu idioma preferido';
}
