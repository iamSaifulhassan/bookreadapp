import 'package:flutter/material.dart';
import '../../themes/AppColors.dart';
import '../../widgets/custom_drawer.dart';
import '../../services/settings_service.dart';
import '../../services/locale_service.dart';
import '../../services/theme_service.dart';
import '../../l10n/generated/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = SettingsService();
  bool _isLoading = true;

  // TTS Settings
  double _ttsSpeechRate = 0.5;
  double _ttsPitch = 1.0;
  double _ttsVolume = 0.8;

  // Reading Settings
  double _readingFontSize = 16.0;
  double _readingLineHeight = 1.5;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      // Load TTS settings
      _ttsSpeechRate = await _settingsService.getTTSSpeechRate();
      _ttsPitch = await _settingsService.getTTSPitch();
      _ttsVolume = await _settingsService.getTTSVolume();

      // Load Reading settings
      _readingFontSize = await _settingsService.getReadingFontSize();
      _readingLineHeight = await _settingsService.getReadingLineHeight();

      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _showSnackBar(AppLocalizations.of(context)!.settingsLoadError(e.toString()));
    }
  }

  Future<void> _resetSettings() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await _settingsService.resetToDefaults();
      await _loadSettings(); // Reload settings
      if (!mounted) return;
      _showSnackBar(l10n.settingsResetSuccess);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(l10n.settingsResetError(e.toString()));
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetSettings,
            tooltip: l10n.resetToDefaultsTooltip,
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child:
            _isLoading
                ? const Center(
                  key: ValueKey('loading'),
                  child: CircularProgressIndicator(),
                )
                : ListView(
                  key: const ValueKey('loaded'),
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildThemeSettings(l10n),
                    const SizedBox(height: 24),
                    _buildLanguageSettings(l10n),
                    const SizedBox(height: 24),
                    _buildTTSSettings(l10n),
                    const SizedBox(height: 24),
                    _buildReadingSettings(l10n),
                  ],
                ),
      ),
    );
  }

  Widget _buildThemeSettings(AppLocalizations l10n) {
    return _buildSettingsCard(
      title: l10n.themeSection,
      icon: Icons.palette_outlined,
      children: [
        Text(
          l10n.themeSubtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeService().themeMode,
          builder: (context, mode, _) {
            return SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: const Icon(Icons.light_mode_outlined),
                  label: Text(l10n.themeLight),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: const Icon(Icons.dark_mode_outlined),
                  label: Text(l10n.themeDark),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: const Icon(Icons.brightness_auto_outlined),
                  label: Text(l10n.themeSystem),
                ),
              ],
              selected: {mode},
              onSelectionChanged: (selection) {
                ThemeService().setThemeMode(selection.first);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildLanguageSettings(AppLocalizations l10n) {
    return _buildSettingsCard(
      title: l10n.languageSection,
      icon: Icons.language,
      children: [
        Text(
          l10n.languageSubtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<Locale?>(
          valueListenable: LocaleService().currentLocale,
          builder: (context, currentLocale, _) {
            final effectiveCode =
                currentLocale?.languageCode ??
                Localizations.localeOf(context).languageCode;
            return DropdownButtonFormField<String>(
              initialValue: effectiveCode,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items:
                  kSupportedLocales
                      .map(
                        (sl) => DropdownMenuItem(
                          value: sl.locale.languageCode,
                          child: Text(sl.nativeName),
                        ),
                      )
                      .toList(),
              onChanged: (code) {
                if (code != null) {
                  LocaleService().setLocale(Locale(code));
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTTSSettings(AppLocalizations l10n) {
    return _buildSettingsCard(
      title: l10n.textToSpeechSection,
      icon: Icons.volume_up,
      children: [
        _buildSliderSetting(
          title: l10n.speechRateLabel,
          subtitle: l10n.speechRateSubtitle,
          value: _ttsSpeechRate,
          min: 0.1,
          max: 1.0,
          divisions: 18,
          onChanged: (value) async {
            setState(() => _ttsSpeechRate = value);
            await _settingsService.setTTSSpeechRate(value);
          },
        ),
        _buildSliderSetting(
          title: l10n.pitchLabel,
          subtitle: l10n.pitchSubtitle,
          value: _ttsPitch,
          min: 0.5,
          max: 2.0,
          divisions: 15,
          onChanged: (value) async {
            setState(() => _ttsPitch = value);
            await _settingsService.setTTSPitch(value);
          },
        ),
        _buildSliderSetting(
          title: l10n.volumeLabel,
          subtitle: l10n.volumeSubtitle,
          value: _ttsVolume,
          min: 0.1,
          max: 1.0,
          divisions: 9,
          onChanged: (value) async {
            setState(() => _ttsVolume = value);
            await _settingsService.setTTSVolume(value);
          },
        ),
      ],
    );
  }

  Widget _buildReadingSettings(AppLocalizations l10n) {
    return _buildSettingsCard(
      title: l10n.readingExperienceSection,
      icon: Icons.text_fields,
      children: [
        _buildSliderSetting(
          title: l10n.fontSizeLabel,
          subtitle: l10n.fontSizeSubtitle,
          value: _readingFontSize,
          min: 12.0,
          max: 24.0,
          divisions: 12,
          onChanged: (value) async {
            setState(() => _readingFontSize = value);
            await _settingsService.setReadingFontSize(value);
          },
        ),
        _buildSliderSetting(
          title: l10n.lineHeightLabel,
          subtitle: l10n.lineHeightSubtitle,
          value: _readingLineHeight,
          min: 1.0,
          max: 2.5,
          divisions: 15,
          onChanged: (value) async {
            setState(() => _readingLineHeight = value);
            await _settingsService.setReadingLineHeight(value);
          },
        ),
      ],
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSetting({
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: value.toStringAsFixed(2),
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
