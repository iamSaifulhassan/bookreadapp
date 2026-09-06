import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_spacing.dart';

/// The zoom/bookmark/more-menu bar pinned to the bottom of the reading
/// screen. Extracted from book_content_screen.dart's build methods.
class BottomDocumentControls extends StatelessWidget {
  final bool isPdfFile;
  final double zoomLevel;
  final bool isBookmarked;
  final bool hasBookmarkedPages;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onResetZoom;
  final VoidCallback onToggleBookmark;
  final VoidCallback onShowBookmarks;
  final VoidCallback onTakeSnapshot;
  final VoidCallback onGoToPage;

  final String zoomInLabel;
  final String zoomOutLabel;
  final String resetLabel;
  final String bookmarkLabel;
  final String moreLabel;
  final String bookmarksDialogTitle;
  final String snapshotLabel;
  final String goToPageLabel;

  const BottomDocumentControls({
    super.key,
    required this.isPdfFile,
    required this.zoomLevel,
    required this.isBookmarked,
    required this.hasBookmarkedPages,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onResetZoom,
    required this.onToggleBookmark,
    required this.onShowBookmarks,
    required this.onTakeSnapshot,
    required this.onGoToPage,
    required this.zoomInLabel,
    required this.zoomOutLabel,
    required this.resetLabel,
    required this.bookmarkLabel,
    required this.moreLabel,
    required this.bookmarksDialogTitle,
    required this.snapshotLabel,
    required this.goToPageLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isPdfFile) ...[
              Expanded(
                child: _BottomButton(
                  icon: Icons.zoom_in,
                  label: zoomInLabel,
                  onTap: zoomLevel < 3.0 ? onZoomIn : null,
                ),
              ),
              Expanded(
                child: _BottomButton(
                  icon: Icons.zoom_out,
                  label: zoomOutLabel,
                  onTap: zoomLevel > 0.5 ? onZoomOut : null,
                ),
              ),
              Expanded(
                child: _BottomButton(
                  icon: Icons.center_focus_strong,
                  label: resetLabel,
                  onTap: zoomLevel != 1.0 ? onResetZoom : null,
                ),
              ),
            ],
            Expanded(
              child: _BottomButton(
                icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                label: bookmarkLabel,
                onTap: onToggleBookmark,
                isActive: isBookmarked,
              ),
            ),
            Expanded(
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'bookmarks':
                      onShowBookmarks();
                      break;
                    case 'snapshot':
                      onTakeSnapshot();
                      break;
                    case 'go_to_page':
                      if (isPdfFile) onGoToPage();
                      break;
                  }
                },
                offset: const Offset(0, -20), // Show above the button
                constraints: const BoxConstraints(maxWidth: 150, minWidth: 120),
                itemBuilder:
                    (context) => [
                      if (hasBookmarkedPages)
                        PopupMenuItem(
                          value: 'bookmarks',
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.bookmarks, size: 18),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  bookmarksDialogTitle,
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      PopupMenuItem(
                        value: 'snapshot',
                        height: 40,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.camera_alt_outlined, size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                snapshotLabel,
                                style: const TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isPdfFile)
                        PopupMenuItem(
                          value: 'go_to_page',
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.my_location, size: 18),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  goToPageLabel,
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                child: _BottomButton(
                  icon: Icons.more_vert,
                  label: moreLabel,
                  onTap: null, // Let PopupMenuButton handle the tap
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isActive;

  const _BottomButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.1) : null,
          borderRadius: BorderRadius.circular(8),
          border:
              isActive
                  ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
                  : null,
        ),
        // mainAxisSize.min plus an unbounded Text used to overflow the
        // surrounding Row once labels ran long in some languages — each
        // button lives in an Expanded slot (see caller) and this Text
        // shrinks/truncates instead of pushing past it.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color:
                  onTap != null
                      ? (isActive
                          ? AppColors.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant)
                      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color:
                    onTap != null
                        ? (isActive
                            ? AppColors.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant)
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
