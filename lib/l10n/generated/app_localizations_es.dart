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

  @override
  String get themeSection => 'Apariencia';

  @override
  String get themeSubtitle => 'Elige cómo se ve BookRead';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonChange => 'Cambiar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonShare => 'Compartir';

  @override
  String get commonOk => 'Aceptar';

  @override
  String get myBooksTitle => 'Mis Libros';

  @override
  String get loadingYourBooks => 'Cargando tus libros...';

  @override
  String get storageAccessRequiredTitle =>
      'Se requiere acceso al almacenamiento';

  @override
  String get storageAccessRequiredBody =>
      'Esta aplicación necesita permiso de almacenamiento para acceder y gestionar tus archivos de libros.';

  @override
  String get storageAccessRequiredHint =>
      'Habilita el permiso de almacenamiento en la configuración de tu dispositivo.';

  @override
  String get openSettingsButton => 'Abrir Configuración';

  @override
  String get showAsListTooltip => 'Mostrar como Lista';

  @override
  String get showAsGridTooltip => 'Mostrar como Cuadrícula';

  @override
  String get pickBookFilesTooltip => 'Elegir Archivos de Libros';

  @override
  String get booksFolderPathLabel => 'Ruta de la Carpeta de Libros';

  @override
  String get changeBooksFolderPathTitle =>
      'Cambiar Ruta de la Carpeta de Libros';

  @override
  String get selectBooksFolderTitle => 'Seleccionar Carpeta de Libros';

  @override
  String get browseForFolderTooltip => 'Buscar carpeta';

  @override
  String get noBooksMessage =>
      'No hay archivos de libros en la carpeta personalizada ni seleccionados. Toca + para añadir archivos.';

  @override
  String modifiedLabel(String date) {
    return 'Modificado: $date';
  }

  @override
  String get readLaterTooltip => 'Leer Más Tarde';

  @override
  String get removeFromListTooltip => 'Quitar de la Lista';

  @override
  String get removeFromFavouritesTooltip => 'Quitar de Favoritos';

  @override
  String get addToFavouritesTooltip => 'Añadir a Favoritos';

  @override
  String get removeFromCompletedTooltip => 'Quitar de Completados';

  @override
  String get markAsCompletedTooltip => 'Marcar como Completado';

  @override
  String get fileAlreadyExistsMessage => 'El archivo ya existe';

  @override
  String get signInTitle => 'Iniciar Sesión';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailHint => 'Introduce tu correo electrónico';

  @override
  String get emailRequiredError => 'El correo electrónico es obligatorio';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordHint => 'Introduce tu contraseña';

  @override
  String get passwordRequiredError => 'La contraseña es obligatoria';

  @override
  String get signInButton => 'Iniciar Sesión';

  @override
  String get signInSuccessMessage => '¡Inicio de sesión exitoso!';

  @override
  String get signInWithGoogleButton => 'Iniciar sesión con Google';

  @override
  String get googleSignInSuccessMessage =>
      '¡Inicio de sesión con Google exitoso!';

  @override
  String get googleSignInFailedMessage => 'Error al iniciar sesión con Google.';

  @override
  String get noAccountSignUpPrompt => '¿No tienes una cuenta? Regístrate';

  @override
  String get commonOther => 'Otro';

  @override
  String get phoneNumberLabel => 'Número de teléfono';

  @override
  String get phoneNumberHint => 'Introduce tu número de teléfono';

  @override
  String get phoneRequiredError => 'El número de teléfono es obligatorio';

  @override
  String get invalidPhoneError => 'Introduce un número de teléfono válido';

  @override
  String get invalidEmailError => 'Introduce un correo electrónico válido';

  @override
  String get emailAlreadyExistsFieldError => 'El correo electrónico ya existe.';

  @override
  String get countryLabel => 'País';

  @override
  String get selectCountryHint => 'Selecciona tu país';

  @override
  String get countryPakistan => 'Pakistán';

  @override
  String get countryIndia => 'India';

  @override
  String get countryUnitedStates => 'Estados Unidos';

  @override
  String get countryUnitedKingdom => 'Reino Unido';

  @override
  String get countryCanada => 'Canadá';

  @override
  String get countryAustralia => 'Australia';

  @override
  String get confirmPasswordLabel => 'Confirmar Contraseña';

  @override
  String get confirmPasswordHint => 'Vuelve a introducir tu contraseña';

  @override
  String get confirmPasswordRequiredError => 'Debes confirmar la contraseña';

  @override
  String get passwordsDoNotMatchError => 'Las contraseñas no coinciden';

  @override
  String get passwordTooShortError =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get userTypeLabel => 'Soy...';

  @override
  String get selectUserTypeHint => 'Selecciona tu tipo de usuario';

  @override
  String get userTypeStudent => 'Estudiante';

  @override
  String get userTypeTeacher => 'Profesor';

  @override
  String get userTypeProfessional => 'Profesional';

  @override
  String get userTypeResearcher => 'Investigador';

  @override
  String get signUpButton => 'Registrarse';

  @override
  String get signUpSuccessMessage => '¡Registro exitoso!';

  @override
  String get alreadyHaveAccountSignInPrompt =>
      '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get refreshProfileTooltip => 'Actualizar Perfil';

  @override
  String get loadingProfile => 'Cargando perfil...';

  @override
  String get noPhoneNumber => 'Sin número de teléfono';

  @override
  String get noCountry => 'Sin país';

  @override
  String get noUserType => 'Sin tipo de usuario';

  @override
  String get noEmail => 'Sin correo electrónico';

  @override
  String get profileIncompleteMessage =>
      'Completa tu perfil añadiendo tu país, tipo de usuario y número de teléfono.';

  @override
  String failedToLoadProfileError(String error) {
    return 'Error al cargar los datos del perfil: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'Error al actualizar el perfil: $error';
  }

  @override
  String get phoneFieldLabel => 'Teléfono';

  @override
  String get phoneFieldHint => 'Introduce tu teléfono';

  @override
  String get countryFieldHint => 'Introduce tu país';

  @override
  String get userTypeFieldLabel => 'Tipo de Usuario';

  @override
  String get userTypeFieldHint => 'Introduce el tipo de usuario';

  @override
  String get editProfileButton => 'Editar Perfil';

  @override
  String get signOutButton => 'Cerrar Sesión';

  @override
  String get signOutConfirmMessage => '¿Seguro que quieres cerrar sesión?';

  @override
  String get tapToChangePhoto => 'Toca para cambiar la foto de perfil';

  @override
  String get profileImageSavedMessage =>
      '¡Imagen de perfil guardada correctamente!';

  @override
  String get failedToSaveImageMessage =>
      'No se pudo guardar la imagen. Inténtalo de nuevo.';

  @override
  String get failedToPickImageMessage =>
      'No se pudo seleccionar la imagen. Inténtalo de nuevo.';

  @override
  String get profileUpdatedMessage => '¡Perfil actualizado correctamente!';

  @override
  String get failedToUpdateProfileMessage =>
      'No se pudo actualizar el perfil. Inténtalo de nuevo.';

  @override
  String genericErrorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get emailAddressSectionLabel => 'Correo Electrónico';

  @override
  String get emailAddressHint => 'Introduce tu correo electrónico';

  @override
  String get pleaseEnterEmailError => 'Introduce tu correo electrónico';

  @override
  String get pleaseEnterValidEmailError =>
      'Introduce un correo electrónico válido';

  @override
  String get pleaseEnterPhoneError => 'Introduce tu número de teléfono';

  @override
  String get updatingButtonLabel => 'Actualizando...';

  @override
  String get updateProfileButtonLabel => 'Actualizar Perfil';

  @override
  String get downloadsTitle => 'Descargas';

  @override
  String get noDownloadsFound => 'No se encontraron descargas';

  @override
  String errorLoadingDownloads(String error) {
    return 'Error al cargar las descargas: $error';
  }

  @override
  String get favouritesTitle => 'Favoritos';

  @override
  String get listViewTooltip => 'Vista de Lista';

  @override
  String get gridViewTooltip => 'Vista de Cuadrícula';

  @override
  String get noFavouriteBooksYet => 'Aún no hay libros favoritos';

  @override
  String get addBooksToFavouritesHint =>
      'Añade libros a favoritos desde la pantalla Mis Libros';
}
