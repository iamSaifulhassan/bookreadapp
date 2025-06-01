import 'package:flutter/material.dart';
import '../themes/AppColors.dart';

class StreakWidget extends StatelessWidget {
  final int streakCount;
  final bool isAboutToExpire;
  final bool isCompleted;
  final double iconSize;
  final double fontSize;

  const StreakWidget({
    super.key,
    required this.streakCount,
    this.isAboutToExpire = false,
    this.isCompleted = false,
    this.iconSize = 16,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (streakCount <= 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getBorderColor(), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fire icon or hourglass for expiring streaks
          Icon(
            isAboutToExpire && !isCompleted
                ? Icons.hourglass_top
                : Icons.local_fire_department,
            size: iconSize,
            color: _getIconColor(),
          ),
          const SizedBox(width: 2),
          Text(
            streakCount.toString(),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: _getTextColor(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    if (isCompleted) {
      return AppColors.success.withOpacity(0.15);
    } else if (isAboutToExpire) {
      return Colors.orange.withOpacity(0.15);
    } else {
      return Colors.red.withOpacity(0.15);
    }
  }

  Color _getBorderColor() {
    if (isCompleted) {
      return AppColors.success.withOpacity(0.3);
    } else if (isAboutToExpire) {
      return Colors.red.withOpacity(0.3);
    } else {
      return Colors.orange.withOpacity(0.3);
    }
  }

  Color _getIconColor() {
    if (isCompleted) {
      return AppColors.success;
    } else if (isAboutToExpire) {
      return Colors.red;
    } else {
      return Colors.orange; // Changed from red to yellow for the flame icon
    }
  }

  Color _getTextColor() {
    if (isCompleted) {
      return AppColors.success;
    } else if (isAboutToExpire) {
      return Colors.red.shade700;
    } else {
      return Colors.orange.shade700;
    }
  }
}
