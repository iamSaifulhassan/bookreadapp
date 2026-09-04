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

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonChange => 'Alterar';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonShare => 'Compartilhar';

  @override
  String get commonOk => 'OK';

  @override
  String get myBooksTitle => 'Meus Livros';

  @override
  String get loadingYourBooks => 'Carregando seus livros...';

  @override
  String get storageAccessRequiredTitle => 'Acesso ao armazenamento necessário';

  @override
  String get storageAccessRequiredBody =>
      'Este aplicativo precisa de permissão de armazenamento para acessar e gerenciar seus arquivos de livros.';

  @override
  String get storageAccessRequiredHint =>
      'Ative a permissão de armazenamento nas configurações do seu dispositivo.';

  @override
  String get openSettingsButton => 'Abrir Configurações';

  @override
  String get showAsListTooltip => 'Mostrar como Lista';

  @override
  String get showAsGridTooltip => 'Mostrar como Grade';

  @override
  String get pickBookFilesTooltip => 'Escolher Arquivos de Livros';

  @override
  String get booksFolderPathLabel => 'Caminho da Pasta de Livros';

  @override
  String get changeBooksFolderPathTitle => 'Alterar Caminho da Pasta de Livros';

  @override
  String get selectBooksFolderTitle => 'Selecionar Pasta de Livros';

  @override
  String get browseForFolderTooltip => 'Procurar pasta';

  @override
  String get noBooksMessage =>
      'Nenhum arquivo de livro na pasta personalizada ou selecionado. Toque em + para adicionar arquivos.';

  @override
  String modifiedLabel(String date) {
    return 'Modificado: $date';
  }

  @override
  String get readLaterTooltip => 'Ler Mais Tarde';

  @override
  String get removeFromListTooltip => 'Remover da Lista';

  @override
  String get removeFromFavouritesTooltip => 'Remover dos Favoritos';

  @override
  String get addToFavouritesTooltip => 'Adicionar aos Favoritos';

  @override
  String get removeFromCompletedTooltip => 'Remover dos Concluídos';

  @override
  String get markAsCompletedTooltip => 'Marcar como Concluído';

  @override
  String get fileAlreadyExistsMessage => 'O arquivo já existe';
}
