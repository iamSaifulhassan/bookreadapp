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
  String get themeSection => 'Aparência';

  @override
  String get themeSubtitle => 'Escolha a aparência do BookRead';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSystem => 'Sistema';

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

  @override
  String get profileTitle => 'Perfil';

  @override
  String get refreshProfileTooltip => 'Atualizar Perfil';

  @override
  String get loadingProfile => 'Carregando perfil...';

  @override
  String get noPhoneNumber => 'Sem número de telefone';

  @override
  String get noCountry => 'Sem país';

  @override
  String get noUserType => 'Sem tipo de usuário';

  @override
  String get noEmail => 'Sem e-mail';

  @override
  String get profileIncompleteMessage =>
      'Complete seu perfil adicionando seu país, tipo de usuário e número de telefone.';

  @override
  String failedToLoadProfileError(String error) {
    return 'Falha ao carregar os dados do perfil: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'Erro ao atualizar o perfil: $error';
  }

  @override
  String get phoneFieldLabel => 'Telefone';

  @override
  String get phoneFieldHint => 'Digite seu telefone';

  @override
  String get countryFieldHint => 'Digite seu país';

  @override
  String get userTypeFieldLabel => 'Tipo de Usuário';

  @override
  String get userTypeFieldHint => 'Digite o tipo de usuário';

  @override
  String get editProfileButton => 'Editar Perfil';

  @override
  String get signOutButton => 'Sair';

  @override
  String get signOutConfirmMessage => 'Tem certeza de que deseja sair?';

  @override
  String get tapToChangePhoto => 'Toque para alterar a foto de perfil';

  @override
  String get profileImageSavedMessage => 'Imagem de perfil salva com sucesso!';

  @override
  String get failedToSaveImageMessage =>
      'Falha ao salvar a imagem. Tente novamente.';

  @override
  String get failedToPickImageMessage =>
      'Falha ao selecionar a imagem. Tente novamente.';

  @override
  String get profileUpdatedMessage => 'Perfil atualizado com sucesso!';

  @override
  String get failedToUpdateProfileMessage =>
      'Falha ao atualizar o perfil. Tente novamente.';

  @override
  String genericErrorMessage(String error) {
    return 'Erro: $error';
  }

  @override
  String get emailAddressSectionLabel => 'Endereço de E-mail';

  @override
  String get emailAddressHint => 'Digite seu endereço de e-mail';

  @override
  String get pleaseEnterEmailError => 'Digite seu endereço de e-mail';

  @override
  String get pleaseEnterValidEmailError =>
      'Digite um endereço de e-mail válido';

  @override
  String get pleaseEnterPhoneError => 'Digite seu número de telefone';

  @override
  String get updatingButtonLabel => 'Atualizando...';

  @override
  String get updateProfileButtonLabel => 'Atualizar Perfil';

  @override
  String get downloadsTitle => 'Downloads';

  @override
  String get noDownloadsFound => 'Nenhum download encontrado';

  @override
  String errorLoadingDownloads(String error) {
    return 'Erro ao carregar os downloads: $error';
  }

  @override
  String get favouritesTitle => 'Favoritos';

  @override
  String get listViewTooltip => 'Visualização em Lista';

  @override
  String get gridViewTooltip => 'Visualização em Grade';

  @override
  String get noFavouriteBooksYet => 'Ainda não há livros favoritos';

  @override
  String get addBooksToFavouritesHint =>
      'Adicione livros aos favoritos na tela Meus Livros';

  @override
  String get readLaterTitle => 'Ler Mais Tarde';

  @override
  String get favouriteTooltip => 'Favorito';

  @override
  String get removeFromReadLaterTooltip => 'Remover de Ler Mais Tarde';

  @override
  String get noBooksToReadLater => 'Nenhum livro para ler mais tarde';

  @override
  String get addBooksToReadLaterHint =>
      'Adicione livros para ler mais tarde na tela Meus Livros';
}
