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

  @override
  String get signInTitle => 'Entrar';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailHint => 'Digite seu e-mail';

  @override
  String get emailRequiredError => 'O e-mail é obrigatório';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get passwordHint => 'Digite sua senha';

  @override
  String get passwordRequiredError => 'A senha é obrigatória';

  @override
  String get signInButton => 'Entrar';

  @override
  String get signInSuccessMessage => 'Login realizado com sucesso!';

  @override
  String get signInWithGoogleButton => 'Entrar com o Google';

  @override
  String get googleSignInSuccessMessage =>
      'Login com Google realizado com sucesso!';

  @override
  String get googleSignInFailedMessage => 'Falha ao entrar com o Google.';

  @override
  String get noAccountSignUpPrompt => 'Não tem uma conta? Cadastre-se';

  @override
  String get commonOther => 'Outro';

  @override
  String get phoneNumberLabel => 'Número de telefone';

  @override
  String get phoneNumberHint => 'Digite seu número de telefone';

  @override
  String get phoneRequiredError => 'O número de telefone é obrigatório';

  @override
  String get invalidPhoneError => 'Digite um número de telefone válido';

  @override
  String get invalidEmailError => 'Digite um endereço de e-mail válido';

  @override
  String get emailAlreadyExistsFieldError => 'Este e-mail já existe.';

  @override
  String get countryLabel => 'País';

  @override
  String get selectCountryHint => 'Selecione seu país';

  @override
  String get countryPakistan => 'Paquistão';

  @override
  String get countryIndia => 'Índia';

  @override
  String get countryUnitedStates => 'Estados Unidos';

  @override
  String get countryUnitedKingdom => 'Reino Unido';

  @override
  String get countryCanada => 'Canadá';

  @override
  String get countryAustralia => 'Austrália';

  @override
  String get confirmPasswordLabel => 'Confirmar Senha';

  @override
  String get confirmPasswordHint => 'Digite a senha novamente';

  @override
  String get confirmPasswordRequiredError =>
      'A confirmação de senha é obrigatória';

  @override
  String get passwordsDoNotMatchError => 'As senhas não coincidem';

  @override
  String get passwordTooShortError =>
      'A senha deve ter pelo menos 6 caracteres';

  @override
  String get userTypeLabel => 'Eu sou...';

  @override
  String get selectUserTypeHint => 'Selecione seu tipo de usuário';

  @override
  String get userTypeStudent => 'Estudante';

  @override
  String get userTypeTeacher => 'Professor';

  @override
  String get userTypeProfessional => 'Profissional';

  @override
  String get userTypeResearcher => 'Pesquisador';

  @override
  String get signUpButton => 'Cadastrar';

  @override
  String get signUpSuccessMessage => 'Cadastro realizado com sucesso!';

  @override
  String get alreadyHaveAccountSignInPrompt => 'Já tem uma conta? Entrar';
}
