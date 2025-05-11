import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Map<String, String>> favouriteBooks = [
    {
      'title': 'Book 1',
      'lastOpened': 'Last opened: 2 days ago',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Book 2',
      'lastOpened': 'Last opened: 5 days ago',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Book 3',
      'lastOpened': 'Last opened: 1 week ago',
      'image': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        backgroundColor: Colors.deepPurple.shade400,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: favouriteBooks.length,
        itemBuilder: (context, index) {
          final book = favouriteBooks[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    book['image']!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 100);
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['title']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          book['lastOpened']!,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.star_border),
                              onPressed: () {
                                // Handle unfavourite action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.watch_later_outlined),
                              onPressed: () {
                                // Handle read later action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.done_all),
                              onPressed: () {
                                // Handle read completely action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.library_add_outlined),
                              onPressed: () {
                                // Handle collections action
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
                              icon: Icon(Icons.more_vert),
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
