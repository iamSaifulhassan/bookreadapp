import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('ur'),
    Locale('zh'),
  ];

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @resetToDefaultsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get resetToDefaultsTooltip;

  /// No description provided for @settingsResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Settings reset to defaults'**
  String get settingsResetSuccess;

  /// No description provided for @settingsResetError.
  ///
  /// In en, this message translates to:
  /// **'Error resetting settings: {error}'**
  String settingsResetError(String error);

  /// No description provided for @settingsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading settings: {error}'**
  String settingsLoadError(String error);

  /// No description provided for @textToSpeechSection.
  ///
  /// In en, this message translates to:
  /// **'Text-to-Speech'**
  String get textToSpeechSection;

  /// No description provided for @speechRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Speech Rate'**
  String get speechRateLabel;

  /// No description provided for @speechRateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How fast the text is spoken'**
  String get speechRateSubtitle;

  /// No description provided for @pitchLabel.
  ///
  /// In en, this message translates to:
  /// **'Pitch'**
  String get pitchLabel;

  /// No description provided for @pitchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Voice pitch level'**
  String get pitchSubtitle;

  /// No description provided for @volumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volumeLabel;

  /// No description provided for @volumeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Playback volume'**
  String get volumeSubtitle;

  /// No description provided for @readingExperienceSection.
  ///
  /// In en, this message translates to:
  /// **'Reading Experience'**
  String get readingExperienceSection;

  /// No description provided for @fontSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSizeLabel;

  /// No description provided for @fontSizeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Text size for reading'**
  String get fontSizeSubtitle;

  /// No description provided for @lineHeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Line Height'**
  String get lineHeightLabel;

  /// No description provided for @lineHeightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Space between lines of text'**
  String get lineHeightSubtitle;

  /// No description provided for @languageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSection;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get languageSubtitle;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get commonChange;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @myBooksTitle.
  ///
  /// In en, this message translates to:
  /// **'My Books'**
  String get myBooksTitle;

  /// No description provided for @loadingYourBooks.
  ///
  /// In en, this message translates to:
  /// **'Loading your books...'**
  String get loadingYourBooks;

  /// No description provided for @storageAccessRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Storage Access Required'**
  String get storageAccessRequiredTitle;

  /// No description provided for @storageAccessRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'This app needs storage permission to access and manage your book files.'**
  String get storageAccessRequiredBody;

  /// No description provided for @storageAccessRequiredHint.
  ///
  /// In en, this message translates to:
  /// **'Please enable storage permission in your device settings.'**
  String get storageAccessRequiredHint;

  /// No description provided for @openSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettingsButton;

  /// No description provided for @showAsListTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show as List'**
  String get showAsListTooltip;

  /// No description provided for @showAsGridTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show as Grid'**
  String get showAsGridTooltip;

  /// No description provided for @pickBookFilesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pick Book Files'**
  String get pickBookFilesTooltip;

  /// No description provided for @booksFolderPathLabel.
  ///
  /// In en, this message translates to:
  /// **'Books Folder Path'**
  String get booksFolderPathLabel;

  /// No description provided for @changeBooksFolderPathTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Books Folder Path'**
  String get changeBooksFolderPathTitle;

  /// No description provided for @selectBooksFolderTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Books Folder'**
  String get selectBooksFolderTitle;

  /// No description provided for @browseForFolderTooltip.
  ///
  /// In en, this message translates to:
  /// **'Browse for folder'**
  String get browseForFolderTooltip;

  /// No description provided for @noBooksMessage.
  ///
  /// In en, this message translates to:
  /// **'No book files in custom folder or picked. Tap + to add files.'**
  String get noBooksMessage;

  /// No description provided for @modifiedLabel.
  ///
  /// In en, this message translates to:
  /// **'Modified: {date}'**
  String modifiedLabel(String date);

  /// No description provided for @readLaterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Read Later'**
  String get readLaterTooltip;

  /// No description provided for @removeFromListTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from List'**
  String get removeFromListTooltip;

  /// No description provided for @removeFromFavouritesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favourites'**
  String get removeFromFavouritesTooltip;

  /// No description provided for @addToFavouritesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add to Favourites'**
  String get addToFavouritesTooltip;

  /// No description provided for @removeFromCompletedTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from Completed'**
  String get removeFromCompletedTooltip;

  /// No description provided for @markAsCompletedTooltip.
  ///
  /// In en, this message translates to:
  /// **'Mark as Completed'**
  String get markAsCompletedTooltip;

  /// No description provided for @fileAlreadyExistsMessage.
  ///
  /// In en, this message translates to:
  /// **'File already exists'**
  String get fileAlreadyExistsMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'pt',
    'ru',
    'ur',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
