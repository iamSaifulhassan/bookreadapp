import 'package:flutter/material.dart';
import '../../themes/AppColors.dart';
import '../../widgets/custom_drawer.dart';
import '../../services/settings_service.dart';

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

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error loading settings: $e');
    }
  }

  Future<void> _resetSettings() async {
    try {
      await _settingsService.resetToDefaults();
      await _loadSettings(); // Reload settings
      _showSnackBar('Settings reset to defaults');
    } catch (e) {
      _showSnackBar('Error resetting settings: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetSettings,
            tooltip: 'Reset to defaults',
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildTTSSettings(),
                  const SizedBox(height: 24),
                  _buildReadingSettings(),
                ],
              ),
    );
  }

  Widget _buildTTSSettings() {
    return _buildSettingsCard(
      title: 'Text-to-Speech',
      icon: Icons.volume_up,
      children: [
        _buildSliderSetting(
          title: 'Speech Rate',
          subtitle: 'How fast the text is spoken',
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
          title: 'Pitch',
          subtitle: 'Voice pitch level',
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
          title: 'Volume',
          subtitle: 'Playback volume',
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

  Widget _buildReadingSettings() {
    return _buildSettingsCard(
      title: 'Reading Experience',
      icon: Icons.text_fields,
      children: [
        _buildSliderSetting(
          title: 'Font Size',
          subtitle: 'Text size for reading',
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
          title: 'Line Height',
          subtitle: 'Space between lines of text',
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
            Row(              children: [
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
