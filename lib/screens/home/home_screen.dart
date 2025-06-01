import 'package:bookread/widgets/custom_drawer.dart';
import 'package:bookread/widgets/custom_text_field.dart';
import 'package:bookread/themes/AppColors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
// import 'package:pdf_render/pdf_render_widgets.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Bookcontentreading/book_content_screen.dart';
import '../../services/streak_service.dart';
import '../../widgets/streak_widget.dart';

class HomeScreen extends StatefulWidget {
  final String? defaultFolderPath;
  const HomeScreen({super.key, this.defaultFolderPath});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  List<PlatformFile> pickedBookFiles = []; // New: holds files picked via +
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

    // Request appropriate storage permissions based on Android version
    bool hasPermission = await _requestStoragePermission();

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

  Future<bool> _requestStoragePermission() async {
    // Check Android version and request appropriate permissions
    try {
      // For Android 11+ (API 30+), we need MANAGE_EXTERNAL_STORAGE
      if (await Permission.manageExternalStorage.isDenied) {
        final status = await Permission.manageExternalStorage.request();
        if (status.isGranted) return true;
      }

      // For Android 13+ (API 33+), request media permissions
      if (await Permission.photos.isDenied) {
        await Permission.photos.request();
      }

      // Fallback to traditional storage permission
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) return true;

      // Check if any permission is granted
      return await Permission.manageExternalStorage.isGranted ||
          await Permission.storage.isGranted ||
          await Permission.photos.isGranted;
    } catch (e) {
      print('Permission error: $e');
      // Fallback to basic storage permission
      final status = await Permission.storage.request();
      return status.isGranted;
    }
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
    await Share.shareXFiles([XFile(path)]);
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
      print('Failed to create directory: $e');
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
    print('Loading books from: ${customBooksDir!.path}');
    final files =
        customBooksDir!
            .listSync()
            .where((f) => f is File && _isBookFile(f.path))
            .toList();
    print('Found files: ${files.map((f) => f.path).toList()}');
    if (_listKey.currentState != null) {
      final oldLength = customBooks.length;
      for (int i = oldLength - 1; i >= 0; i--) {
        _listKey.currentState!.removeItem(
          i,
          (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: _buildFileCardWithExt(
              _toPlatformFile(customBooks[i]),
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
              (p) => PlatformFile(
                name: p.split(Platform.pathSeparator).last,
                path: p,
                size: File(p).existsSync() ? File(p).lengthSync() : 0,
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
      return 'Modified: ${formatter.format(stat.modified)}';
    } catch (_) {
      return '';
    }
  }

  // Helper to convert FileSystemEntity to PlatformFile
  PlatformFile _toPlatformFile(FileSystemEntity file) {
    final fileName = file.path.split('/').last;
    return PlatformFile(
      name: fileName,
      path: file.path,
      size: File(file.path).lengthSync(),
      bytes: null,
      readStream: null,
    );
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
    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Books'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Loading your books...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }
    if (_permissionDenied) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Books'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.folder_off_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Storage Access Required',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'This app needs storage permission to access and manage your book files.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please enable storage permission in your device settings.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
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
                      label: const Text('Open Settings'),
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
                      label: const Text('Retry'),
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
    final Map<String, PlatformFile> fileMap = {};
    for (final f in customBooks.map(_toPlatformFile)) {
      fileMap[f.name] = f;
    }
    for (final f in pickedBookFiles) {
      if (!fileMap.containsKey(f.name)) fileMap[f.name] = f;
    }
    final displayedFiles = fileMap.values.toList();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("My Books"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
              tooltip: _isGrid ? 'Show as List' : 'Show as Grid',
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
        tooltip: 'Pick Book Files',
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CustomTextField(
                            controller: _dirController!,
                            label: 'Books Folder Path',
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
                            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                                  title: const Text('Change Books Folder Path'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: tempController,
                                              decoration: const InputDecoration(
                                                labelText: 'Books Folder Path',
                                                border: OutlineInputBorder(),
                                                isDense: false,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 16,
                                                    ),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.blueGrey,
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
                                                  Colors.grey[700],
                                            ),
                                            tooltip: 'Browse for folder',
                                            onPressed: () async {
                                              String? selectedDir;
                                              try {
                                                selectedDir = await FilePicker
                                                    .platform
                                                    .getDirectoryPath(
                                                      dialogTitle:
                                                          'Select Books Folder',
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
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final newPath =
                                            tempController.text.trim();
                                        if (newPath.isNotEmpty &&
                                            newPath != _dirController?.text) {
                                          _dirController?.text = newPath;
                                          await _onChangeDir();
                                          FocusScope.of(context).unfocus();
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Change'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Change'),
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
                  "No book files in custom folder or picked. Tap + to add files.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          else if (_isGrid)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  childAspectRatio: 0.72,
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
    PlatformFile file,
    String ext, [
    int? index,
    bool isGrid = false,
  ]) {
    return _buildFileCard(_PlatformFileWithExt(file, ext), index, isGrid);
  }

  Widget _buildFileCard(PlatformFile file, [int? index, bool isGrid = false]) {
    Widget cover;
    if (file.extension == 'pdf' && file.path != null) {
      cover = AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Image.asset(
          'assets/images/applogo.png',
          key: ValueKey(file.path),
          width: isGrid ? 80 : 48,
          height: isGrid ? 110 : 64,
          fit: BoxFit.cover,
        ),
      );
    } else if (file.extension == 'txt') {
      cover = Icon(
        Icons.description,
        size: isGrid ? 60 : 48,
        color: Colors.blueGrey,
      );
    } else {
      cover = AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Image.asset(
          'assets/images/applogo.png',
          key: ValueKey(file.path),
          width: isGrid ? 80 : 48,
          height: isGrid ? 110 : 64,
          fit: BoxFit.cover,
        ),
      );
    }
    if (isGrid) {
      return GestureDetector(
        onTap: () {
          if (file.path != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BookContentScreen(
                      filePath: file.path!,
                      fileName: file.name,
                    ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AspectRatio(
            aspectRatio: 0.68,
            child: Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: cover,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (file.path != null)
                          StreakWidget(
                            streakCount: StreakService().getCurrentStreakCount(
                              file.path!,
                            ),
                            isAboutToExpire: StreakService()
                                .isStreakAboutToExpire(file.path!),
                            isCompleted: completedPaths.contains(file.path),
                            iconSize: 16,
                            fontSize: 12,
                          ),
                        if (file.path != null &&
                            StreakService().getCurrentStreakCount(file.path!) >
                                0)
                          const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            file.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      file.extension?.toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textDisabled,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => _toggleFavourite(file.path),
                          child: Icon(
                            favouritePaths.contains(file.path)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                            color:
                                favouritePaths.contains(file.path)
                                    ? AppColors.error
                                    : AppColors.textDisabled,
                          ),
                        ),
                        InkWell(
                          onTap: () => _toggleReadLater(file.path),
                          child: Icon(
                            readLaterPaths.contains(file.path)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 18,
                            color:
                                readLaterPaths.contains(file.path)
                                    ? AppColors.secondary
                                    : AppColors.textDisabled,
                          ),
                        ),
                        InkWell(
                          onTap: () => _toggleCompleted(file.path),
                          child: Icon(
                            completedPaths.contains(file.path)
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            size: 18,
                            color:
                                completedPaths.contains(file.path)
                                    ? AppColors.success
                                    : AppColors.textDisabled,
                          ),
                        ),
                        InkWell(
                          onTap: () => _shareFile(file.path),
                          child: Icon(
                            Icons.share,
                            size: 18,
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } // <-- This closes the if (isGrid) block

    // --- LIST MODE ---
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            if (file.path != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BookContentScreen(
                        filePath: file.path!,
                        fileName: file.name,
                      ),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(8), child: cover),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (file.path != null)
                            StreakWidget(
                              streakCount: StreakService()
                                  .getCurrentStreakCount(file.path!),
                              isAboutToExpire: StreakService()
                                  .isStreakAboutToExpire(file.path!),
                              isCompleted: completedPaths.contains(file.path),
                              iconSize: 18,
                              fontSize: 14,
                            ),
                          if (file.path != null &&
                              StreakService().getCurrentStreakCount(
                                    file.path!,
                                  ) >
                                  0)
                            const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              file.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.inputFill,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              file.extension?.toUpperCase() ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getFileDate(file.path),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textDisabled,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              readLaterPaths.contains(file.path)
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 20,
                              color:
                                  readLaterPaths.contains(file.path)
                                      ? AppColors.secondary
                                      : null,
                            ),
                            tooltip: 'Read Later',
                            onPressed: () => _toggleReadLater(file.path),
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, size: 20),
                            tooltip: 'Share',
                            onPressed: () => _shareFile(file.path),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 20),
                            tooltip: 'Remove from List',
                            onPressed: () async {
                              if (file.path != null && index != null) {
                                final isPicked = index >= (customBooks.length);
                                if (isPicked) {
                                  // Remove from picked files list
                                  setState(() {
                                    final removed = pickedBookFiles.removeAt(
                                      index - customBooks.length,
                                    );
                                    _listKey.currentState?.removeItem(
                                      index,
                                      (context, animation) => SizeTransition(
                                        sizeFactor: animation,
                                        child: _buildFileCardWithExt(
                                          removed,
                                          removed.extension ??
                                              _getExt(File(removed.path ?? '')),
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
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
                                        child: _buildFileCardWithExt(
                                          _toPlatformFile(removed),
                                          _getExt(removed),
                                        ),
                                      ),
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                    );
                                  });
                                }
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              favouritePaths.contains(file.path)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20,
                              color:
                                  favouritePaths.contains(file.path)
                                      ? AppColors.error
                                      : null,
                            ),
                            tooltip:
                                favouritePaths.contains(file.path)
                                    ? 'Remove from Favourites'
                                    : 'Add to Favourites',
                            onPressed: () => _toggleFavourite(file.path),
                          ),
                          IconButton(
                            icon: Icon(
                              completedPaths.contains(file.path)
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              size: 20,
                              color:
                                  completedPaths.contains(file.path)
                                      ? AppColors.success
                                      : null,
                            ),
                            tooltip:
                                completedPaths.contains(file.path)
                                    ? 'Remove from Completed'
                                    : 'Mark as Completed',
                            onPressed: () => _toggleCompleted(file.path),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'epub', 'docx', 'txt'],
      allowMultiple: true,
    );
    if (result != null) {
      for (final file in result.files) {
        await _addPickedBookFile(file);
      }
    }
  }

  Future<void> _addPickedBookFile(PlatformFile file) async {
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
        customBooks.map(_toPlatformFile).any((f) => f.name == file.name)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('File already exists')));
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

class _PlatformFileWithExt implements PlatformFile {
  final PlatformFile _file;
  @override
  final String? extension;
  _PlatformFileWithExt(this._file, this.extension);
  @override
  noSuchMethod(Invocation invocation) => _file.noSuchMethod(invocation);
  // Forward all PlatformFile properties
  @override
  String get name => _file.name;
  @override
  String? get path => _file.path;
  @override
  int get size => _file.size;
  @override
  Uint8List? get bytes => _file.bytes;
  @override
  Stream<List<int>>? get readStream => _file.readStream;
}
