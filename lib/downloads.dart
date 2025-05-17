import 'dart:io';
import 'package:bookread/main.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  _DownloadsScreenState createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  List<FileSystemEntity> _downloads = [];

  @override
  void initState() {
    super.initState();
    _loadDownloads();
  }

  Future<void> _loadDownloads() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory('${directory.path}/downloads');
      if (await downloadsDir.exists()) {
        setState(() {
          _downloads = downloadsDir.listSync().whereType<File>().toList();
        });
      } else {
        setState(() {
          _downloads = [];
        });
      }
    } catch (e) {
      print('Error loading downloads: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Downloads',
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      drawer: CustomDrawer(),
      body: Container(
        color: colorScheme.surface,
        child:
            _downloads.isEmpty
                ? Center(
                  child: Text(
                    'No downloads found',
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                )
                : ListView.builder(
                  itemCount: _downloads.length,
                  itemBuilder: (context, index) {
                    final file = _downloads[index];
                    return Card(
                      color: colorScheme.surface,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.insert_drive_file,
                          color: colorScheme.primary,
                        ),
                        title: Text(
                          file.path.split(Platform.pathSeparator).last,
                          style: TextStyle(color: colorScheme.onSurface),
                        ),
                        onTap: () {
                          // Handle file tap
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
