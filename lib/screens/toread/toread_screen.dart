import 'package:bookread/AppColors.dart';
import 'package:bookread/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../book_content_screen.dart';
import '../../services/streak_service.dart';
import '../../widgets/streak_widget.dart';

class ToReadScreen extends StatefulWidget {
  const ToReadScreen({super.key});

  @override
  State<ToReadScreen> createState() => _ToReadScreenState();
}

class _ToReadScreenState extends State<ToReadScreen> {
  static const String _readLaterPrefKey = 'readlater_book_files';
  static const String _favouritesPrefKey = 'favourite_book_files';

  List<String> readLaterPaths = [];
  List<File> readLaterFiles = [];
  Set<String> favouritePaths = {};
  bool _loading = true;
  bool _isGrid = false;
  @override
  void initState() {
    super.initState();
    StreakService().loadStreaks(); // Initialize streak service
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    await _loadReadLater();
    await _loadFavourites();
    setState(() => _loading = false);
  }

  Future<void> _loadReadLater() async {
    final prefs = await SharedPreferences.getInstance();
    readLaterPaths = prefs.getStringList(_readLaterPrefKey) ?? [];
    readLaterFiles =
        readLaterPaths
            .where((p) => File(p).existsSync())
            .map((p) => File(p))
            .toList();
    setState(() {});
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    favouritePaths = (prefs.getStringList(_favouritesPrefKey) ?? []).toSet();
    setState(() {});
  }

  Future<void> _removeFromReadLater(String path) async {
    final prefs = await SharedPreferences.getInstance();
    readLaterPaths.remove(path);
    await prefs.setStringList(_readLaterPrefKey, readLaterPaths);
    await _loadReadLater();
  }

  Future<void> _toggleFavourite(String path) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favouritePaths.contains(path)) {
        favouritePaths.remove(path);
      } else {
        favouritePaths.add(path);
      }
    });
    await prefs.setStringList(_favouritesPrefKey, favouritePaths.toList());
  }

  Future<void> _shareFile(String path) async {
    await Share.shareXFiles([XFile(path)]);
  }

  String _getFileDate(String path) {
    try {
      final file = File(path);
      return 'Modified: ${DateFormat('yyyy-MM-dd HH:mm').format(file.statSync().modified)}';
    } catch (_) {
      return '';
    }
  }

  String _getExt(File file) {
    final fileName = file.path.split('/').last;
    return fileName.contains('.') ? fileName.split('.').last : '';
  }

  Widget _buildFileCard(File file, {int? index}) {
    final fileName = file.path.split('/').last;
    final displayName =
        fileName.length > 25 ? '${fileName.substring(0, 22)}...' : fileName;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BookContentScreen(
                    filePath: file.path,
                    fileName: fileName,
                  ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Book cover placeholder
                  Container(
                    width: 50,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.secondary.withOpacity(0.8),
                          AppColors.secondary,
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.bookmark,
                      color: AppColors.onSecondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            StreakWidget(
                              streakCount: StreakService()
                                  .getCurrentStreakCount(file.path),
                              isAboutToExpire: StreakService()
                                  .isStreakAboutToExpire(file.path),
                              isCompleted:
                                  false, // ToRead items are not completed
                              iconSize: 18,
                              fontSize: 14,
                            ),
                            if (StreakService().getCurrentStreakCount(
                                  file.path,
                                ) >
                                0)
                              const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                displayName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                fileName,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textDisabled,
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
                                color: AppColors.secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.secondary.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                _getExt(file).toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondary,
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
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    tooltip: 'Favourite',
                    onPressed: () => _toggleFavourite(file.path),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, size: 20),
                    tooltip: 'Share',
                    onPressed: () => _shareFile(file.path),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      size: 20,
                      color: AppColors.secondary,
                    ),
                    tooltip: 'Remove from Read Later',
                    onPressed: () => _removeFromReadLater(file.path),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(File file, {int? index}) {
    final fileName = file.path.split('/').last;
    final displayName =
        fileName.length > 20 ? '${fileName.substring(0, 17)}...' : fileName;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BookContentScreen(
                    filePath: file.path,
                    fileName: fileName,
                  ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.secondary.withOpacity(0.8),
                        AppColors.secondary,
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.bookmark,
                    color: AppColors.onSecondary,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreakWidget(
                    streakCount: StreakService().getCurrentStreakCount(
                      file.path,
                    ),
                    isAboutToExpire: StreakService().isStreakAboutToExpire(
                      file.path,
                    ),
                    isCompleted: false, // ToRead items are not completed
                    iconSize: 16,
                    fontSize: 12,
                  ),
                  if (StreakService().getCurrentStreakCount(file.path) > 0)
                    const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      displayName,
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
                _getExt(file).toUpperCase(),
                style: TextStyle(fontSize: 11, color: AppColors.textDisabled),
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
                    onTap: () => _shareFile(file.path),
                    child: Icon(
                      Icons.share,
                      size: 18,
                      color: AppColors.textDisabled,
                    ),
                  ),
                  InkWell(
                    onTap: () => _removeFromReadLater(file.path),
                    child: Icon(
                      Icons.bookmark,
                      size: 18,
                      color: AppColors.secondary,
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

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Later'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
            tooltip: _isGrid ? 'List View' : 'Grid View',
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body:
          readLaterFiles.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 64,
                      color: AppColors.textDisabled,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No books to read later',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDisabled,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add books to read later from the My Books screen',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textDisabled,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
              : _isGrid
              ? GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: readLaterFiles.length,
                itemBuilder: (context, index) {
                  return _buildGridCard(readLaterFiles[index], index: index);
                },
              )
              : ListView.builder(
                itemCount: readLaterFiles.length,
                itemBuilder: (context, index) {
                  return _buildFileCard(readLaterFiles[index], index: index);
                },
              ),
    );
  }
}

// Guidance:
// - Use BLoC for to-read state if needed.
// - Use reusable widgets for book items.
// - Add list, empty state, and error handling as needed.
// - Remove TODOs as you implement logic.
