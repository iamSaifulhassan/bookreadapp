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
  String get themeSection => '外観';

  @override
  String get themeSubtitle => 'BookRead の見た目を選択してください';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeSystem => 'システム';

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

  @override
  String get signInTitle => 'サインイン';

  @override
  String get emailLabel => 'メールアドレス';

  @override
  String get emailHint => 'メールアドレスを入力してください';

  @override
  String get emailRequiredError => 'メールアドレスは必須です';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get passwordHint => 'パスワードを入力してください';

  @override
  String get passwordRequiredError => 'パスワードは必須です';

  @override
  String get signInButton => 'サインイン';

  @override
  String get signInSuccessMessage => 'サインインに成功しました！';

  @override
  String get signInWithGoogleButton => 'Googleでサインイン';

  @override
  String get googleSignInSuccessMessage => 'Googleサインインに成功しました！';

  @override
  String get googleSignInFailedMessage => 'Googleサインインに失敗しました。';

  @override
  String get noAccountSignUpPrompt => 'アカウントをお持ちでないですか？新規登録';

  @override
  String get commonOther => 'その他';

  @override
  String get phoneNumberLabel => '電話番号';

  @override
  String get phoneNumberHint => '電話番号を入力してください';

  @override
  String get phoneRequiredError => '電話番号は必須です';

  @override
  String get invalidPhoneError => '有効な電話番号を入力してください';

  @override
  String get invalidEmailError => '有効なメールアドレスを入力してください';

  @override
  String get emailAlreadyExistsFieldError => 'このメールアドレスは既に登録されています。';

  @override
  String get countryLabel => '国';

  @override
  String get selectCountryHint => '国を選択してください';

  @override
  String get countryPakistan => 'パキスタン';

  @override
  String get countryIndia => 'インド';

  @override
  String get countryUnitedStates => 'アメリカ合衆国';

  @override
  String get countryUnitedKingdom => 'イギリス';

  @override
  String get countryCanada => 'カナダ';

  @override
  String get countryAustralia => 'オーストラリア';

  @override
  String get confirmPasswordLabel => 'パスワードの確認';

  @override
  String get confirmPasswordHint => 'パスワードを再入力してください';

  @override
  String get confirmPasswordRequiredError => 'パスワードの確認は必須です';

  @override
  String get passwordsDoNotMatchError => 'パスワードが一致しません';

  @override
  String get passwordTooShortError => 'パスワードは6文字以上で入力してください';

  @override
  String get userTypeLabel => '私は...';

  @override
  String get selectUserTypeHint => 'ユーザータイプを選択してください';

  @override
  String get userTypeStudent => '学生';

  @override
  String get userTypeTeacher => '教師';

  @override
  String get userTypeProfessional => '社会人';

  @override
  String get userTypeResearcher => '研究者';

  @override
  String get signUpButton => '新規登録';

  @override
  String get signUpSuccessMessage => '登録に成功しました！';

  @override
  String get alreadyHaveAccountSignInPrompt => '既にアカウントをお持ちですか？サインイン';

  @override
  String get profileTitle => 'プロフィール';

  @override
  String get refreshProfileTooltip => 'プロフィールを更新';

  @override
  String get loadingProfile => 'プロフィールを読み込んでいます...';

  @override
  String get noPhoneNumber => '電話番号なし';

  @override
  String get noCountry => '国なし';

  @override
  String get noUserType => 'ユーザータイプなし';

  @override
  String get noEmail => 'メールアドレスなし';

  @override
  String get profileIncompleteMessage => '国、ユーザータイプ、電話番号を追加してプロフィールを完成させてください。';

  @override
  String failedToLoadProfileError(String error) {
    return 'プロフィールデータの読み込みに失敗しました: $error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return 'プロフィールの更新中にエラーが発生しました: $error';
  }

  @override
  String get phoneFieldLabel => '電話番号';

  @override
  String get phoneFieldHint => '電話番号を入力してください';

  @override
  String get countryFieldHint => '国を入力してください';

  @override
  String get userTypeFieldLabel => 'ユーザータイプ';

  @override
  String get userTypeFieldHint => 'ユーザータイプを入力してください';

  @override
  String get editProfileButton => 'プロフィールを編集';

  @override
  String get signOutButton => 'サインアウト';

  @override
  String get signOutConfirmMessage => '本当にサインアウトしますか？';

  @override
  String get tapToChangePhoto => 'タップしてプロフィール写真を変更';

  @override
  String get profileImageSavedMessage => 'プロフィール画像を保存しました！';

  @override
  String get failedToSaveImageMessage => '画像の保存に失敗しました。もう一度お試しください。';

  @override
  String get failedToPickImageMessage => '画像の選択に失敗しました。もう一度お試しください。';

  @override
  String get profileUpdatedMessage => 'プロフィールを更新しました！';

  @override
  String get failedToUpdateProfileMessage => 'プロフィールの更新に失敗しました。もう一度お試しください。';

  @override
  String genericErrorMessage(String error) {
    return 'エラー: $error';
  }

  @override
  String get emailAddressSectionLabel => 'メールアドレス';

  @override
  String get emailAddressHint => 'メールアドレスを入力してください';

  @override
  String get pleaseEnterEmailError => 'メールアドレスを入力してください';

  @override
  String get pleaseEnterValidEmailError => '有効なメールアドレスを入力してください';

  @override
  String get pleaseEnterPhoneError => '電話番号を入力してください';

  @override
  String get updatingButtonLabel => '更新中...';

  @override
  String get updateProfileButtonLabel => 'プロフィールを更新';

  @override
  String get downloadsTitle => 'ダウンロード';

  @override
  String get noDownloadsFound => 'ダウンロードが見つかりません';

  @override
  String errorLoadingDownloads(String error) {
    return 'ダウンロードの読み込み中にエラーが発生しました: $error';
  }

  @override
  String get favouritesTitle => 'お気に入り';

  @override
  String get listViewTooltip => 'リスト表示';

  @override
  String get gridViewTooltip => 'グリッド表示';

  @override
  String get noFavouriteBooksYet => 'お気に入りの本はまだありません';

  @override
  String get addBooksToFavouritesHint => 'マイブック画面から本をお気に入りに追加してください';

  @override
  String get readLaterTitle => '後で読む';

  @override
  String get favouriteTooltip => 'お気に入り';

  @override
  String get removeFromReadLaterTooltip => '後で読むから削除';

  @override
  String get noBooksToReadLater => '後で読む本がありません';

  @override
  String get addBooksToReadLaterHint => 'マイブック画面から本を後で読むに追加してください';

  @override
  String get completedBooksTitle => '読了した本';

  @override
  String get completedStatusLabel => '読了';

  @override
  String get noCompletedBooksYet => '読了した本はまだありません';

  @override
  String get completedBooksHint => '読み終えた本がここに表示されます';

  @override
  String get aboutTitle => 'アプリについて';

  @override
  String get aboutBio =>
      '美しく機能的なアプリケーションの作成に情熱を注ぐFlutter開発者です。このアプリはFlutterとFirebaseをローカルデータストレージと組み合わせて構築されており、モバイル開発のスキルを示しています。';

  @override
  String get connectWithMeSection => 'つながる';
}
