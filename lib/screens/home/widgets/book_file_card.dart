import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../services/streak_service.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_spacing.dart';
import '../../../widgets/streak_widget.dart';
import '../../book_content/book_content_screen.dart';
import '../home_screen.dart' show BookFile;

/// A single book entry in the library grid/list. Extracted from
/// home_screen.dart, which previously built both the grid and list card
/// layouts (plus the favourite/read-later/completed/share/delete actions)
/// inline as ~450 lines split across two methods.
///
/// Deliberately stateless: all "is this favourited/etc." status and every
/// action is passed in, so this widget only knows how to render a card and
/// report taps — the actual list/prefs mutation stays owned by whoever
/// shows it (home_screen.dart today).
class BookFileCard extends StatelessWidget {
  final BookFile file;
  final int? index;
  final bool isGrid;
  final bool isFavourite;
  final bool isReadLater;
  final bool isCompleted;
  final String fileDate;
  final VoidCallback onToggleFavourite;
  final VoidCallback onToggleReadLater;
  final VoidCallback onToggleCompleted;
  final VoidCallback onShare;
  /// Null hides the delete action entirely (not offered in grid mode today).
  final VoidCallback? onDelete;

  const BookFileCard({
    super.key,
    required this.file,
    required this.index,
    required this.isGrid,
    required this.isFavourite,
    required this.isReadLater,
    required this.isCompleted,
    required this.fileDate,
    required this.onToggleFavourite,
    required this.onToggleReadLater,
    required this.onToggleCompleted,
    required this.onShare,
    this.onDelete,
  });

  Widget _buildCover(BuildContext context) {
    if (file.extension == 'txt') {
      return Icon(
        Icons.description,
        size: isGrid ? 60 : 48,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Image.asset(
        'assets/images/applogo.png',
        key: ValueKey(file.path),
        width: isGrid ? 80 : 48,
        height: isGrid ? 110 : 64,
        fit: BoxFit.cover,
      ),
    );
  }

  void _openBook(BuildContext context) {
    if (file.path == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                BookContentScreen(filePath: file.path!, fileName: file.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cover = _buildCover(context);
    return isGrid ? _buildGridCard(context, cover) : _buildListCard(context, cover);
  }

  Widget _buildGridCard(BuildContext context, Widget cover) {
    return GestureDetector(
      onTap: () => _openBook(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: AspectRatio(
          aspectRatio: 0.68,
          child: Card(
            elevation: 2,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              // Scrolls instead of hard-overflowing if a longer translated
              // title, a larger accessibility text-scale setting, or a
              // narrower device ever makes this content taller than the
              // grid cell again.
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: cover,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (file.path != null)
                          StreakWidget(
                            streakCount: StreakService().getCurrentStreakCount(
                              file.path!,
                            ),
                            isAboutToExpire: StreakService()
                                .isStreakAboutToExpire(file.path!),
                            isCompleted: isCompleted,
                            iconSize: 16,
                            fontSize: 12,
                          ),
                        if (file.path != null &&
                            StreakService().getCurrentStreakCount(file.path!) >
                                0)
                          const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            file.name,
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
                    const SizedBox(height: 4),
                    Text(
                      file.extension?.toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textDisabled,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: onToggleFavourite,
                          child: Icon(
                            isFavourite ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color:
                                isFavourite
                                    ? AppColors.error
                                    : AppColors.textDisabled,
                          ),
                        ),
                        InkWell(
                          onTap: onToggleReadLater,
                          child: Icon(
                            isReadLater ? Icons.bookmark : Icons.bookmark_border,
                            size: 18,
                            color:
                                isReadLater
                                    ? AppColors.secondary
                                    : AppColors.textDisabled,
                          ),
                        ),
                        InkWell(
                          onTap: onToggleCompleted,
                          child: Icon(
                            isCompleted
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            size: 18,
                            color:
                                isCompleted
                                    ? AppColors.success
                                    : AppColors.textDisabled,
                          ),
                        ),
                        InkWell(
                          onTap: onShare,
                          child: Icon(
                            Icons.share,
                            size: 18,
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context, Widget cover) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(bottom: AppSpacing.sm2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => _openBook(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(8), child: cover),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (file.path != null)
                            StreakWidget(
                              streakCount: StreakService()
                                  .getCurrentStreakCount(file.path!),
                              isAboutToExpire: StreakService()
                                  .isStreakAboutToExpire(file.path!),
                              isCompleted: isCompleted,
                              iconSize: 18,
                              fontSize: 14,
                            ),
                          if (file.path != null &&
                              StreakService().getCurrentStreakCount(
                                    file.path!,
                                  ) >
                                  0)
                            const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              file.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.inputFill,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              file.extension?.toUpperCase() ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fileDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textDisabled,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              isReadLater ? Icons.bookmark : Icons.bookmark_border,
                              size: 20,
                              color: isReadLater ? AppColors.secondary : null,
                            ),
                            tooltip: l10n.readLaterTooltip,
                            onPressed: onToggleReadLater,
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, size: 20),
                            tooltip: l10n.commonShare,
                            onPressed: onShare,
                          ),
                          if (onDelete != null)
                            IconButton(
                              icon: const Icon(Icons.delete_outline, size: 20),
                              tooltip: l10n.removeFromListTooltip,
                              onPressed: onDelete,
                            ),
                          IconButton(
                            icon: Icon(
                              isFavourite ? Icons.favorite : Icons.favorite_border,
                              size: 20,
                              color: isFavourite ? AppColors.error : null,
                            ),
                            tooltip:
                                isFavourite
                                    ? l10n.removeFromFavouritesTooltip
                                    : l10n.addToFavouritesTooltip,
                            onPressed: onToggleFavourite,
                          ),
                          IconButton(
                            icon: Icon(
                              isCompleted
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              size: 20,
                              color: isCompleted ? AppColors.success : null,
                            ),
                            tooltip:
                                isCompleted
                                    ? l10n.removeFromCompletedTooltip
                                    : l10n.markAsCompletedTooltip,
                            onPressed: onToggleCompleted,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
