import 'package:flutter/foundation.dart';

/// Thin logging wrapper so debug output never ships in release builds.
/// Use in place of `print()`.
class AppLogger {
  const AppLogger._();

  static void log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('$message${error != null ? ': $error' : ''}');
      if (stackTrace != null) {
        debugPrint(stackTrace.toString());
      }
    }
  }
}
