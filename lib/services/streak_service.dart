import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentStreak {
  final String filePath;
  final int streakCount;
  final DateTime lastOpened;
  final bool isCompleted; // Fixed streak for completed books
  final DateTime? completedAt; // When book was marked as completed

  DocumentStreak({
    required this.filePath,
    required this.streakCount,
    required this.lastOpened,
    this.isCompleted = false,
    this.completedAt,
  });

  Map<String, dynamic> toJson() => {
    'filePath': filePath,
    'streakCount': streakCount,
    'lastOpened': lastOpened.millisecondsSinceEpoch,
    'isCompleted': isCompleted,
    'completedAt': completedAt?.millisecondsSinceEpoch,
  };

  factory DocumentStreak.fromJson(Map<String, dynamic> json) => DocumentStreak(
    filePath: json['filePath'],
    streakCount: json['streakCount'],
    lastOpened: DateTime.fromMillisecondsSinceEpoch(json['lastOpened']),
    isCompleted: json['isCompleted'] ?? false,
    completedAt:
        json['completedAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['completedAt'])
            : null,
  );

  DocumentStreak copyWith({
    String? filePath,
    int? streakCount,
    DateTime? lastOpened,
    bool? isCompleted,
    DateTime? completedAt,
  }) => DocumentStreak(
    filePath: filePath ?? this.filePath,
    streakCount: streakCount ?? this.streakCount,
    lastOpened: lastOpened ?? this.lastOpened,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt ?? this.completedAt,
  );
}

class StreakService {
  static const String _streaksPrefKey = 'document_streaks';
  static const Duration _streakWindow = Duration(hours: 24);
  static const Duration _warningWindow = Duration(hours: 3);
  static bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static StreakService? _instance;
  factory StreakService() => _instance ??= StreakService._internal();
  StreakService._internal();

  Map<String, DocumentStreak> _streaks = {};
  bool _isLoaded = false;

  /// Load streaks from SharedPreferences
  Future<void> loadStreaks() async {
    if (_isLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final streaksJson = prefs.getString(_streaksPrefKey);

    if (streaksJson != null) {
      final Map<String, dynamic> streaksMap = jsonDecode(streaksJson);
      _streaks = streaksMap.map(
        (key, value) => MapEntry(key, DocumentStreak.fromJson(value)),
      );
    }

    _isLoaded = true;
  }

  /// Save streaks to SharedPreferences
  Future<void> _saveStreaks() async {
    final prefs = await SharedPreferences.getInstance();
    final streaksMap = _streaks.map(
      (key, value) => MapEntry(key, value.toJson()),
    );
    await prefs.setString(_streaksPrefKey, jsonEncode(streaksMap));
  }

  /// Record that a document was opened
  Future<void> recordDocumentOpened(String filePath) async {
    await loadStreaks();

    final now = DateTime.now();
    final existingStreak = _streaks[filePath];

    if (existingStreak == null) {
      // First time opening this document
      _streaks[filePath] = DocumentStreak(
        filePath: filePath,
        streakCount: 1,
        lastOpened: now,
      );
    } else if (existingStreak.isCompleted) {
      // Document is completed, don't change the streak but update last opened
      _streaks[filePath] = existingStreak.copyWith(lastOpened: now);
    } else {
      // Check if opened on the same day
      if (_isSameDay(existingStreak.lastOpened, now)) {
        // Same day: only update lastOpened time, don't increment streak
        _streaks[filePath] = existingStreak.copyWith(lastOpened: now);
      } else {
        // Different day: check if streak should continue or reset
        final timeSinceLastOpened = now.difference(existingStreak.lastOpened);

        if (timeSinceLastOpened <= _streakWindow) {
          // Continue streak
          _streaks[filePath] = existingStreak.copyWith(
            streakCount: existingStreak.streakCount + 1,
            lastOpened: now,
          );
        } else {
          // Streak expired, restart
          _streaks[filePath] = existingStreak.copyWith(
            streakCount: 1,
            lastOpened: now,
          );
        }
      }
    }

    await _saveStreaks();
  }

  /// Mark a document as completed (fixes the streak)
  Future<void> markDocumentCompleted(String filePath) async {
    await loadStreaks();

    final existingStreak = _streaks[filePath];
    if (existingStreak != null && !existingStreak.isCompleted) {
      _streaks[filePath] = existingStreak.copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );
      await _saveStreaks();
    }
  }

  /// Mark a document as not completed (unfixes the streak)
  Future<void> markDocumentNotCompleted(String filePath) async {
    await loadStreaks();

    final existingStreak = _streaks[filePath];
    if (existingStreak != null && existingStreak.isCompleted) {
      _streaks[filePath] = existingStreak.copyWith(
        isCompleted: false,
        completedAt: null,
      );
      await _saveStreaks();
    }
  }

  /// Get streak for a specific document
  DocumentStreak? getStreak(String filePath) {
    return _streaks[filePath];
  }

  /// Get current valid streak count for a document
  int getCurrentStreakCount(String filePath) {
    final streak = _streaks[filePath];
    if (streak == null) return 0;

    // If completed, always return the fixed streak
    if (streak.isCompleted) return streak.streakCount;

    // Check if streak is still valid
    final now = DateTime.now();
    final timeSinceLastOpened = now.difference(streak.lastOpened);

    if (timeSinceLastOpened <= _streakWindow) {
      return streak.streakCount;
    } else {
      // Streak has expired
      return 0;
    }
  }

  /// Check if streak is about to expire (within 3 hours)
  bool isStreakAboutToExpire(String filePath) {
    final streak = _streaks[filePath];
    if (streak == null || streak.isCompleted) return false;

    final now = DateTime.now();
    final timeSinceLastOpened = now.difference(streak.lastOpened);
    final timeUntilExpiry = _streakWindow - timeSinceLastOpened;

    return timeUntilExpiry <= _warningWindow && timeUntilExpiry > Duration.zero;
  }

  /// Get all documents with active streaks
  Map<String, DocumentStreak> getAllActiveStreaks() {
    final now = DateTime.now();
    return Map.fromEntries(
      _streaks.entries.where((entry) {
        final streak = entry.value;
        if (streak.isCompleted) return true; // Always show completed streaks

        final timeSinceLastOpened = now.difference(streak.lastOpened);
        return timeSinceLastOpened <= _streakWindow;
      }),
    );
  }

  /// Clean up expired streaks (optional housekeeping)
  Future<void> cleanupExpiredStreaks() async {
    await loadStreaks();

    final now = DateTime.now();
    final activeStreaks = <String, DocumentStreak>{};

    for (final entry in _streaks.entries) {
      final streak = entry.value;
      if (streak.isCompleted) {
        // Keep completed streaks
        activeStreaks[entry.key] = streak;
      } else {
        final timeSinceLastOpened = now.difference(streak.lastOpened);
        if (timeSinceLastOpened <= _streakWindow) {
          // Keep active streaks
          activeStreaks[entry.key] = streak;
        }
        // Skip expired streaks (removes them)
      }
    }

    _streaks = activeStreaks;
    await _saveStreaks();
  }
}
