import 'package:bookread/AppColors.dart';
import 'package:bookread/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../book_content_screen.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  static const String _favouritesPrefKey = 'favourite_book_files';
  static const String _readLaterPrefKey = 'readlater_book_files';
  static const String _completedPrefKey = 'completed_book_files';

  List<String> favouritePaths = [];
  List<File> favouriteFiles = [];
  Set<String> readLaterPaths = {};
  Set<String> completedPaths = {};
  bool _loading = true;
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    await _loadFavourites();
    await _loadReadLater();
    await _loadCompleted();
    setState(() => _loading = false);
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    favouritePaths = prefs.getStringList(_favouritesPrefKey) ?? [];
    favouriteFiles =
        favouritePaths
            .where((p) => File(p).existsSync())
            .map((p) => File(p))
            .toList();
    setState(() {});
  }

  Future<void> _loadReadLater() async {
    final prefs = await SharedPreferences.getInstance();
    readLaterPaths = (prefs.getStringList(_readLaterPrefKey) ?? []).toSet();
    setState(() {});
  }

  Future<void> _loadCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    completedPaths = (prefs.getStringList(_completedPrefKey) ?? []).toSet();
    setState(() {});
  }

  Future<void> _removeFavourite(String path) async {
    final prefs = await SharedPreferences.getInstance();
    favouritePaths.remove(path);
    await prefs.setStringList(_favouritesPrefKey, favouritePaths);
    await _loadFavourites();
  }

  Future<void> _toggleReadLater(String path) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (readLaterPaths.contains(path)) {
        readLaterPaths.remove(path);
      } else {
        readLaterPaths.add(path);
      }
    });
    await prefs.setStringList(_readLaterPrefKey, readLaterPaths.toList());
  }

  Future<void> _toggleCompleted(String path) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (completedPaths.contains(path)) {
        completedPaths.remove(path);
      } else {
        completedPaths.add(path);
      }
    });
    await prefs.setStringList(_completedPrefKey, completedPaths.toList());
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
                          AppColors.primary.withOpacity(0.8),
                          AppColors.primary,
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.book,
                      color: AppColors.onPrimary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                                color: AppColors.inputFill,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                _getExt(file).toUpperCase(),
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
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 20,
                      color: AppColors.error,
                    ),
                    tooltip: 'Remove from Favourites',
                    onPressed: () => _removeFavourite(file.path),
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
                        AppColors.primary.withOpacity(0.8),
                        AppColors.primary,
                      ],
                    ),
                  ),
                  child: Icon(Icons.book, color: AppColors.onPrimary, size: 40),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
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
                    onTap: () => _shareFile(file.path),
                    child: Icon(
                      Icons.share,
                      size: 18,
                      color: AppColors.textDisabled,
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
                    onTap: () => _removeFavourite(file.path),
                    child: const Icon(
                      Icons.favorite,
                      size: 18,
                      color: AppColors.error,
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
        title: const Text('Favourites'),
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
      drawer: const CustomDrawer(),
      body:
          favouriteFiles.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: AppColors.textDisabled,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No favourite books yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add books to favourites from the My Books screen',
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
                itemCount: favouriteFiles.length,
                itemBuilder: (context, index) {
                  return _buildGridCard(favouriteFiles[index], index: index);
                },
              )
              : ListView.builder(
                itemCount: favouriteFiles.length,
                itemBuilder: (context, index) {
                  return _buildFileCard(favouriteFiles[index], index: index);
                },
              ),
    );
  }
}
