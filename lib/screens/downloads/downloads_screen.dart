import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import '../Bookcontentreading/book_content_screen.dart';
import '../../l10n/generated/app_localizations.dart';

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
        emit(DownloadsError(e.toString()));
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
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => DownloadsBloc()..add(LoadDownloads()),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(l10n.downloadsTitle),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
        ),
        body: BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _buildBody(context, state, theme, l10n),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    DownloadsState state,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final colorScheme = theme.colorScheme;
    if (state is DownloadsLoading) {
      return const Center(
        key: ValueKey('loading'),
        child: CircularProgressIndicator(),
      );
    } else if (state is DownloadsLoaded) {
      if (state.downloads.isEmpty) {
        return Center(
          key: const ValueKey('empty'),
          child: Text(l10n.noDownloadsFound, style: theme.textTheme.bodyLarge),
        );
      }
      return ListView.builder(
        key: const ValueKey('loaded'),
        itemCount: state.downloads.length,
        itemBuilder: (context, index) {
          final file = state.downloads[index];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 250 + index * 40),
            curve: Curves.easeOutCubic,
            builder:
                (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 12),
                    child: child,
                  ),
                ),
            child: Card(
              color: colorScheme.surface,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  final fileName = file.path.split(Platform.pathSeparator).last;
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
            ),
          );
        },
      );
    } else if (state is DownloadsError) {
      return Center(
        key: const ValueKey('error'),
        child: Text(
          l10n.errorLoadingDownloads(state.message),
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    return const SizedBox.shrink(key: ValueKey('empty-initial'));
  }
}
