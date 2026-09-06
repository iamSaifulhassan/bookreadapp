import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_spacing.dart';

/// The speech-rate/pitch/volume bottom sheet opened from the reading
/// screen's app bar menu. Extracted from book_content_screen.dart; keeps
/// its own modal-local slider state (via StatefulBuilder) but reports every
/// change back to the caller, which owns the actual TTS engine and
/// persisted settings.
class TtsSettingsSheet extends StatefulWidget {
  final double initialSpeechRate;
  final double initialPitch;
  final double initialVolume;
  final ValueChanged<double> onSpeechRateChanged;
  final ValueChanged<double> onPitchChanged;
  final ValueChanged<double> onVolumeChanged;
  final VoidCallback onReset;

  final String title;
  final String Function(String) speechRateLabel;
  final String Function(String) pitchLabel;
  final String Function(String) volumeLabel;
  final String resetButtonLabel;
  final String doneButtonLabel;

  const TtsSettingsSheet({
    super.key,
    required this.initialSpeechRate,
    required this.initialPitch,
    required this.initialVolume,
    required this.onSpeechRateChanged,
    required this.onPitchChanged,
    required this.onVolumeChanged,
    required this.onReset,
    required this.title,
    required this.speechRateLabel,
    required this.pitchLabel,
    required this.volumeLabel,
    required this.resetButtonLabel,
    required this.doneButtonLabel,
  });

  @override
  State<TtsSettingsSheet> createState() => _TtsSettingsSheetState();
}

class _TtsSettingsSheetState extends State<TtsSettingsSheet> {
  late double _speechRate = widget.initialSpeechRate;
  late double _pitch = widget.initialPitch;
  late double _volume = widget.initialVolume;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.settings_voice, color: AppColors.primary),
              const SizedBox(width: 8),
              Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text(widget.speechRateLabel(_speechRate.toStringAsFixed(1))),
          Slider(
            value: _speechRate,
            min: 0.1,
            max: 1.0,
            divisions: 9,
            activeColor: AppColors.primary,
            onChanged: (value) {
              setState(() => _speechRate = value);
              widget.onSpeechRateChanged(value);
            },
          ),

          const SizedBox(height: 16),
          Text(widget.pitchLabel(_pitch.toStringAsFixed(1))),
          Slider(
            value: _pitch,
            min: 0.5,
            max: 2.0,
            divisions: 15,
            activeColor: AppColors.primary,
            onChanged: (value) {
              setState(() => _pitch = value);
              widget.onPitchChanged(value);
            },
          ),

          const SizedBox(height: 16),
          Text(widget.volumeLabel((_volume * 100).round().toString())),
          Slider(
            value: _volume,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            activeColor: AppColors.primary,
            onChanged: (value) {
              setState(() => _volume = value);
              widget.onVolumeChanged(value);
            },
          ),

          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _speechRate = 0.5;
                      _pitch = 1.0;
                      _volume = 0.8;
                    });
                    widget.onReset();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: AppColors.primary,
                  ),
                  child: Text(widget.resetButtonLabel),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(widget.doneButtonLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
