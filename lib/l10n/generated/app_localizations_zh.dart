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
}
