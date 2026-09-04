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
  String get themeSection => 'Оформление';

  @override
  String get themeSubtitle => 'Выберите внешний вид BookRead';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeSystem => 'Системная';

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

  @override
  String get signInTitle => 'Вход';

  @override
  String get emailLabel => 'Электронная почта';

  @override
  String get emailHint => 'Введите свою электронную почту';

  @override
  String get emailRequiredError => 'Требуется электронная почта';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get passwordHint => 'Введите свой пароль';

  @override
  String get passwordRequiredError => 'Требуется пароль';

  @override
  String get signInButton => 'Войти';

  @override
  String get signInSuccessMessage => 'Вход выполнен успешно!';

  @override
  String get signInWithGoogleButton => 'Войти через Google';

  @override
  String get googleSignInSuccessMessage =>
      'Вход через Google выполнен успешно!';

  @override
  String get googleSignInFailedMessage => 'Не удалось войти через Google.';

  @override
  String get noAccountSignUpPrompt => 'Нет аккаунта? Зарегистрироваться';

  @override
  String get commonOther => 'Другое';

  @override
  String get phoneNumberLabel => 'Номер телефона';

  @override
  String get phoneNumberHint => 'Введите свой номер телефона';

  @override
  String get phoneRequiredError => 'Требуется номер телефона';

  @override
  String get invalidPhoneError => 'Введите действительный номер телефона';

  @override
  String get invalidEmailError =>
      'Введите действительный адрес электронной почты';

  @override
  String get emailAlreadyExistsFieldError =>
      'Эта электронная почта уже используется.';

  @override
  String get countryLabel => 'Страна';

  @override
  String get selectCountryHint => 'Выберите свою страну';

  @override
  String get countryPakistan => 'Пакистан';

  @override
  String get countryIndia => 'Индия';

  @override
  String get countryUnitedStates => 'США';

  @override
  String get countryUnitedKingdom => 'Великобритания';

  @override
  String get countryCanada => 'Канада';

  @override
  String get countryAustralia => 'Австралия';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get confirmPasswordHint => 'Введите пароль ещё раз';

  @override
  String get confirmPasswordRequiredError => 'Требуется подтверждение пароля';

  @override
  String get passwordsDoNotMatchError => 'Пароли не совпадают';

  @override
  String get passwordTooShortError =>
      'Пароль должен содержать не менее 6 символов';

  @override
  String get userTypeLabel => 'Я...';

  @override
  String get selectUserTypeHint => 'Выберите тип пользователя';

  @override
  String get userTypeStudent => 'Студент';

  @override
  String get userTypeTeacher => 'Преподаватель';

  @override
  String get userTypeProfessional => 'Специалист';

  @override
  String get userTypeResearcher => 'Исследователь';

  @override
  String get signUpButton => 'Зарегистрироваться';

  @override
  String get signUpSuccessMessage => 'Регистрация прошла успешно!';

  @override
  String get alreadyHaveAccountSignInPrompt => 'Уже есть аккаунт? Войти';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get refreshProfileTooltip => 'Обновить профиль';

  @override
  String get loadingProfile => 'Загрузка профиля...';

  @override
  String get noPhoneNumber => 'Нет номера телефона';

  @override
  String get noCountry => 'Нет страны';

  @override
  String get noUserType => 'Нет типа пользователя';

  @override
  String get noEmail => 'Нет электронной почты';

  @override
  String get profileIncompleteMessage =>
      'Пожалуйста, заполните профиль, указав страну, тип пользователя и номер телефона.';

  @override
  String failedToLoadProfileError(String error) {
    return 'Не удалось загрузить данные профиля: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'Ошибка при обновлении профиля: $error';
  }

  @override
  String get phoneFieldLabel => 'Телефон';

  @override
  String get phoneFieldHint => 'Введите свой телефон';

  @override
  String get countryFieldHint => 'Введите свою страну';

  @override
  String get userTypeFieldLabel => 'Тип пользователя';

  @override
  String get userTypeFieldHint => 'Введите тип пользователя';

  @override
  String get editProfileButton => 'Редактировать профиль';

  @override
  String get signOutButton => 'Выйти';

  @override
  String get signOutConfirmMessage => 'Вы уверены, что хотите выйти?';

  @override
  String get tapToChangePhoto => 'Нажмите, чтобы изменить фото профиля';

  @override
  String get profileImageSavedMessage =>
      'Изображение профиля успешно сохранено!';

  @override
  String get failedToSaveImageMessage =>
      'Не удалось сохранить изображение. Попробуйте снова.';

  @override
  String get failedToPickImageMessage =>
      'Не удалось выбрать изображение. Попробуйте снова.';

  @override
  String get profileUpdatedMessage => 'Профиль успешно обновлён!';

  @override
  String get failedToUpdateProfileMessage =>
      'Не удалось обновить профиль. Попробуйте снова.';

  @override
  String genericErrorMessage(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get emailAddressSectionLabel => 'Адрес электронной почты';

  @override
  String get emailAddressHint => 'Введите адрес электронной почты';

  @override
  String get pleaseEnterEmailError =>
      'Пожалуйста, введите адрес электронной почты';

  @override
  String get pleaseEnterValidEmailError =>
      'Пожалуйста, введите действительный адрес электронной почты';

  @override
  String get pleaseEnterPhoneError => 'Пожалуйста, введите номер телефона';

  @override
  String get updatingButtonLabel => 'Обновление...';

  @override
  String get updateProfileButtonLabel => 'Обновить профиль';

  @override
  String get downloadsTitle => 'Загрузки';

  @override
  String get noDownloadsFound => 'Загрузки не найдены';

  @override
  String errorLoadingDownloads(String error) {
    return 'Ошибка при загрузке загрузок: $error';
  }

  @override
  String get favouritesTitle => 'Избранное';

  @override
  String get listViewTooltip => 'Вид списком';

  @override
  String get gridViewTooltip => 'Вид сеткой';

  @override
  String get noFavouriteBooksYet => 'Пока нет избранных книг';

  @override
  String get addBooksToFavouritesHint =>
      'Добавьте книги в избранное на экране «Мои книги»';

  @override
  String get readLaterTitle => 'Прочитать позже';

  @override
  String get favouriteTooltip => 'Избранное';

  @override
  String get removeFromReadLaterTooltip => 'Удалить из «Прочитать позже»';

  @override
  String get noBooksToReadLater => 'Нет книг для чтения позже';

  @override
  String get addBooksToReadLaterHint =>
      'Добавьте книги для чтения позже на экране «Мои книги»';

  @override
  String get completedBooksTitle => 'Завершённые книги';

  @override
  String get completedStatusLabel => 'Завершено';

  @override
  String get noCompletedBooksYet => 'Пока нет завершённых книг';

  @override
  String get completedBooksHint => 'Книги, которые вы дочитали, появятся здесь';

  @override
  String get aboutTitle => 'О программе';

  @override
  String get aboutBio =>
      'Flutter-разработчик, увлечённый созданием красивых и функциональных приложений. Это приложение создано на Flutter и Firebase с локальным хранением данных, демонстрируя навыки мобильной разработки.';

  @override
  String get connectWithMeSection => 'Связаться со мной';

  @override
  String get loadingLabel => 'Загрузка...';

  @override
  String get pleaseWaitLabel => 'Пожалуйста, подождите...';

  @override
  String get bookReaderLabel => 'Читатель книг';

  @override
  String get userLabel => 'Пользователь';

  @override
  String get logoutNav => 'Выйти';
}
