import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/settings_service.dart';
import 'settings_state.dart';

/// Owns the TTS (speech rate/pitch/volume) and reading (font size/line
/// height) settings previously managed via raw setState calls directly in
/// settings_screen.dart. Theme and locale keep their own ValueNotifier-based
/// services (ThemeService/LocaleService) — those were already a clean
/// reactive pattern, not a setState anti-pattern, so they're left as-is.
///
/// Methods here persist first, then emit — if persistence throws, the
/// exception propagates to the caller (the screen) to show an error message,
/// and the in-memory state is left unchanged rather than silently drifting
/// from what's actually saved.
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsService _settingsService;

  SettingsCubit(this._settingsService) : super(const SettingsState.initial()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final speechRate = await _settingsService.getTTSSpeechRate();
      final pitch = await _settingsService.getTTSPitch();
      final volume = await _settingsService.getTTSVolume();
      final fontSize = await _settingsService.getReadingFontSize();
      final lineHeight = await _settingsService.getReadingLineHeight();
      emit(
        state.copyWith(
          isLoading: false,
          ttsSpeechRate: speechRate,
          ttsPitch: pitch,
          ttsVolume: volume,
          readingFontSize: fontSize,
          readingLineHeight: lineHeight,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, loadError: e.toString()));
    }
  }

  Future<void> setSpeechRate(double value) async {
    await _settingsService.setTTSSpeechRate(value);
    emit(state.copyWith(ttsSpeechRate: value));
  }

  Future<void> setPitch(double value) async {
    await _settingsService.setTTSPitch(value);
    emit(state.copyWith(ttsPitch: value));
  }

  Future<void> setVolume(double value) async {
    await _settingsService.setTTSVolume(value);
    emit(state.copyWith(ttsVolume: value));
  }

  Future<void> setReadingFontSize(double value) async {
    await _settingsService.setReadingFontSize(value);
    emit(state.copyWith(readingFontSize: value));
  }

  Future<void> setReadingLineHeight(double value) async {
    await _settingsService.setReadingLineHeight(value);
    emit(state.copyWith(readingLineHeight: value));
  }

  Future<void> resetToDefaults() async {
    await _settingsService.resetToDefaults();
    await _load();
  }
}
