import '../../services/app_logger.dart';
import 'package:bookread/widgets/custom_drawer.dart';
import 'package:bookread/widgets/custom_text_field.dart';
import 'package:bookread/themes/app_spacing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../services/streak_service.dart';
import '../../services/storage_permission_service.dart';
import 'widgets/book_file_card.dart';
import '../../l10n/generated/app_localizations.dart';

/// Lightweight value type for a book entry shown in the library — either a
/// file discovered in the custom books folder or one picked via the file
/// picker. Deliberately not file_picker's PlatformFile: that type only
/// carries what the picker itself returns and (as of file_picker 12) can no
/// longer be constructed or subclassed outside its own library.
class BookFile {
  final String name;
  final String? path;
  final String? extension;

  const BookFile({required this.name, required this.path, this.extension});
}

class HomeScreen extends StatefulWidget {
  final String? defaultFolderPath;
  const HomeScreen({super.key, this.defaultFolderPath});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  List<BookFile> pickedBookFiles = []; // New: holds files picked via +
  Directory? customBooksDir;
  List<FileSystemEntity> customBooks = [];
  TextEditingController? _dirController;
  static const String _folderPrefKey = 'bookread_folder_path';
  static const String _pickedFilesPrefKey = 'picked_book_files';
  static const String _favouritesPrefKey = 'favourite_book_files';
  static const String _readLaterPrefKey = 'readlater_book_files';
  static const String _completedPrefKey = 'completed_book_files';
  bool _isGrid = false; // Add to state
  bool _loading = true;
  bool _permissionDenied = false;
  Set<String> favouritePaths = {};
  Set<String> readLaterPaths = {};
  Set<String> completedPaths = {};
  final _permissionService = StoragePermissionService();
  @override
  void initState() {
    super.initState();
    _dirController = TextEditingController();
    _initAll();
    // Initialize streak service
    StreakService().loadStreaks();
  }

  Future<void> _initAll() async {
    setState(() {
      _loading = true;
      _permissionDenied = false;
    });

    // A storage-permission request launches a new Android Activity (the
    // "All files access" system settings screen). Firing that immediately
    // after another activity-launching flow returns (e.g. the Google
    // Sign-In account picker) can race the still-settling activity result
    // and leave the permission callback stuck, hanging this screen on its
    // loading spinner forever. Give the previous transition a moment to
    // finish first.
    await Future.delayed(const Duration(milliseconds: 400));

    // Request appropriate storage permissions based on Android version
    bool hasPermission = await _permissionService.requestStoragePermission();

    if (!hasPermission) {
      setState(() {
        _loading = false;
        _permissionDenied = true;
      });
      return;
    }
    await _loadSavedFolderPath();
    await _loadPickedBookFiles();
    await _loadFavourites();
    await _loadReadLater();
    await _loadCompleted();
    setState(() => _loading = false);
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    favouritePaths = (prefs.getStringList(_favouritesPrefKey) ?? []).toSet();
    setState(() {});
  }

