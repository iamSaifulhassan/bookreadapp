import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import '../book_content_screen.dart';

// BLoC State
abstract class DownloadsState {}

class DownloadsInitial extends DownloadsState {}

class DownloadsLoading extends DownloadsState {}

class DownloadsLoaded extends DownloadsState {
  final List<FileSystemEntity> downloads;
  DownloadsLoaded(this.downloads);
}

class DownloadsError extends DownloadsState {
  final String message;
  DownloadsError(this.message);
}

// BLoC Event
abstract class DownloadsEvent {}

class LoadDownloads extends DownloadsEvent {}

// BLoC
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  DownloadsBloc() : super(DownloadsInitial()) {
    on<LoadDownloads>((event, emit) async {
      emit(DownloadsLoading());
      try {
        final directory = await getApplicationDocumentsDirectory();
        final downloadsDir = Directory('${directory.path}/downloads');
        if (await downloadsDir.exists()) {
          final files = downloadsDir.listSync().whereType<File>().toList();
          emit(DownloadsLoaded(files));
        } else {
          emit(DownloadsLoaded([]));
        }
      } catch (e) {
        emit(DownloadsError('Error loading downloads: $e'));
      }
    });
  }
}

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return BlocProvider(
      create: (_) => DownloadsBloc()..add(LoadDownloads()),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Downloads'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
        ),
        body: BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            if (state is DownloadsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DownloadsLoaded) {
              if (state.downloads.isEmpty) {
                return Center(
                  child: Text(
                    'No downloads found',
                    style: theme.textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.downloads.length,
                itemBuilder: (context, index) {
                  final file = state.downloads[index];
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
                        final fileName =
                            file.path.split(Platform.pathSeparator).last;
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
                    ),
                  );
                },
              );
            } else if (state is DownloadsError) {
              return Center(
                child: Text(state.message, style: TextStyle(color: Colors.red)),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// Guidance:
// - Use BLoC for download state if needed.
// - Use reusable widgets for download items.
// - Add list, empty state, and error handling as needed.
// - Remove TODOs as you implement logic.
