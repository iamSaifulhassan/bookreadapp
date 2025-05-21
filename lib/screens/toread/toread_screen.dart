// This is the new ToRead screen, refactored for BLoC and reusable widgets.
// TODO: Integrate BLoC and reusable widgets as needed.
// ...existing code from toread.dart (to be migrated here)...

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC State
abstract class ToReadState {}

class ToReadInitial extends ToReadState {}

class ToReadLoading extends ToReadState {}

class ToReadLoaded extends ToReadState {
  final List<Map<String, String>> books;
  ToReadLoaded(this.books);
}

class ToReadError extends ToReadState {
  final String message;
  ToReadError(this.message);
}

// BLoC Event
abstract class ToReadEvent {}

class LoadToRead extends ToReadEvent {}

// BLoC
class ToReadBloc extends Bloc<ToReadEvent, ToReadState> {
  ToReadBloc() : super(ToReadInitial()) {
    on<LoadToRead>((event, emit) async {
      emit(ToReadLoading());
      try {
        // Simulate loading from a repository or database
        await Future.delayed(const Duration(milliseconds: 500));
        final books = [
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
        emit(ToReadLoaded(books));
      } catch (e) {
        emit(ToReadError('Error loading to-read books: $e'));
      }
    });
  }
}

class ToReadScreen extends StatelessWidget {
  const ToReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return BlocProvider(
      create: (_) => ToReadBloc()..add(LoadToRead()),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('To Read'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
        ),
        body: BlocBuilder<ToReadBloc, ToReadState>(
          builder: (context, state) {
            if (state is ToReadLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ToReadLoaded) {
              if (state.books.isEmpty) {
                return Center(
                  child: Text(
                    'No books in your to-read list yet.',
                    style: theme.textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    elevation: 2,
                    color: colorScheme.surface,
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
                                    color: colorScheme.onSurface.withOpacity(
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
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  book['lastOpened']!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface.withOpacity(
                                      0.7,
                                    ),
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
              );
            } else if (state is ToReadError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
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
// - Use BLoC for to-read state if needed.
// - Use reusable widgets for book items.
// - Add list, empty state, and error handling as needed.
// - Remove TODOs as you implement logic.
