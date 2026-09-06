class SettingsState {
  final bool isLoading;
  final double ttsSpeechRate;
  final double ttsPitch;
  final double ttsVolume;
  final double readingFontSize;
  final double readingLineHeight;

  /// Set only when the initial load (triggered from the cubit's
  /// constructor, so nothing in the widget can wrap it in a try/catch)
  /// fails. The widget shows this once via a BlocListener, then the cubit
  /// clears it — explicit user actions (changing a slider, resetting)
  /// instead let their own exceptions propagate to the calling widget.
  final String? loadError;

  const SettingsState({
    required this.isLoading,
    required this.ttsSpeechRate,
    required this.ttsPitch,
    required this.ttsVolume,
    required this.readingFontSize,
    required this.readingLineHeight,
    this.loadError,
  });

  const SettingsState.initial()
    : isLoading = true,
      ttsSpeechRate = 0.5,
      ttsPitch = 1.0,
      ttsVolume = 0.8,
      readingFontSize = 16.0,
      readingLineHeight = 1.5,
      loadError = null;

  SettingsState copyWith({
    bool? isLoading,
    double? ttsSpeechRate,
    double? ttsPitch,
    double? ttsVolume,
    double? readingFontSize,
    double? readingLineHeight,
    String? loadError,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      ttsSpeechRate: ttsSpeechRate ?? this.ttsSpeechRate,
      ttsPitch: ttsPitch ?? this.ttsPitch,
      ttsVolume: ttsVolume ?? this.ttsVolume,
      readingFontSize: readingFontSize ?? this.readingFontSize,
      readingLineHeight: readingLineHeight ?? this.readingLineHeight,
      loadError: loadError,
    );
  }
}
