// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get settingsTitle => '设置';

  @override
  String get resetToDefaultsTooltip => '恢复默认设置';

  @override
  String get settingsResetSuccess => '设置已恢复为默认值';

  @override
  String settingsResetError(String error) {
    return '恢复设置时出错：$error';
  }

  @override
  String settingsLoadError(String error) {
    return '加载设置时出错：$error';
  }

  @override
  String get textToSpeechSection => '文本转语音';

  @override
  String get speechRateLabel => '语速';

  @override
  String get speechRateSubtitle => '文本朗读的速度';

  @override
  String get pitchLabel => '音调';

  @override
  String get pitchSubtitle => '语音音调级别';

  @override
  String get volumeLabel => '音量';

  @override
  String get volumeSubtitle => '播放音量';

  @override
  String get readingExperienceSection => '阅读体验';

  @override
  String get fontSizeLabel => '字体大小';

  @override
  String get fontSizeSubtitle => '阅读文本的大小';

  @override
  String get lineHeightLabel => '行高';

  @override
  String get lineHeightSubtitle => '文本行之间的间距';

  @override
  String get languageSection => '语言';

  @override
  String get languageSubtitle => '选择您的首选语言';

  @override
  String get themeSection => '外观';

  @override
  String get themeSubtitle => '选择 BookRead 的外观';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get commonCancel => '取消';

  @override
  String get commonChange => '更改';

  @override
  String get commonRetry => '重试';

  @override
  String get commonShare => '分享';

  @override
  String get commonOk => '确定';

  @override
  String get myBooksTitle => '我的图书';

  @override
  String get loadingYourBooks => '正在加载您的图书...';

  @override
  String get storageAccessRequiredTitle => '需要存储访问权限';

  @override
  String get storageAccessRequiredBody => '此应用需要存储权限才能访问和管理您的图书文件。';

  @override
  String get storageAccessRequiredHint => '请在设备设置中启用存储权限。';

  @override
  String get openSettingsButton => '打开设置';

  @override
  String get showAsListTooltip => '以列表显示';

  @override
  String get showAsGridTooltip => '以网格显示';

  @override
  String get pickBookFilesTooltip => '选择图书文件';

  @override
  String get booksFolderPathLabel => '图书文件夹路径';

  @override
  String get changeBooksFolderPathTitle => '更改图书文件夹路径';

  @override
  String get selectBooksFolderTitle => '选择图书文件夹';

  @override
  String get browseForFolderTooltip => '浏览文件夹';

  @override
  String get noBooksMessage => '自定义文件夹中没有图书文件，也没有已选择的文件。点击 + 添加文件。';

  @override
  String modifiedLabel(String date) {
    return '修改时间：$date';
  }

  @override
  String get readLaterTooltip => '稍后阅读';

  @override
  String get removeFromListTooltip => '从列表中移除';

  @override
  String get removeFromFavouritesTooltip => '从收藏中移除';

  @override
  String get addToFavouritesTooltip => '添加到收藏';

  @override
  String get removeFromCompletedTooltip => '从已完成中移除';

  @override
  String get markAsCompletedTooltip => '标记为已完成';

  @override
  String get fileAlreadyExistsMessage => '文件已存在';

  @override
  String get signInTitle => '登录';

  @override
  String get emailLabel => '电子邮箱';

  @override
  String get emailHint => '请输入您的电子邮箱';

  @override
  String get emailRequiredError => '电子邮箱为必填项';

  @override
  String get passwordLabel => '密码';

  @override
  String get passwordHint => '请输入您的密码';

  @override
  String get passwordRequiredError => '密码为必填项';

  @override
  String get signInButton => '登录';

  @override
  String get signInSuccessMessage => '登录成功！';

  @override
  String get signInWithGoogleButton => '使用 Google 登录';

  @override
  String get googleSignInSuccessMessage => 'Google 登录成功！';

  @override
  String get googleSignInFailedMessage => 'Google 登录失败。';

  @override
  String get noAccountSignUpPrompt => '还没有账户？立即注册';

  @override
  String get commonOther => '其他';

  @override
  String get phoneNumberLabel => '电话号码';

  @override
  String get phoneNumberHint => '请输入您的电话号码';

  @override
  String get phoneRequiredError => '电话号码为必填项';

  @override
  String get invalidPhoneError => '请输入有效的电话号码';

  @override
  String get invalidEmailError => '请输入有效的电子邮箱地址';

  @override
  String get emailAlreadyExistsFieldError => '该电子邮箱已存在。';

  @override
  String get countryLabel => '国家';

  @override
  String get selectCountryHint => '选择您的国家';

  @override
  String get countryPakistan => '巴基斯坦';

  @override
  String get countryIndia => '印度';

  @override
  String get countryUnitedStates => '美国';

  @override
  String get countryUnitedKingdom => '英国';

  @override
  String get countryCanada => '加拿大';

  @override
  String get countryAustralia => '澳大利亚';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get confirmPasswordHint => '请再次输入密码';

  @override
  String get confirmPasswordRequiredError => '确认密码为必填项';

  @override
  String get passwordsDoNotMatchError => '两次密码不一致';

  @override
  String get passwordTooShortError => '密码长度至少为 6 个字符';

  @override
  String get userTypeLabel => '我是...';

  @override
  String get selectUserTypeHint => '选择您的用户类型';

  @override
  String get userTypeStudent => '学生';

  @override
  String get userTypeTeacher => '教师';

  @override
  String get userTypeProfessional => '专业人士';

  @override
  String get userTypeResearcher => '研究人员';

  @override
  String get signUpButton => '注册';

  @override
  String get signUpSuccessMessage => '注册成功！';

  @override
  String get alreadyHaveAccountSignInPrompt => '已有账户？立即登录';

  @override
  String get profileTitle => '个人资料';

  @override
  String get refreshProfileTooltip => '刷新个人资料';

  @override
  String get loadingProfile => '正在加载个人资料...';

  @override
  String get noPhoneNumber => '无电话号码';

  @override
  String get noCountry => '无国家';

  @override
  String get noUserType => '无用户类型';

  @override
  String get noEmail => '无电子邮箱';

  @override
  String get profileIncompleteMessage => '请添加您的国家、用户类型和电话号码以完善个人资料。';

  @override
  String failedToLoadProfileError(String error) {
    return '加载个人资料数据失败：$error';
  }

  @override
  String errorUpdatingProfileError(String error) {
    return '更新个人资料时出错：$error';
  }

  @override
  String get phoneFieldLabel => '电话';

  @override
  String get phoneFieldHint => '请输入您的电话';

  @override
  String get countryFieldHint => '请输入您的国家';

  @override
  String get userTypeFieldLabel => '用户类型';

  @override
  String get userTypeFieldHint => '请输入用户类型';

  @override
  String get editProfileButton => '编辑资料';

  @override
  String get signOutButton => '退出登录';

  @override
  String get signOutConfirmMessage => '您确定要退出登录吗？';

  @override
  String get tapToChangePhoto => '点击更换个人资料照片';

  @override
  String get profileImageSavedMessage => '个人资料照片保存成功！';

  @override
  String get failedToSaveImageMessage => '保存图片失败，请重试。';

  @override
  String get failedToPickImageMessage => '选择图片失败，请重试。';

  @override
  String get profileUpdatedMessage => '个人资料更新成功！';

  @override
  String get failedToUpdateProfileMessage => '更新个人资料失败，请重试。';

  @override
  String genericErrorMessage(String error) {
    return '错误：$error';
  }

  @override
  String get emailAddressSectionLabel => '电子邮箱地址';

  @override
  String get emailAddressHint => '请输入您的电子邮箱地址';

  @override
  String get pleaseEnterEmailError => '请输入您的电子邮箱地址';

  @override
  String get pleaseEnterValidEmailError => '请输入有效的电子邮箱地址';

  @override
  String get pleaseEnterPhoneError => '请输入您的电话号码';

  @override
  String get updatingButtonLabel => '正在更新...';

  @override
  String get updateProfileButtonLabel => '更新资料';

  @override
  String get downloadsTitle => '下载';

  @override
  String get noDownloadsFound => '未找到下载内容';

  @override
  String errorLoadingDownloads(String error) {
    return '加载下载内容时出错：$error';
  }

  @override
  String get favouritesTitle => '收藏';

  @override
  String get listViewTooltip => '列表视图';

  @override
  String get gridViewTooltip => '网格视图';

  @override
  String get noFavouriteBooksYet => '还没有收藏的图书';

  @override
  String get addBooksToFavouritesHint => '从我的图书屏幕将图书添加到收藏';

  @override
  String get readLaterTitle => '稍后阅读';

  @override
  String get favouriteTooltip => '收藏';

  @override
  String get removeFromReadLaterTooltip => '从稍后阅读中移除';

  @override
  String get noBooksToReadLater => '没有稍后阅读的图书';

  @override
  String get addBooksToReadLaterHint => '从我的图书屏幕添加图书到稍后阅读';

  @override
  String get completedBooksTitle => '已完成的图书';

  @override
  String get completedStatusLabel => '已完成';

  @override
  String get noCompletedBooksYet => '还没有已完成的图书';

  @override
  String get completedBooksHint => '您读完的图书将显示在这里';

  @override
  String get aboutTitle => '关于';

  @override
  String get aboutBio =>
      '一名热衷于打造美观实用应用的 Flutter 开发者。此应用使用 Flutter 和 Firebase 结合本地数据存储构建，展示了移动开发方面的技能。';

  @override
  String get connectWithMeSection => '联系我';

  @override
  String get loadingLabel => '加载中...';

  @override
  String get pleaseWaitLabel => '请稍候...';

  @override
  String get bookReaderLabel => '读书者';

  @override
  String get userLabel => '用户';

  @override
  String get logoutNav => '退出登录';

  @override
  String ttsErrorMessage(String message) {
    return '语音错误：$message';
  }

  @override
  String ttsControlErrorMessage(String error) {
    return '控制语音时出错：$error';
  }

  @override
  String ttsSpeakErrorMessage(String error) {
    return '朗读句子时出错：$error';
  }

  @override
  String pageBookmarkedMessage(int page) {
    return '已将第 $page 页添加书签';
  }

  @override
  String get bookmarkRemovedMessage => '书签已移除';

  @override
  String get noBookmarksYetMessage => '还没有书签';

  @override
  String get bookmarksDialogTitle => '书签';

  @override
  String pageLabel(int page) {
    return '第 $page 页';
  }

  @override
  String get closeButton => '关闭';

  @override
  String snapshotFailedMessage(String error) {
    return '截图失败：$error';
  }

  @override
  String snapshotSaveFailedMessage(String error) {
    return '保存截图失败：$error';
  }

  @override
  String get snapshotSavedTitle => '截图已保存';

  @override
  String get snapshotSavedBody => '截图已成功保存！';

  @override
  String get locationLabel => '位置：';

  @override
  String get goToPageTitle => '跳转到页面';

  @override
  String pageNumberLabel(int total) {
    return '页码（1-$total）';
  }

  @override
  String get invalidPageNumberMessage => '无效的页码';

  @override
  String get goButton => '跳转';

  @override
  String get toggleTextBufferTooltip => '切换文本缓冲区';

  @override
  String get ttsSettingsMenuItem => '语音设置';

  @override
  String get reloadMenuItem => '重新加载';

  @override
  String loadingFileMessage(String fileName) {
    return '正在加载 $fileName...';
  }

  @override
  String get initializingViewerMessage => '正在初始化 PDF 阅读器和语音引擎';

  @override
  String get failedToLoadContentTitle => '内容加载失败';

  @override
  String get unknownErrorMessage => '发生未知错误';

  @override
  String get readingBufferLabel => '阅读缓冲区';

  @override
  String get noSentencesAvailableMessage => '没有可用的句子';

  @override
  String get sentenceStatusRead => '已读';

  @override
  String get sentenceStatusCurrent => '当前';

  @override
  String get sentenceStatusNext => '下一个';

  @override
  String get pausedLabel => '已暂停';

  @override
  String get playingLabel => '正在播放';

  @override
  String get previousSentenceTooltip => '上一句';

  @override
  String get resumeTooltip => '继续';

  @override
  String get pauseTooltip => '暂停';

  @override
  String get playTooltip => '播放';

  @override
  String get stopTooltip => '停止';

  @override
  String get nextSentenceTooltip => '下一句';

  @override
  String get ttsSettingsSheetTitle => '语音设置';

  @override
  String speechRateWithValue(String value) {
    return '语速：$value';
  }

  @override
  String pitchWithValue(String value) {
    return '音调：$value';
  }

  @override
  String volumeWithValue(String value) {
    return '音量：$value%';
  }

  @override
  String get resetToDefaultButton => '恢复默认值';

  @override
  String get doneButton => '完成';

  @override
  String get zoomInLabel => '放大';

  @override
  String get zoomOutLabel => '缩小';

  @override
  String get resetLabel => '重置';

  @override
  String get bookmarkLabel => '书签';

  @override
  String get snapshotLabel => '截图';

  @override
  String get goToPageLabel => '跳转到页面';

  @override
  String get moreLabel => '更多';

  @override
  String pageOfPagesLabel(int current, int total) {
    return '第 $current 页，共 $total 页';
  }

  @override
  String get unableToExtractTextMessage => '无法从此页面提取文本。';

  @override
  String get noReadableTextMessage => '未找到可读文本。';

  @override
  String get noSentencesFoundMessage => '未找到句子。';

  @override
  String get unsupportedFileFormatMessage => '不支持的文件格式。仅支持 PDF 和 TXT 文件。';

  @override
  String get subscriptionTitle => 'BookRead 高级版';

  @override
  String get subscriptionUnlockPremium => '解锁完整的 BookRead 体验';

  @override
  String get subscriptionRestoreButton => '恢复购买';

  @override
  String get subscriptionPurchaseSuccessMessage => '订阅已激活。尽享 BookRead 高级版！';

  @override
  String get subscriptionPurchaseCancelledMessage => '购买已取消。';

  @override
  String subscriptionPurchaseFailedMessage(String error) {
    return '购买失败：$error';
  }

  @override
  String get subscriptionAlreadyActiveMessage => '您已订阅 BookRead 高级版。';

  @override
  String get subscriptionNoOfferingsMessage => '订阅暂不可用，请稍后重试。';

  @override
  String get subscriptionRestoreSuccessMessage => '您的购买已恢复。';

  @override
  String subscriptionRestoreFailedMessage(String error) {
    return '恢复失败：$error';
  }

  @override
  String get subscriptionSubscribeButton => '订阅';

  @override
  String get premiumNav => '升级到高级版';
}
