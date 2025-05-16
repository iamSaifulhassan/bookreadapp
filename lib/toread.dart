import 'package:bookread/main.dart';
import 'package:flutter/material.dart';

class ToReadScreen extends StatelessWidget {
  final List<Map<String, String>> toReadBooks = [
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

  ToReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Read',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 1,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        color: colorScheme.background,
        child: ListView.builder(
          itemCount: toReadBooks.length,
          itemBuilder: (context, index) {
            final book = toReadBooks[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 2,
              color: colorScheme.surfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.primary.withOpacity(0.12),
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
                            color: colorScheme.surface,
                            child: Icon(
                              Icons.broken_image,
                              size: 40,
                              color: colorScheme.onSurface.withOpacity(0.5),
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
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            book['lastOpened']!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check_circle_outline),
                                  onPressed: () {},
                                  tooltip: 'Mark as Read',
                                  color: colorScheme.primary,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () {},
                                  tooltip: 'Remove from List',
                                  color: colorScheme.error,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {},
                                  tooltip: 'Add to Reading Now',
                                  color: colorScheme.secondary,
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
                                    color: colorScheme.onSurface,
                                  ),
                                  color: colorScheme.surface,
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
