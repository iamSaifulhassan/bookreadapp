import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../repositories/book_list_repository.dart';
import '../../services/streak_service.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_spacing.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/streak_widget.dart';
import '../book_content/book_content_screen.dart';

/// A single screen shared by the Favourites, Read Later, and Completed
/// routes. Each previously duplicated ~500 lines of near-identical
/// SharedPreferences loading, card layout, and grid/list toggling; the only
/// real differences were which list was "primary" (i.e. which one filters
/// what's shown) and a handful of per-screen strings/colors/icons, all of
/// which are parameterized here via [type].
class BookListScreen extends StatefulWidget {
  final BookListType type;

  const BookListScreen({super.key, required this.type});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final _repo = BookListRepository();

  Map<BookListType, Set<String>> _status = {
    BookListType.favourites: {},
    BookListType.readLater: {},
    BookListType.completed: {},
  };
  List<File> _files = [];
  bool _loading = true;
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    StreakService().loadStreaks();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    final results = await Future.wait([
      _repo.getPaths(BookListType.favourites),
      _repo.getPaths(BookListType.readLater),
      _repo.getPaths(BookListType.completed),
    ]);
    _status = {
      BookListType.favourites: results[0],
      BookListType.readLater: results[1],
      BookListType.completed: results[2],
    };
    _refreshFiles();
    if (mounted) setState(() => _loading = false);
  }

  void _refreshFiles() {
    _files =
        _status[widget.type]!
            .where((p) => File(p).existsSync())
            .map((p) => File(p))
            .toList();
  }

  Future<void> _toggle(BookListType type, String path) async {
    final wasCompleted =
        type == BookListType.completed &&
        _status[BookListType.completed]!.contains(path);
    final updated = await _repo.toggle(type, path);
    if (!mounted) return;
    setState(() {
      _status[type] = updated;
      if (type == widget.type) _refreshFiles();
    });
    if (type == BookListType.completed) {
      if (wasCompleted) {
        await StreakService().markDocumentNotCompleted(path);
      } else {
        await StreakService().markDocumentCompleted(path);
      }
    }
  }

  Future<void> _shareFile(String path) async {
    await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
  }

  String _getFileDate(String path) {
    try {
      final file = File(path);
      final formatted = DateFormat(
        'yyyy-MM-dd HH:mm',
      ).format(file.statSync().modified);
      return AppLocalizations.of(context)!.modifiedLabel(formatted);
    } catch (_) {
      return '';
    }
  }

  String _getExt(File file) {
    final fileName = file.path.split('/').last;
    return fileName.contains('.') ? fileName.split('.').last : '';
  }

  // --- Per-type presentation -------------------------------------------

  Color _accentColor() => switch (widget.type) {
    BookListType.favourites => AppColors.primary,
    BookListType.readLater => AppColors.secondary,
    BookListType.completed => AppColors.success,
  };

  Color _onAccentColor() => switch (widget.type) {
    BookListType.favourites => AppColors.onPrimary,
    BookListType.readLater => AppColors.onSecondary,
    BookListType.completed => AppColors.onSuccess,
  };

  IconData _coverIcon() =>
      widget.type == BookListType.readLater ? Icons.bookmark : Icons.book;

  String _appBarTitle(AppLocalizations l10n) => switch (widget.type) {
    BookListType.favourites => l10n.favouritesTitle,
    BookListType.readLater => l10n.readLaterTitle,
    BookListType.completed => l10n.completedBooksTitle,
  };

  IconData _emptyIcon() => switch (widget.type) {
    BookListType.favourites => Icons.favorite_border,
    BookListType.readLater => Icons.bookmark_border,
    BookListType.completed => Icons.check_circle_outline,
  };

  String _emptyTitle(AppLocalizations l10n) => switch (widget.type) {
    BookListType.favourites => l10n.noFavouriteBooksYet,
    BookListType.readLater => l10n.noBooksToReadLater,
    BookListType.completed => l10n.noCompletedBooksYet,
  };

  String _emptyHint(AppLocalizations l10n) => switch (widget.type) {
    BookListType.favourites => l10n.addBooksToFavouritesHint,
    BookListType.readLater => l10n.addBooksToReadLaterHint,
    BookListType.completed => l10n.completedBooksHint,
  };

  // --- Cards --------------------------------------------------------------

  Widget _buildCover(
    File file, {
    required double? width,
    required double? height,
    required double iconSize,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_accentColor().withValues(alpha: 0.8), _accentColor()],
        ),
      ),
      child:
          widget.type == BookListType.completed
              ? Stack(
                children: [
                  Center(
                    child: Icon(
                      _coverIcon(),
                      color: _onAccentColor(),
                      size: iconSize,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.success,
                        size: iconSize * 0.3,
                      ),
                    ),
                  ),
                ],
              )
              : Center(
                child: Icon(_coverIcon(), color: _onAccentColor(), size: iconSize),
              ),
    );
  }

  Widget _buildActionsRow(File file, {required double iconSize}) {
    final l10n = AppLocalizations.of(context)!;
    final isFavourite = _status[BookListType.favourites]!.contains(file.path);
    final isReadLater = _status[BookListType.readLater]!.contains(file.path);
    final isCompleted = _status[BookListType.completed]!.contains(file.path);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            isFavourite ? Icons.favorite : Icons.favorite_border,
            size: iconSize,
            color: isFavourite ? AppColors.error : null,
          ),
          tooltip:
              isFavourite
                  ? l10n.removeFromFavouritesTooltip
                  : l10n.favouriteTooltip,
          onPressed: () => _toggle(BookListType.favourites, file.path),
        ),
        IconButton(
          icon: Icon(
            isReadLater ? Icons.bookmark : Icons.bookmark_border,
            size: iconSize,
            color: isReadLater ? AppColors.secondary : null,
          ),
          tooltip:
              isReadLater
                  ? l10n.removeFromReadLaterTooltip
                  : l10n.readLaterTooltip,
          onPressed: () => _toggle(BookListType.readLater, file.path),
        ),
        IconButton(
          icon: Icon(
            isCompleted ? Icons.check_circle : Icons.check_circle_outline,
            size: iconSize,
            color: isCompleted ? AppColors.success : null,
          ),
          tooltip:
              isCompleted
                  ? l10n.removeFromCompletedTooltip
                  : l10n.markAsCompletedTooltip,
          onPressed: () => _toggle(BookListType.completed, file.path),
        ),
        IconButton(
          icon: Icon(Icons.share, size: iconSize),
          tooltip: l10n.commonShare,
          onPressed: () => _shareFile(file.path),
        ),
      ],
    );
  }

  Widget _buildFileCard(File file) {
    final l10n = AppLocalizations.of(context)!;
    final fileName = file.path.split('/').last;
    final displayName =
        fileName.length > 25 ? '${fileName.substring(0, 22)}...' : fileName;
    final isCompleted = _status[BookListType.completed]!.contains(file.path);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm2,
        vertical: AppSpacing.xs,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      BookContentScreen(filePath: file.path, fileName: fileName),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildCover(file, width: 50, height: 70, iconSize: 24),
                  const SizedBox(width: AppSpacing.sm2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            StreakWidget(
                              streakCount: StreakService().getCurrentStreakCount(
                                file.path,
                              ),
                              isAboutToExpire: StreakService()
                                  .isStreakAboutToExpire(file.path),
                              isCompleted: isCompleted,
                              iconSize: 18,
                              fontSize: 14,
                            ),
                            if (StreakService().getCurrentStreakCount(
                                  file.path,
                                ) >
                                0)
                              const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                displayName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                fileName,
                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _accentColor().withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _accentColor().withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                _getExt(file).toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _accentColor(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        if (widget.type == BookListType.completed)
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 14,
                                color: AppColors.success,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                l10n.completedStatusLabel,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  _getFileDate(file.path),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            _getFileDate(file.path),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildActionsRow(file, iconSize: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(File file) {
    final fileName = file.path.split('/').last;
    final displayName =
        fileName.length > 20 ? '${fileName.substring(0, 17)}...' : fileName;
    final isCompleted = _status[BookListType.completed]!.contains(file.path);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(AppSpacing.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      BookContentScreen(filePath: file.path, fileName: fileName),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            children: [
              Expanded(
                child: _buildCover(
                  file,
                  width: double.infinity,
                  height: null,
                  iconSize: 40,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreakWidget(
                    streakCount: StreakService().getCurrentStreakCount(
                      file.path,
                    ),
                    isAboutToExpire: StreakService().isStreakAboutToExpire(
                      file.path,
                    ),
                    isCompleted: isCompleted,
                    iconSize: 16,
                    fontSize: 12,
                  ),
                  if (StreakService().getCurrentStreakCount(file.path) > 0)
                    const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _getExt(file).toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildActionsRow(file, iconSize: 18),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle(l10n)),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
            tooltip: _isGrid ? l10n.listViewTooltip : l10n.gridViewTooltip,
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body:
          _files.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _emptyIcon(),
                        size: 64,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.38),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        _emptyTitle(l10n),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        _emptyHint(l10n),
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
              : _isGrid
              ? GridView.builder(
                padding: const EdgeInsets.all(AppSpacing.sm),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.62,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                ),
                itemCount: _files.length,
                itemBuilder: (context, index) => _buildGridCard(_files[index]),
              )
              : ListView.builder(
                itemCount: _files.length,
                itemBuilder: (context, index) => _buildFileCard(_files[index]),
              ),
    );
  }
}
