import 'package:bookread/AppColors.dart';
import 'package:bookread/widgets/custom_drawer.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('To Read'),
        backgroundColor: AppColors.primary, // Using primary color for app bar
        foregroundColor: AppColors.onPrimary, // White text on app bar
      ),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: toReadBooks.length,
        itemBuilder: (context, index) {
          final book = toReadBooks[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          size: 80,
                          color: AppColors.textSecondary,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                AppColors
                                    .textPrimary, // Text color from AppColors
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          book['lastOpened']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ), // Lighter text color
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.check_circle_outline,
                                color: AppColors.primary,
                              ), // Primary color for icons
                              onPressed: () {
                                // Handle mark as read action
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: AppColors.error,
                              ), // Red icon for delete
                              onPressed: () {
                                // Handle remove from list action
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: AppColors.success,
                              ), // Green icon for add
                              onPressed: () {
                                // Handle "Reading Now" action
                              },
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                // Handle menu actions here
                              },
                              itemBuilder:
                                  (context) => [
                                    PopupMenuItem(
                                      value: 'shareFile',
                                      child: Text('Share File'),
                                    ),
                                    PopupMenuItem(
                                      value: 'moveToTrash',
                                      child: Text('Move to Trash'),
                                    ),
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                  ],
                              icon: Icon(
                                Icons.more_vert,
                                color: AppColors.primary,
                              ), // More options icon
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
