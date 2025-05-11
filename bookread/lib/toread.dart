import 'package:bookread/main.dart';
import 'package:flutter/material.dart';

class ToReadScreen extends StatelessWidget {
  final List<Map<String, String>> toReadBooks = [
    {
      'title': 'Book 1',
      'lastOpened': 'Added: 2 days ago',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Book 2',
      'lastOpened': 'Added: 5 days ago',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Book 3',
      'lastOpened': 'Added: 1 week ago',
      'image': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Read'),
        backgroundColor: Colors.deepPurple.shade400,
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawer(),
      body: ListView.builder(
        itemCount: toReadBooks.length,
        itemBuilder: (context, index) {
          final book = toReadBooks[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      book['image']!,
                      width: 80,
                      height: 120, // Adjusted for a portrait-like aspect ratio
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 80);
                      },
                    ),
                  ),
                  SizedBox(width: 8),
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
                        SizedBox(height: 4),
                        Text(
                          book['lastOpened']!,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check_circle_outline),
                              onPressed: () {
                                // Handle mark as read action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () {
                                // Handle remove from list action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
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
