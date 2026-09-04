// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get resetToDefaultsTooltip => 'Réinitialiser les valeurs par défaut';

  @override
  String get settingsResetSuccess =>
      'Paramètres réinitialisés aux valeurs par défaut';

  @override
  String settingsResetError(String error) {
    return 'Erreur lors de la réinitialisation des paramètres : $error';
  }

  @override
  String settingsLoadError(String error) {
    return 'Erreur lors du chargement des paramètres : $error';
  }

  @override
  String get textToSpeechSection => 'Synthèse vocale';

  @override
  String get speechRateLabel => 'Vitesse de la voix';

  @override
  String get speechRateSubtitle => 'Vitesse à laquelle le texte est lu';

  @override
  String get pitchLabel => 'Tonalité';

  @override
  String get pitchSubtitle => 'Niveau de tonalité de la voix';

  @override
  String get volumeLabel => 'Volume';

  @override
  String get volumeSubtitle => 'Volume de lecture';

  @override
  String get readingExperienceSection => 'Expérience de lecture';

  @override
  String get fontSizeLabel => 'Taille de police';

  @override
  String get fontSizeSubtitle => 'Taille du texte pour la lecture';

  @override
  String get lineHeightLabel => 'Interligne';

  @override
  String get lineHeightSubtitle => 'Espace entre les lignes de texte';

  @override
  String get languageSection => 'Langue';

  @override
  String get languageSubtitle => 'Choisissez votre langue préférée';

  @override
  String get themeSection => 'Apparence';

  @override
  String get themeSubtitle => 'Choisissez l\'apparence de BookRead';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonChange => 'Modifier';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonShare => 'Partager';

  @override
  String get commonOk => 'OK';

  @override
  String get myBooksTitle => 'Mes Livres';

  @override
  String get loadingYourBooks => 'Chargement de vos livres...';

  @override
  String get storageAccessRequiredTitle => 'Accès au stockage requis';

  @override
  String get storageAccessRequiredBody =>
      'Cette application a besoin de l\'autorisation de stockage pour accéder à vos fichiers de livres et les gérer.';

  @override
  String get storageAccessRequiredHint =>
      'Veuillez activer l\'autorisation de stockage dans les paramètres de votre appareil.';

  @override
  String get openSettingsButton => 'Ouvrir les Paramètres';

  @override
  String get showAsListTooltip => 'Afficher en Liste';

  @override
  String get showAsGridTooltip => 'Afficher en Grille';

  @override
  String get pickBookFilesTooltip => 'Choisir des Fichiers de Livres';

  @override
  String get booksFolderPathLabel => 'Chemin du Dossier de Livres';

  @override
  String get changeBooksFolderPathTitle =>
      'Modifier le Chemin du Dossier de Livres';

  @override
  String get selectBooksFolderTitle => 'Sélectionner le Dossier de Livres';

  @override
  String get browseForFolderTooltip => 'Parcourir pour un dossier';

  @override
  String get noBooksMessage =>
      'Aucun fichier de livre dans le dossier personnalisé ou sélectionné. Appuyez sur + pour ajouter des fichiers.';

  @override
  String modifiedLabel(String date) {
    return 'Modifié : $date';
  }

  @override
  String get readLaterTooltip => 'Lire Plus Tard';

  @override
  String get removeFromListTooltip => 'Retirer de la Liste';

  @override
  String get removeFromFavouritesTooltip => 'Retirer des Favoris';

  @override
  String get addToFavouritesTooltip => 'Ajouter aux Favoris';

  @override
  String get removeFromCompletedTooltip => 'Retirer des Terminés';

  @override
  String get markAsCompletedTooltip => 'Marquer comme Terminé';

  @override
  String get fileAlreadyExistsMessage => 'Le fichier existe déjà';

  @override
  String get signInTitle => 'Connexion';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailHint => 'Entrez votre e-mail';

  @override
  String get emailRequiredError => 'L\'e-mail est requis';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordHint => 'Entrez votre mot de passe';

  @override
  String get passwordRequiredError => 'Le mot de passe est requis';

  @override
  String get signInButton => 'Connexion';

  @override
  String get signInSuccessMessage => 'Connexion réussie !';

  @override
  String get signInWithGoogleButton => 'Se connecter avec Google';

  @override
  String get googleSignInSuccessMessage => 'Connexion Google réussie !';

  @override
  String get googleSignInFailedMessage => 'Échec de la connexion Google.';

  @override
  String get noAccountSignUpPrompt =>
      'Vous n\'avez pas de compte ? Inscrivez-vous';

  @override
  String get commonOther => 'Autre';

  @override
  String get phoneNumberLabel => 'Numéro de téléphone';

  @override
  String get phoneNumberHint => 'Entrez votre numéro de téléphone';

  @override
  String get phoneRequiredError => 'Le numéro de téléphone est requis';

  @override
  String get invalidPhoneError => 'Entrez un numéro de téléphone valide';

  @override
  String get invalidEmailError => 'Entrez une adresse e-mail valide';

  @override
  String get emailAlreadyExistsFieldError => 'Cet e-mail existe déjà.';

  @override
  String get countryLabel => 'Pays';

  @override
  String get selectCountryHint => 'Sélectionnez votre pays';

  @override
  String get countryPakistan => 'Pakistan';

  @override
  String get countryIndia => 'Inde';

  @override
  String get countryUnitedStates => 'États-Unis';

  @override
  String get countryUnitedKingdom => 'Royaume-Uni';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryAustralia => 'Australie';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get confirmPasswordHint => 'Ressaisissez votre mot de passe';

  @override
  String get confirmPasswordRequiredError =>
      'La confirmation du mot de passe est requise';

  @override
  String get passwordsDoNotMatchError =>
      'Les mots de passe ne correspondent pas';

  @override
  String get passwordTooShortError =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get userTypeLabel => 'Je suis...';

  @override
  String get selectUserTypeHint => 'Sélectionnez votre type d\'utilisateur';

  @override
  String get userTypeStudent => 'Étudiant';

  @override
  String get userTypeTeacher => 'Enseignant';

  @override
  String get userTypeProfessional => 'Professionnel';

  @override
  String get userTypeResearcher => 'Chercheur';

  @override
  String get signUpButton => 'S\'inscrire';

  @override
  String get signUpSuccessMessage => 'Inscription réussie !';

  @override
  String get alreadyHaveAccountSignInPrompt =>
      'Vous avez déjà un compte ? Connectez-vous';

  @override
  String get profileTitle => 'Profil';

  @override
  String get refreshProfileTooltip => 'Actualiser le Profil';

  @override
  String get loadingProfile => 'Chargement du profil...';

  @override
  String get noPhoneNumber => 'Aucun numéro de téléphone';

  @override
  String get noCountry => 'Aucun pays';

  @override
  String get noUserType => 'Aucun type d\'utilisateur';

  @override
  String get noEmail => 'Aucun e-mail';

  @override
  String get profileIncompleteMessage =>
      'Veuillez compléter votre profil en ajoutant votre pays, type d\'utilisateur et numéro de téléphone.';

  @override
  String failedToLoadProfileError(String error) {
    return 'Échec du chargement des données du profil : $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'Erreur lors de la mise à jour du profil : $error';
  }

  @override
  String get phoneFieldLabel => 'Téléphone';

  @override
  String get phoneFieldHint => 'Entrez votre téléphone';

  @override
  String get countryFieldHint => 'Entrez votre pays';

  @override
  String get userTypeFieldLabel => 'Type d\'Utilisateur';

  @override
  String get userTypeFieldHint => 'Entrez le type d\'utilisateur';

  @override
  String get editProfileButton => 'Modifier le Profil';

  @override
  String get signOutButton => 'Déconnexion';

  @override
  String get signOutConfirmMessage => 'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get tapToChangePhoto => 'Appuyez pour changer la photo de profil';

  @override
  String get profileImageSavedMessage =>
      'Image de profil enregistrée avec succès !';

  @override
  String get failedToSaveImageMessage =>
      'Échec de l\'enregistrement de l\'image. Réessayez.';

  @override
  String get failedToPickImageMessage =>
      'Échec de la sélection de l\'image. Réessayez.';

  @override
  String get profileUpdatedMessage => 'Profil mis à jour avec succès !';

  @override
  String get failedToUpdateProfileMessage =>
      'Échec de la mise à jour du profil. Réessayez.';

  @override
  String genericErrorMessage(String error) {
    return 'Erreur : $error';
  }

  @override
  String get emailAddressSectionLabel => 'Adresse e-mail';

  @override
  String get emailAddressHint => 'Entrez votre adresse e-mail';

  @override
  String get pleaseEnterEmailError => 'Veuillez entrer votre adresse e-mail';

  @override
  String get pleaseEnterValidEmailError =>
      'Veuillez entrer une adresse e-mail valide';

  @override
  String get pleaseEnterPhoneError =>
      'Veuillez entrer votre numéro de téléphone';

  @override
  String get updatingButtonLabel => 'Mise à jour...';

  @override
  String get updateProfileButtonLabel => 'Mettre à jour le profil';

  @override
  String get downloadsTitle => 'Téléchargements';

  @override
  String get noDownloadsFound => 'Aucun téléchargement trouvé';

  @override
  String errorLoadingDownloads(String error) {
    return 'Erreur lors du chargement des téléchargements : $error';
  }

  @override
  String get favouritesTitle => 'Favoris';

  @override
  String get listViewTooltip => 'Vue en Liste';

  @override
  String get gridViewTooltip => 'Vue en Grille';

  @override
  String get noFavouriteBooksYet => 'Aucun livre favori pour le moment';

  @override
  String get addBooksToFavouritesHint =>
      'Ajoutez des livres aux favoris depuis l\'écran Mes Livres';

  @override
  String get readLaterTitle => 'Lire Plus Tard';

  @override
  String get favouriteTooltip => 'Favori';

  @override
  String get removeFromReadLaterTooltip => 'Retirer de Lire Plus Tard';

  @override
  String get noBooksToReadLater => 'Aucun livre à lire plus tard';

  @override
  String get addBooksToReadLaterHint =>
      'Ajoutez des livres à lire plus tard depuis l\'écran Mes Livres';

  @override
  String get completedBooksTitle => 'Livres Terminés';

  @override
  String get completedStatusLabel => 'Terminé';

  @override
  String get noCompletedBooksYet => 'Aucun livre terminé pour le moment';

  @override
  String get completedBooksHint =>
      'Les livres que vous avez terminés apparaîtront ici';
}
