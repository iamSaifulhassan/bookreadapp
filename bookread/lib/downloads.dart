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
    return Scaffold(
      appBar: AppBar(title: Text('Downloads')),
      drawer: CustomDrawer(),
      body:
          _downloads.isEmpty
              ? Center(child: Text('No downloads found'))
              : ListView.builder(
                itemCount: _downloads.length,
                itemBuilder: (context, index) {
                  final file = _downloads[index];
                  return ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    title: Text(file.path.split(Platform.pathSeparator).last),
                    onTap: () {
                      // Handle file tap
                    },
                  );
                },
              ),
    );
  }
}
