// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get resetToDefaultsTooltip => 'Сбросить настройки';

  @override
  String get settingsResetSuccess =>
      'Настройки сброшены до значений по умолчанию';

  @override
  String settingsResetError(String error) {
    return 'Ошибка при сбросе настроек: $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'Ошибка при загрузке настроек: $error';
  }

  @override
  String get textToSpeechSection => 'Синтез речи';

  @override
  String get speechRateLabel => 'Скорость речи';

  @override
  String get speechRateSubtitle => 'Насколько быстро читается текст';

  @override
  String get pitchLabel => 'Высота тона';

  @override
  String get pitchSubtitle => 'Уровень высоты голоса';

  @override
  String get volumeLabel => 'Громкость';

  @override
  String get volumeSubtitle => 'Громкость воспроизведения';

  @override
  String get readingExperienceSection => 'Комфорт чтения';

  @override
  String get fontSizeLabel => 'Размер шрифта';

  @override
  String get fontSizeSubtitle => 'Размер текста для чтения';

  @override
  String get lineHeightLabel => 'Межстрочный интервал';

  @override
  String get lineHeightSubtitle => 'Расстояние между строками текста';

  @override
  String get languageSection => 'Язык';

  @override
  String get languageSubtitle => 'Выберите предпочитаемый язык';
}
