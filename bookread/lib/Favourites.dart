import 'package:bookread/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:bookread/screens/book_content_screen.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  static const String _favouritesPrefKey = 'favourite_book_files';
  List<String> favouritePaths = [];
  List<FileSystemEntity> favouriteFiles = [];
  bool _loading = true;
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    favouritePaths = prefs.getStringList(_favouritesPrefKey) ?? [];
    favouriteFiles =
        favouritePaths
            .where((p) => File(p).existsSync())
            .map((p) => File(p))
            .toList();
    setState(() => _loading = false);
  }

  Future<void> _removeFavourite(String path) async {
    final prefs = await SharedPreferences.getInstance();
    favouritePaths.remove(path);
    await prefs.setStringList(_favouritesPrefKey, favouritePaths);
    await _loadFavourites();
  }

  String _getFileDate(String? path) {
    if (path == null) return '';
    try {
      final file = File(path);
      return 'Modified: ${DateFormat('yyyy-MM-dd HH:mm').format(file.statSync().modified)}';
    } catch (_) {
      return '';
    }
  }

  String _getExt(FileSystemEntity file) {
    final fileName = file.path.split('/').last;
    return fileName.contains('.') ? fileName.split('.').last : '';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
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
      drawer: CustomDrawer(),
      body:
          favouriteFiles.isEmpty
              ? Center(
                child: Text(
                  "No favourite books yet.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
              : _isGrid
              ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: GridView.builder(
                  itemCount: favouriteFiles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final file = favouriteFiles[index];
                    final ext = _getExt(file);
                    return _buildFileCard(file, ext, index, true);
                  },
                ),
              )
              : ListView.builder(
                itemCount: favouriteFiles.length,
                itemBuilder: (context, index) {
                  final file = favouriteFiles[index];
                  final ext = _getExt(file);
                  return _buildFileCard(file, ext, index, false);
                },
              ),
    );
  }

  Widget _buildFileCard(
    FileSystemEntity file,
    String ext,
    int index,
    bool isGrid,
  ) {
    final fileName = file.path.split('/').last;
    Widget cover;
    if (ext == 'pdf') {
      cover = Image.asset(
        'assets/images/applogo.png',
        width: isGrid ? 80 : 48,
        height: isGrid ? 110 : 64,
        fit: BoxFit.cover,
      );
    } else if (ext == 'txt') {
      cover = Icon(
        Icons.description,
        size: isGrid ? 60 : 48,
        color: Colors.blueGrey,
      );
    } else {
      cover = Image.asset(
        'assets/images/applogo.png',
        width: isGrid ? 80 : 48,
        height: isGrid ? 110 : 64,
        fit: BoxFit.cover,
      );
    }
    if (isGrid) {
      return GestureDetector(
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
                    Text(
                      fileName,
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
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      tooltip: 'Remove from Favourites',
                      onPressed: () => _removeFavourite(file.path),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    // List mode
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
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
                              fileName,
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
                              ext.toUpperCase(),
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
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            tooltip: 'Remove from Favourites',
                            onPressed: () => _removeFavourite(file.path),
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
}
