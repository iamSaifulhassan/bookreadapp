import 'package:bookread/widgets/custom_drawer.dart';
import 'package:bookread/themes/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../Bookcontentreading/book_content_screen.dart';
import '../../services/streak_service.dart';
import '../../widgets/streak_widget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  static const String _completedPrefKey = 'completed_book_files';
  static const String _favouritesPrefKey = 'favourite_book_files';

  List<String> completedPaths = [];
  List<File> completedFiles = [];
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
    await _loadCompleted();
    await _loadFavourites();
    setState(() => _loading = false);
  }

  Future<void> _loadCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    completedPaths = prefs.getStringList(_completedPrefKey) ?? [];
    completedFiles =
        completedPaths
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

  Future<void> _removeFromCompleted(String path) async {
    final prefs = await SharedPreferences.getInstance();
    completedPaths.remove(path);
    await prefs.setStringList(_completedPrefKey, completedPaths);
    await _loadCompleted();
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
                  // Book cover placeholder with checkmark
                  Container(
                    width: 50,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.success.withOpacity(0.8),
                          AppColors.success,
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.book,
                            color: AppColors.onSuccess,
                            size: 24,
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.check,
                              color: AppColors.success,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
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
                              isAboutToExpire:
                                  false, // Completed items don't expire
                              isCompleted:
                                  true, // All items in Completed screen are completed
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
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
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
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.success.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                _getExt(file).toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 14,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Completed',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.success,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _getFileDate(file.path),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textDisabled,
                                ),
                              ),
                            ),
                          ],
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
                      Icons.check_circle,
                      size: 20,
                      color: AppColors.success,
                    ),
                    tooltip: 'Remove from Completed',
                    onPressed: () => _removeFromCompleted(file.path),
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
                        AppColors.success.withOpacity(0.8),
                        AppColors.success,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.book,
                          color: AppColors.onSuccess,
                          size: 40,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.check,
                            color: AppColors.success,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
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
                    isAboutToExpire: false, // Completed items don't expire
                    isCompleted:
                        true, // All items in Completed screen are completed
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
                    onTap: () => _removeFromCompleted(file.path),
                    child: Icon(
                      Icons.check_circle,
                      size: 18,
                      color: AppColors.success,
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
        title: const Text('Completed Books'),
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
          completedFiles.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No completed books yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Books you\'ve finished reading will appear here',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
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
                itemCount: completedFiles.length,
                itemBuilder: (context, index) {
                  return _buildGridCard(completedFiles[index], index: index);
                },
              )
              : ListView.builder(
                itemCount: completedFiles.length,
                itemBuilder: (context, index) {
                  return _buildFileCard(completedFiles[index], index: index);
                },
              ),
    );
  }
}
