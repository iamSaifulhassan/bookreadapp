import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_cubit.dart';
import '../../blocs/settings/settings_state.dart';
import '../../themes/app_colors.dart';
import '../../widgets/custom_drawer.dart';
import '../../services/settings_service.dart';
import '../../services/locale_service.dart';
import '../../services/theme_service.dart';
import '../../l10n/generated/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(SettingsService()),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  Future<void> _resetSettings(BuildContext context, AppLocalizations l10n) async {
    try {
      await context.read<SettingsCubit>().resetToDefaults();
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.settingsResetSuccess)));
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsResetError(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetSettings(context, l10n),
            tooltip: l10n.resetToDefaultsTooltip,
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state.loadError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.settingsLoadError(state.loadError!)),
              ),
            );
          }
        },
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child:
                state.isLoading
                    ? const Center(
                      key: ValueKey('loading'),
                      child: CircularProgressIndicator(),
                    )
                    : ListView(
                      key: const ValueKey('loaded'),
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildThemeSettings(context, l10n),
                        const SizedBox(height: 24),
                        _buildLanguageSettings(context, l10n),
                        const SizedBox(height: 24),
                        _buildTTSSettings(context, l10n, state),
                        const SizedBox(height: 24),
                        _buildReadingSettings(context, l10n, state),
                      ],
                    ),
          );
        },
      ),
    );
  }

  Widget _buildThemeSettings(BuildContext context, AppLocalizations l10n) {
    return _buildSettingsCard(
      context: context,
      title: l10n.themeSection,
      icon: Icons.palette_outlined,
      children: [
        Text(
          l10n.themeSubtitle,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
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

  Widget _buildLanguageSettings(BuildContext context, AppLocalizations l10n) {
    return _buildSettingsCard(
      context: context,
      title: l10n.languageSection,
      icon: Icons.language,
      children: [
        Text(
          l10n.languageSubtitle,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
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

  Widget _buildTTSSettings(
    BuildContext context,
    AppLocalizations l10n,
    SettingsState state,
  ) {
    final cubit = context.read<SettingsCubit>();
    return _buildSettingsCard(
      context: context,
      title: l10n.textToSpeechSection,
      icon: Icons.volume_up,
      children: [
        _buildSliderSetting(
          context: context,
          title: l10n.speechRateLabel,
          subtitle: l10n.speechRateSubtitle,
          value: state.ttsSpeechRate,
          min: 0.1,
          max: 1.0,
          divisions: 18,
          onChanged: cubit.setSpeechRate,
        ),
        _buildSliderSetting(
          context: context,
          title: l10n.pitchLabel,
          subtitle: l10n.pitchSubtitle,
          value: state.ttsPitch,
          min: 0.5,
          max: 2.0,
          divisions: 15,
          onChanged: cubit.setPitch,
        ),
        _buildSliderSetting(
          context: context,
          title: l10n.volumeLabel,
          subtitle: l10n.volumeSubtitle,
          value: state.ttsVolume,
          min: 0.1,
          max: 1.0,
          divisions: 9,
          onChanged: cubit.setVolume,
        ),
      ],
    );
  }

  Widget _buildReadingSettings(
    BuildContext context,
    AppLocalizations l10n,
    SettingsState state,
  ) {
    final cubit = context.read<SettingsCubit>();
    return _buildSettingsCard(
      context: context,
      title: l10n.readingExperienceSection,
      icon: Icons.text_fields,
      children: [
        _buildSliderSetting(
          context: context,
          title: l10n.fontSizeLabel,
          subtitle: l10n.fontSizeSubtitle,
          value: state.readingFontSize,
          min: 12.0,
          max: 24.0,
          divisions: 12,
          onChanged: cubit.setReadingFontSize,
        ),
        _buildSliderSetting(
          context: context,
          title: l10n.lineHeightLabel,
          subtitle: l10n.lineHeightSubtitle,
          value: state.readingLineHeight,
          min: 1.0,
          max: 2.5,
          divisions: 15,
          onChanged: cubit.setReadingLineHeight,
        ),
      ],
    );
  }

  Widget _buildSettingsCard({
    required BuildContext context,
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
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
    required BuildContext context,
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Future<void> Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
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
