// This is the new Favourites screen, refactored for BLoC and reusable widgets.
// TODO: Integrate BLoC and reusable widgets as needed.
// ...existing code from Favourites.dart (to be migrated here)...

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC State
abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<Map<String, String>> favourites;
  FavouritesLoaded(this.favourites);
}

class FavouritesError extends FavouritesState {
  final String message;
  FavouritesError(this.message);
}

// BLoC Event
abstract class FavouritesEvent {}

class LoadFavourites extends FavouritesEvent {}

// BLoC
class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<LoadFavourites>((event, emit) async {
      emit(FavouritesLoading());
      try {
        // Simulate loading from a repository or database
        await Future.delayed(const Duration(milliseconds: 500));
        final favourites = [
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
        emit(FavouritesLoaded(favourites));
      } catch (e) {
        emit(FavouritesError('Error loading favourites: $e'));
      }
    });
  }
}

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return BlocProvider(
      create: (_) => FavouritesBloc()..add(LoadFavourites()),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Favourites'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
        ),
        body: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if (state is FavouritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavouritesLoaded) {
              if (state.favourites.isEmpty) {
                return Center(
                  child: Text(
                    'No favourites yet.',
                    style: theme.textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.favourites.length,
                itemBuilder: (context, index) {
                  final book = state.favourites[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
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
            } else if (state is FavouritesError) {
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
// - Use BLoC for favourites state if needed.
// - Use reusable widgets for favourite items.
// - Add list, empty state, and error handling as needed.
// - Remove TODOs as you implement logic.