  Future<void> _saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favouritesPrefKey, favouritePaths.toList());
  }

  Future<void> _loadReadLater() async {
    final prefs = await SharedPreferences.getInstance();
    readLaterPaths = (prefs.getStringList(_readLaterPrefKey) ?? []).toSet();
    setState(() {});
  }

  Future<void> _saveReadLater() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_readLaterPrefKey, readLaterPaths.toList());
  }

  Future<void> _loadCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    completedPaths = (prefs.getStringList(_completedPrefKey) ?? []).toSet();
    setState(() {});
  }

  Future<void> _saveCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_completedPrefKey, completedPaths.toList());
  }

  Future<void> _toggleFavourite(String? path) async {
    if (path == null) return;
    setState(() {
      if (favouritePaths.contains(path)) {
        favouritePaths.remove(path);
      } else {
        favouritePaths.add(path);
      }
    });
    await _saveFavourites();
  }

  Future<void> _toggleReadLater(String? path) async {
    if (path == null) return;
    setState(() {
      if (readLaterPaths.contains(path)) {
        readLaterPaths.remove(path);
      } else {
        readLaterPaths.add(path);
      }
    });
    await _saveReadLater();
  }

  Future<void> _toggleCompleted(String? path) async {
    if (path == null) return;

    final wasCompleted = completedPaths.contains(path);

    setState(() {
      if (wasCompleted) {
        completedPaths.remove(path);
      } else {
        completedPaths.add(path);
      }
    });

    // Update StreakService accordingly
    if (wasCompleted) {
      await StreakService().markDocumentNotCompleted(path);
    } else {
      await StreakService().markDocumentCompleted(path);
    }

    await _saveCompleted();
  }

  Future<void> _shareFile(String? path) async {
    if (path == null) return;
    await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
  }

  Future<void> _loadSavedFolderPath() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_folderPrefKey);
    if (savedPath != null && savedPath.isNotEmpty) {
      await _initCustomBooksDir(savedPath);
    } else {
      await _initCustomBooksDir();
    }
  }

  Future<void> _saveFolderPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_folderPrefKey, path);
  }

  Future<void> _initCustomBooksDir([String? customPath]) async {
    late Directory booksDir;

    if (customPath != null && customPath.isNotEmpty) {
      booksDir = Directory(customPath);
    } else {
      // Use app's external storage directory for better compatibility
      try {
        final externalDir = Directory('/storage/emulated/0/Documents/BookRead');
        booksDir = externalDir;
      } catch (e) {
        // Fallback to original path
        booksDir = Directory('/storage/emulated/0/bookread');
      }
    }

    try {
      if (!(await booksDir.exists())) {
        await booksDir.create(recursive: true);
      }
    } catch (e) {
      AppLogger.log('Failed to create directory: $e');
      // Create in a safer location
      booksDir = Directory('/storage/emulated/0/Download/BookRead');
      if (!(await booksDir.exists())) {
        await booksDir.create(recursive: true);
      }
    }
    // Remove picked files that now exist in the folder
    final newFiles =
        booksDir
            .listSync()
            .where((f) => f is File && _isBookFile(f.path))
            .toList();
    final folderPaths = newFiles.map((f) => f.path).toSet();
    setState(() {
      pickedBookFiles.removeWhere(
        (pf) => pf.path != null && folderPaths.contains(pf.path),
      );
      customBooksDir = booksDir;
      _dirController?.text = booksDir.path;
    });
    await _saveFolderPath(booksDir.path);
    await _loadBooksFromCustomDir();
  }

  Future<void> _onChangeDir() async {
    final newPath = _dirController?.text.trim();
    if (newPath != null && newPath.isNotEmpty) {
      await _initCustomBooksDir(
        newPath,
      ); // Pass the new path to actually change folder
    }
  }

  Future<void> _loadBooksFromCustomDir() async {
    if (customBooksDir == null) return;
    AppLogger.log('Loading books from: ${customBooksDir!.path}');
    final files =
        customBooksDir!
            .listSync()
            .where((f) => f is File && _isBookFile(f.path))
            .toList();
    AppLogger.log('Found files: ${files.map((f) => f.path).toList()}');
    if (_listKey.currentState != null) {
      final oldLength = customBooks.length;
      for (int i = oldLength - 1; i >= 0; i--) {
        _listKey.currentState!.removeItem(
          i,
          (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: _buildFileCardWithExt(
              _toBookFile(customBooks[i]),
              _getExt(customBooks[i]),
            ),
          ),
          duration: const Duration(milliseconds: 250),
        );
      }
      await Future.delayed(const Duration(milliseconds: 250));
      setState(() {
        customBooks = [];
      });
      for (int i = 0; i < files.length; i++) {
        customBooks.add(files[i]);
        _listKey.currentState!.insertItem(
          i,
          duration: const Duration(milliseconds: 250),
        );
        await Future.delayed(const Duration(milliseconds: 80));
      }
    } else {
      setState(() {
        customBooks = files;
      });
    }
  }

  Future<void> _loadPickedBookFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = prefs.getStringList(_pickedFilesPrefKey) ?? [];
    pickedBookFiles =
        paths
            .map(
              (p) => BookFile(
                name: p.split(Platform.pathSeparator).last,
                path: p,
              ),
            )
            .toList();
    setState(() {});
  }

  Future<void> _savePickedBookFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final paths =
        pickedBookFiles
            .map((f) => f.path ?? '')
            .where((p) => p.isNotEmpty)
            .toList();
    await prefs.setStringList(_pickedFilesPrefKey, paths);
  }

  String _getFileDate(String? path) {
    if (path == null) return '';
    try {
      final file = File(path);
      final stat = file.statSync();
      final formatter = DateFormat('yyyy-MM-dd HH:mm');
      return AppLocalizations.of(
        context,
      )!.modifiedLabel(formatter.format(stat.modified));
    } catch (_) {
      return '';
    }
  }

  // Helper to convert FileSystemEntity to BookFile
  BookFile _toBookFile(FileSystemEntity file) {
    final fileName = file.path.split('/').last;
    return BookFile(name: fileName, path: file.path);
  }

  String _getExt(FileSystemEntity file) {
    final fileName = file.path.split('/').last;
    return fileName.contains('.') ? fileName.split('.').last : '';
  }

  bool _isBookFile(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ['pdf', 'epub', 'docx', 'txt'].contains(ext);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.myBooksTitle),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                l10n.loadingYourBooks,
                style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }
    if (_permissionDenied) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.myBooksTitle),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_off_outlined,
                  size: 80,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.storageAccessRequiredTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.storageAccessRequiredBody,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.storageAccessRequiredHint,
                  style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        await openAppSettings();
                      },
                      icon: const Icon(Icons.settings),
                      label: Text(l10n.openSettingsButton),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                        });
                        await _initAll();
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text(l10n.commonRetry),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    // Deduplicate displayedFiles by file name
    final Map<String, BookFile> fileMap = {};
    for (final f in customBooks.map(_toBookFile)) {
      fileMap[f.name] = f;
    }
    for (final f in pickedBookFiles) {
      if (!fileMap.containsKey(f.name)) fileMap[f.name] = f;
    }
    final displayedFiles = fileMap.values.toList();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(l10n.myBooksTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: IconButton(
              icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
              tooltip:
                  _isGrid ? l10n.showAsListTooltip : l10n.showAsGridTooltip,
              onPressed: () {
                setState(() {
                  _isGrid = !_isGrid;
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFiles,
        tooltip: l10n.pickBookFilesTooltip,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 18,
                  ), // Add spacing above the folder path
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                          child: CustomTextField(
                            controller: _dirController!,
                            label: l10n.booksFolderPathLabel,
                            hint: '',
                            icon:
                                Icons.folder, // Only specify once, as required
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                            alignment: Alignment.center,
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                final tempController = TextEditingController(
                                  text: _dirController?.text ?? '',
                                );
                                return AlertDialog(
                                  title: Text(l10n.changeBooksFolderPathTitle),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: tempController,
                                              decoration: InputDecoration(
                                                labelText:
                                                    l10n.booksFolderPathLabel,
                                                border:
                                                    const OutlineInputBorder(),
                                                isDense: false,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 16,
                                                    ),
                                              ),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                              ),
                                              autofocus: true,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          IconButton(
                                            icon: Icon(
                                              Icons.folder_open,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).iconTheme.color ??
                                                  Theme.of(context).colorScheme.onSurfaceVariant,
                                            ),
                                            tooltip: l10n.browseForFolderTooltip,
                                            onPressed: () async {
                                              String? selectedDir;
                                              try {
                                                selectedDir =
                                                    await FilePicker.getDirectoryPath(
                                                      dialogTitle:
                                                          l10n.selectBooksFolderTitle,
                                                    );
                                              } catch (e) {
                                                selectedDir = null;
                                              }
                                              if (selectedDir != null) {
                                                tempController.text =
                                                    selectedDir;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop();
                                      },
                                      child: Text(l10n.commonCancel),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final newPath =
                                            tempController.text.trim();
                                        if (newPath.isNotEmpty &&
                                            newPath != _dirController?.text) {
                                          _dirController?.text = newPath;
                                          await _onChangeDir();
                                          if (!context.mounted) return;
                                          FocusScope.of(context).unfocus();
                                        }
                                        if (!context.mounted) return;
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(l10n.commonChange),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(l10n.commonChange),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (displayedFiles.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  l10n.noBooksMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          else if (_isGrid)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm2, vertical: AppSpacing.sm),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final file = displayedFiles[index];
                  final ext = file.extension ?? _getExt(File(file.path ?? ''));
                  return _buildFileCardWithExt(file, ext, index, true);
                }, childCount: displayedFiles.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  // Taller than 0.72: a 2-line book title plus the cover
                  // image, extension label, and 3-icon action row no longer
                  // fit at the old ratio, causing a bottom overflow.
                  childAspectRatio: 0.62,
                ),
              ),
            )
          else
            SliverAnimatedList(
              key: _listKey,
              initialItemCount: displayedFiles.length,
              itemBuilder: (context, index, animation) {
                final file = displayedFiles[index];
                final ext = file.extension ?? _getExt(File(file.path ?? ''));
                return SizeTransition(
                  sizeFactor: animation,
                  child: _buildFileCardWithExt(file, ext, index, false),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildFileCardWithExt(
    BookFile file,
    String ext, [
    int? index,
    bool isGrid = false,
  ]) {
    final bookFile = BookFile(name: file.name, path: file.path, extension: ext);
    return BookFileCard(
      file: bookFile,
      index: index,
      isGrid: isGrid,
      isFavourite: favouritePaths.contains(bookFile.path),
      isReadLater: readLaterPaths.contains(bookFile.path),
      isCompleted: completedPaths.contains(bookFile.path),
      fileDate: _getFileDate(bookFile.path),
      onToggleFavourite: () => _toggleFavourite(bookFile.path),
      onToggleReadLater: () => _toggleReadLater(bookFile.path),
      onToggleCompleted: () => _toggleCompleted(bookFile.path),
      onShare: () => _shareFile(bookFile.path),
      onDelete:
          (isGrid || index == null) ? null : () => _deleteFileAt(index),
    );
  }

  Future<void> _deleteFileAt(int index) async {
    if (index >= customBooks.length) {
      // Remove from picked files list
      setState(() {
        final removed = pickedBookFiles.removeAt(index - customBooks.length);
        _listKey.currentState?.removeItem(
          index,
          (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: _buildFileCardWithExt(
              removed,
              removed.extension ?? _getExt(File(removed.path ?? '')),
            ),
          ),
          duration: const Duration(milliseconds: 300),
        );
      });
      await _savePickedBookFiles();
    } else {
      // Remove from custom books list (don't delete physical file)
      setState(() {
        final removed = customBooks.removeAt(index);
        _listKey.currentState?.removeItem(
          index,
          (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: _buildFileCardWithExt(_toBookFile(removed), _getExt(removed)),
          ),
          duration: const Duration(milliseconds: 300),
        );
      });
    }
  }

  Future<void> _pickFiles() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'epub', 'docx', 'txt'],
    );
    for (final file in files) {
      await _addPickedBookFile(
        BookFile(name: file.name, path: file.path, extension: file.extension),
      );
    }
  }

  Future<void> _addPickedBookFile(BookFile file) async {
    // Prevent duplicates by path (either in folder or already picked)
    final displayedPaths = <String>{
      ...customBooks.map((f) => f.path),
      ...pickedBookFiles.map(
        (f) => f.path ?? '',
      ), // Ensure only String, not String?
    };
    if (file.path == null ||
        displayedPaths.contains(file.path) ||
        pickedBookFiles.any((f) => f.name == file.name) ||
        customBooks.map(_toBookFile).any((f) => f.name == file.name)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.fileAlreadyExistsMessage)),
      );
      return;
    }
    setState(() {
      pickedBookFiles.add(file);
      // Animate addition at the end
      _listKey.currentState?.insertItem(
        customBooks.length + pickedBookFiles.length - 1,
        duration: const Duration(milliseconds: 250),
      );
    });
    await _savePickedBookFiles();
  }
}
