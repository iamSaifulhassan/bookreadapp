import 'package:bookread/screens/bookcontentreading/book_content_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  static const String _favouritesPrefKey = 'favourite_book_files';

  List<String> favouritePaths = [];
  List<PlatformFile> favouriteFiles = [];

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = prefs.getStringList(_favouritesPrefKey) ?? [];
    setState(() {
      favouritePaths = paths;
      favouriteFiles =
          paths
              .map(
                (p) => PlatformFile(
                  name: p.split(Platform.pathSeparator).last,
                  path: p,
                  size: File(p).existsSync() ? File(p).lengthSync() : 0,
                ),
              )
              .toList();
    });
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favouritesPrefKey, favouritePaths);
    await _loadFavourites();
  }

  String _getFileDate(String? path) {
    if (path == null) return '';
    try {
      final file = File(path);
      final stat = file.statSync();
      return 'Modified: 	${stat.modified}';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body:
          favouriteFiles.isEmpty
              ? const Center(child: Text('No favourites yet.'))
              : CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final file = favouriteFiles[index];
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
                                  Icon(
                                    favouritePaths.contains(file.path)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        favouritePaths.contains(file.path)
                                            ? Colors.red
                                            : Colors.grey,
                                    size: 40,
                                  ),
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
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          favouritePaths.contains(file.path)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color:
                                              favouritePaths.contains(file.path)
                                                  ? Colors.red
                                                  : Colors.grey,
                                        ),
                                        tooltip:
                                            favouritePaths.contains(file.path)
                                                ? 'Remove from Favourites'
                                                : 'Add to Favourites',
                                        onPressed:
                                            () => _toggleFavourite(file.path),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: favouriteFiles.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.72,
                          ),
                    ),
                  ),
                ],
              ),
    );
  }
}
