// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get settingsTitle => '設定';

  @override
  String get resetToDefaultsTooltip => 'デフォルトにリセット';

  @override
  String get settingsResetSuccess => '設定をデフォルトにリセットしました';

  @override
  String settingsResetError(String error) {
    return '設定のリセット中にエラーが発生しました: $error';
  }

  @override
  String settingsLoadError(String error) {
    return '設定の読み込み中にエラーが発生しました: $error';
  }

  @override
  String get textToSpeechSection => 'テキスト読み上げ';

  @override
  String get speechRateLabel => '読み上げ速度';

  @override
  String get speechRateSubtitle => 'テキストが読み上げられる速さ';

  @override
  String get pitchLabel => 'ピッチ';

  @override
  String get pitchSubtitle => '音声のピッチレベル';

  @override
  String get volumeLabel => '音量';

  @override
  String get volumeSubtitle => '再生音量';

  @override
  String get readingExperienceSection => '読書体験';

  @override
  String get fontSizeLabel => 'フォントサイズ';

  @override
  String get fontSizeSubtitle => '読書用のテキストサイズ';

  @override
  String get lineHeightLabel => '行の高さ';

  @override
  String get lineHeightSubtitle => 'テキスト行間の間隔';

  @override
  String get languageSection => '言語';

  @override
  String get languageSubtitle => '希望する言語を選択してください';
}
