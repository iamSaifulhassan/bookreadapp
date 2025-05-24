import 'package:bookread/widgets/custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
// import 'package:pdf_render/pdf_render_widgets.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isGrid = false; // Add to state
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _dirController = TextEditingController();
    _initAll();
  }

  Future<void> _initAll() async {
    setState(() => _loading = true);
    await _loadSavedFolderPath();
    await _loadPickedBookFiles();
    setState(() => _loading = false);
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
    final booksDir =
        customPath != null && customPath.isNotEmpty
            ? Directory(customPath)
            : Directory('/storage/emulated/0/bookread');
    if (!(await booksDir.exists())) {
      await booksDir.create(recursive: true);
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
    // Animate changes: clear and insert all
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
      // Insert new items one by one for animation
      for (int i = 0; i < files.length; i++) {
        customBooks.add(files[i]);
        _listKey.currentState!.insertItem(
          i,
          duration: const Duration(milliseconds: 250),
        );
        await Future.delayed(const Duration(milliseconds: 80)); // Stagger for visible animation
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
    final List<PlatformFile> loaded = [];
    for (final path in paths) {
      final file = File(path);
      if (await file.exists() && _isBookFile(path)) {
        loaded.add(PlatformFile(
          name: path.split('/').last,
          path: path,
          size: file.lengthSync(),
          bytes: null,
          readStream: null,
        ));
      }
    }
    setState(() {
      pickedBookFiles = loaded;
    });
  }

  Future<void> _savePickedBookFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = pickedBookFiles.map((f) => f.path ?? '').where((p) => p.isNotEmpty).toList();
    await prefs.setStringList(_pickedFilesPrefKey, paths);
  }

  Future<void> _addPickedBookFile(PlatformFile file) async {
    // Prevent duplicates by path (either in folder or already picked)
    final displayedPaths = {
      ...customBooks.map((f) => f.path),
      ...pickedBookFiles.map((f) => f.path),
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
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
      appBar: AppBar(
        title: const Text("My Books"),
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            tooltip: _isGrid ? 'Show as List' : 'Show as Grid',
            onPressed: () {
              setState(() {
                _isGrid = !_isGrid;
              });
            },
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _dirController!,
                      label: 'Books Folder Path',
                      hint: '',
                      icon: Icons.folder, // Only specify once, as required
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 48,
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
                                            tempController.text = selectedDir;
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
                                    final newPath = tempController.text.trim();
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
      return AspectRatio(
        aspectRatio: 0.68,
        child: Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(8), child: cover),
                const SizedBox(height: 12),
                Text(
                  file.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _getFileDate(file.path),
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    }
    // --- LIST MODE ---
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueGrey[100]!),
                        ),
                        child: Text(
                          file.extension?.toUpperCase() ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getFileDate(file.path),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bookmark_border, size: 20),
                        tooltip: 'Read Later',
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, size: 20),
                        tooltip: 'Share',
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20),
                        tooltip: 'Delete',
                        onPressed: () async {
                          if (file.path != null && index != null) {
                            // Determine if file is from folder or picked
                            final isPicked = index >= customBooks.length;
                            if (isPicked) {
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
                                  duration: const Duration(milliseconds: 300),
                                );
                              });
                              await _savePickedBookFiles();
                            } else {
                              try {
                                final f = File(file.path!);
                                if (await f.exists()) {
                                  await f.delete();
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
                                    duration: const Duration(milliseconds: 300),
                                  );
                                  setState(() {});
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to delete file: $e'),
                                  ),
                                );
                              }
                            }
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border, size: 20),
                        tooltip: 'Favourites',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
