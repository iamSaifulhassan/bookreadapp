import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

/// The play/pause/stop/skip bar fixed above the bottom document controls.
/// Extracted from book_content_screen.dart's build methods so that screen
/// only owns state and orchestration, not every widget's layout.
class TtsControlsBar extends StatelessWidget {
  final Animation<double> opacity;
  final bool hasSentences;
  final bool canGoPrevious;
  final bool canGoNext;
  final bool isPlaying;
  final bool isPaused;
  final String previousTooltip;
  final String playTooltip;
  final String pauseTooltip;
  final String resumeTooltip;
  final String stopTooltip;
  final String nextTooltip;
  final VoidCallback onPrevious;
  final VoidCallback onTogglePlayPause;
  final VoidCallback onStop;
  final VoidCallback onNext;

  const TtsControlsBar({
    super.key,
    required this.opacity,
    required this.hasSentences,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.isPlaying,
    required this.isPaused,
    required this.previousTooltip,
    required this.playTooltip,
    required this.pauseTooltip,
    required this.resumeTooltip,
    required this.stopTooltip,
    required this.nextTooltip,
    required this.onPrevious,
    required this.onTogglePlayPause,
    required this.onStop,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TtsButton(
              icon: Icons.skip_previous,
              onPressed: hasSentences && canGoPrevious ? onPrevious : null,
              tooltip: previousTooltip,
            ),
            _TtsButton(
              icon:
                  isPlaying
                      ? (isPaused ? Icons.play_arrow : Icons.pause)
                      : Icons.play_arrow,
              onPressed: hasSentences ? onTogglePlayPause : null,
              tooltip: isPlaying ? (isPaused ? resumeTooltip : pauseTooltip) : playTooltip,
              isPrimary: true,
            ),
            _TtsButton(
              icon: Icons.stop,
              onPressed: isPlaying ? onStop : null,
              tooltip: stopTooltip,
            ),
            _TtsButton(
              icon: Icons.skip_next,
              onPressed: hasSentences && canGoNext ? onNext : null,
              tooltip: nextTooltip,
            ),
          ],
        ),
      ),
    );
  }
}

class _TtsButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final bool isPrimary;

  const _TtsButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: isPrimary ? 56 : 48,
            height: isPrimary ? 56 : 48,
            decoration: BoxDecoration(
              color:
                  isPrimary
                      ? AppColors.primary
                      : (onPressed != null
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : Theme.of(context).colorScheme.surfaceContainerHighest),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: isPrimary ? 28 : 24,
              color:
                  isPrimary
                      ? Theme.of(context).colorScheme.onPrimary
                      : (onPressed != null
                          ? AppColors.primary
                          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38)),
            ),
          ),
        ),
      ),
    );
  }
}
