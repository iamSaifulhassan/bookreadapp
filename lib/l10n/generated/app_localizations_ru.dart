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

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonChange => 'Изменить';

  @override
  String get commonRetry => 'Повторить';

  @override
  String get commonShare => 'Поделиться';

  @override
  String get commonOk => 'ОК';

  @override
  String get myBooksTitle => 'Мои книги';

  @override
  String get loadingYourBooks => 'Загрузка ваших книг...';

  @override
  String get storageAccessRequiredTitle => 'Требуется доступ к хранилищу';

  @override
  String get storageAccessRequiredBody =>
      'Этому приложению требуется разрешение на доступ к хранилищу для доступа к вашим файлам книг и управления ими.';

  @override
  String get storageAccessRequiredHint =>
      'Пожалуйста, включите разрешение на хранилище в настройках устройства.';

  @override
  String get openSettingsButton => 'Открыть настройки';

  @override
  String get showAsListTooltip => 'Показать как список';

  @override
  String get showAsGridTooltip => 'Показать как сетку';

  @override
  String get pickBookFilesTooltip => 'Выбрать файлы книг';

  @override
  String get booksFolderPathLabel => 'Путь к папке с книгами';

  @override
  String get changeBooksFolderPathTitle => 'Изменить путь к папке с книгами';

  @override
  String get selectBooksFolderTitle => 'Выбрать папку с книгами';

  @override
  String get browseForFolderTooltip => 'Обзор папки';

  @override
  String get noBooksMessage =>
      'В выбранной папке нет файлов книг. Нажмите +, чтобы добавить файлы.';

  @override
  String modifiedLabel(String date) {
    return 'Изменено: $date';
  }

  @override
  String get readLaterTooltip => 'Прочитать позже';

  @override
  String get removeFromListTooltip => 'Удалить из списка';

  @override
  String get removeFromFavouritesTooltip => 'Удалить из избранного';

  @override
  String get addToFavouritesTooltip => 'Добавить в избранное';

  @override
  String get removeFromCompletedTooltip => 'Удалить из завершённых';

  @override
  String get markAsCompletedTooltip => 'Отметить как завершённое';

  @override
  String get fileAlreadyExistsMessage => 'Файл уже существует';
}
