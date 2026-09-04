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
}
