import 'package:bookread/main.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Map<String, String>> favouriteBooks = [
    {
      'title': 'The Great Gatsby',
      'lastOpened': 'Last opened: 2 days ago',
      'image':
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1551144577i/18405._UX187_.jpg',
    },
    {
      'title': 'To Kill a Mockingbird',
      'lastOpened': 'Last opened: 5 days ago',
      'image':
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1551144577i/18405._UX187_.jpg',
    },
    {
      'title': '1984',
      'lastOpened': 'Last opened: 1 week ago',
      'image':
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1551144577i/18405._UX187_.jpg',
    },
  ];

  FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 1,
      ),
      drawer: const CustomDrawer(), // Assuming you have a CustomDrawer widget),
      body: Container(
        color: theme.colorScheme.background,
        child: ListView.builder(
          itemCount: favouriteBooks.length,
          itemBuilder: (context, index) {
            final book = favouriteBooks[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: theme.colorScheme.surfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.12),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        book['image']!,
                        width: 80,
                        height: 115,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 115,
                            color: theme.colorScheme.surface,
                            child: Icon(
                              Icons.broken_image,
                              size: 40,
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.5,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            book['title']!,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            book['lastOpened']!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.bookmark),
                                  onPressed: () {},
                                  tooltip: 'Unfavourite',
                                  color: theme.colorScheme.primary,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.watch_later_outlined),
                                  onPressed: () {},
                                  tooltip: 'Read Later',
                                  color: theme.colorScheme.secondary,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.done_all),
                                  onPressed: () {},
                                  tooltip: 'Mark as Read',
                                  color: theme.colorScheme.tertiary,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.library_add_outlined),
                                  onPressed: () {},
                                  tooltip: 'Add to Collection',
                                  color: theme.colorScheme.primaryContainer,
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    // Handle actions
                                  },
                                  itemBuilder:
                                      (context) => [
                                        const PopupMenuItem(
                                          value: 'shareFile',
                                          child: Text('Share File'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'moveToTrash',
                                          child: Text('Move to Trash'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Text('Edit'),
                                        ),
                                      ],
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  color: theme.colorScheme.surface,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
