import 'package:shared_preferences/shared_preferences.dart';

/// The three ways a book can be flagged in the library. Membership in each
/// is tracked independently — a book can be a favourite, saved for later,
/// and marked completed all at once.
enum BookListType { favourites, readLater, completed }

/// Persists membership for each [BookListType] to SharedPreferences.
///
/// Previously each of the favourites/to-read/completed screens duplicated
/// this exact persistence logic (same three pref keys, same load/save
/// pattern) independently. Centralizing it here means there's one place
/// that knows how book-list membership is stored.
class BookListRepository {
  static const Map<BookListType, String> _prefKeys = {
    BookListType.favourites: 'favourite_book_files',
    BookListType.readLater: 'readlater_book_files',
    BookListType.completed: 'completed_book_files',
  };

  Future<Set<String>> getPaths(BookListType type) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_prefKeys[type]!) ?? []).toSet();
  }

  Future<void> _setPaths(BookListType type, Set<String> paths) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefKeys[type]!, paths.toList());
  }

  /// Toggles [path]'s membership in [type]'s list and returns the updated
  /// set (so the caller can update its in-memory state directly).
  Future<Set<String>> toggle(BookListType type, String path) async {
    final current = await getPaths(type);
    if (current.contains(path)) {
      current.remove(path);
    } else {
      current.add(path);
    }
    await _setPaths(type, current);
    return current;
  }

  /// Removes [path] from [type]'s list outright (used when a book file no
  /// longer exists on disk, rather than toggling based on current state).
  Future<Set<String>> remove(BookListType type, String path) async {
    final current = await getPaths(type);
    current.remove(path);
    await _setPaths(type, current);
    return current;
  }
}
