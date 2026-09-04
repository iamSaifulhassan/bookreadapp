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

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonChange => '変更';

  @override
  String get commonRetry => '再試行';

  @override
  String get commonShare => '共有';

  @override
  String get commonOk => 'OK';

  @override
  String get myBooksTitle => 'マイブック';

  @override
  String get loadingYourBooks => '本を読み込んでいます...';

  @override
  String get storageAccessRequiredTitle => 'ストレージへのアクセスが必要です';

  @override
  String get storageAccessRequiredBody =>
      'このアプリは、本のファイルにアクセスして管理するためにストレージの許可が必要です。';

  @override
  String get storageAccessRequiredHint => 'デバイスの設定でストレージの許可を有効にしてください。';

  @override
  String get openSettingsButton => '設定を開く';

  @override
  String get showAsListTooltip => 'リスト表示';

  @override
  String get showAsGridTooltip => 'グリッド表示';

  @override
  String get pickBookFilesTooltip => '本のファイルを選択';

  @override
  String get booksFolderPathLabel => '本のフォルダのパス';

  @override
  String get changeBooksFolderPathTitle => '本のフォルダのパスを変更';

  @override
  String get selectBooksFolderTitle => '本のフォルダを選択';

  @override
  String get browseForFolderTooltip => 'フォルダを参照';

  @override
  String get noBooksMessage =>
      'カスタムフォルダに本のファイルがないか、選択されていません。+ をタップしてファイルを追加してください。';

  @override
  String modifiedLabel(String date) {
    return '更新日時: $date';
  }

  @override
  String get readLaterTooltip => '後で読む';

  @override
  String get removeFromListTooltip => 'リストから削除';

  @override
  String get removeFromFavouritesTooltip => 'お気に入りから削除';

  @override
  String get addToFavouritesTooltip => 'お気に入りに追加';

  @override
  String get removeFromCompletedTooltip => '完了から削除';

  @override
  String get markAsCompletedTooltip => '完了としてマーク';

  @override
  String get fileAlreadyExistsMessage => 'ファイルは既に存在します';
}
