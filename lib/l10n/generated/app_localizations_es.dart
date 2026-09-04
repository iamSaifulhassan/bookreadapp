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
}
