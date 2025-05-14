import 'package:flutter/material.dart';
import 'package:bookread/AppColors.dart';

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
      body: ListView.builder(
        itemCount: favouriteBooks.length,
        itemBuilder: (context, index) {
          final book = favouriteBooks[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      book['image']!,
                      width: 80,
                      height: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 40),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book['title']!, style: theme.textTheme.titleLarge),
                        const SizedBox(height: 4),
                        Text(
                          book['lastOpened']!,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: theme.colorScheme.secondary,
                            ),
                            IconButton(
                              icon: const Icon(Icons.library_add_outlined),
                              onPressed: () {},
                              tooltip: 'Add to Collection',
                              color: theme.colorScheme.secondary,
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                switch (value) {
                                  case 'shareFile':
                                    // Add logic to share the file
                                    break;
                                  case 'moveToTrash':
                                    // Add logic to move the file to trash
                                    break;
                                  case 'edit':
                                    // Add logic to edit the file
                                    break;
                                  default:
                                    // Handle unknown actions
                                    break;
                                }
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
                              icon: const Icon(Icons.more_vert),
                              color: theme.colorScheme.surface,
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
        },
      ),
    );
  }
}
