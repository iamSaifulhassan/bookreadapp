import '../../services/app_logger.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_spacing.dart';
import '../../services/streak_service.dart';
import '../../services/settings_service.dart';
import '../../services/locale_service.dart';
import '../../l10n/generated/app_localizations.dart';
import 'reading_text_utils.dart';
import 'widgets/tts_controls_bar.dart';
import 'widgets/bottom_document_controls.dart';
import 'widgets/tts_settings_sheet.dart';

class BookContentScreen extends StatefulWidget {
  final String filePath;
  final String fileName;

  const BookContentScreen({
    super.key,
    required this.filePath,
    required this.fileName,
  });

  @override
  State<BookContentScreen> createState() => _BookContentScreenState();
}

class _BookContentScreenState extends State<BookContentScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {// Core Controllers
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController? _pdfController;
  FlutterTts? _tts;
  final SettingsService _settingsService = SettingsService();

  // Animation Controllers
  late AnimationController _textBufferController;
  late AnimationController _controlsController;
  late Animation<double> _textBufferHeight;
  late Animation<double> _controlsOpacity;

  // Core State
  bool _isInitialized = false;
  bool _isLoading = true;
  String? _errorMessage;
  // PDF State
  int _currentPage = 1;
  int _totalPages = 1;

  // Text & TTS State
  String _currentTtsLocale = 'en-US';
  List<String> _sentences = [];
  int _currentSentenceIndex = 0;
  bool _isPlaying = false;
  bool _isPaused = false;
  bool _showTextBuffer = false;  // TTS Settings
  double _speechRate = 0.5;
  double _pitch = 1.0;
  double _volume = 0.8;
  
  // Reading Settings
  double _readingFontSize = 16.0;
  double _readingLineHeight = 1.5;
  // PDF Features
  double _zoomLevel = 1.0;
  bool _isBookmarked = false;
  final List<int> _bookmarkedPages = [];
  final GlobalKey _repaintBoundaryKey = GlobalKey();

  // Rolling TTS Buffer state
  List<String> _ttsBuffer = [];
  final int _bufferSize = 5; // Show 5 sentences at a time
  final int _highlightedIndex = 2; // Middle position (0-indexed)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeAnimations();
    _initializeApp();
    // Record that this document was opened for streak tracking
    StreakService().recordDocumentOpened(widget.filePath);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh reading settings when app resumes (user might have changed settings)
      _refreshReadingSettings();
    }
  }

  void _initializeAnimations() {
    _textBufferController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _controlsController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _textBufferHeight = Tween<double>(begin: 0.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _textBufferController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _controlsOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controlsController);

    _controlsController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
          _errorMessage = null;
        });
      }

      // Validate file
      if (!_fileExists) {
        throw Exception('File not found: ${widget.filePath}');
      }

      // Initialize PDF controller
      _pdfController = PdfViewerController();

      // Initialize TTS
      await _initializeTTS();

      // Load content
      if (_isPdfFile) {
        await _loadPdfContent();
      } else if (_isTxtFile) {
        await _loadTxtContent();
      } else {
        // Safe to touch context here (unlike at the top of this method):
        // at least one await above has already yielded, so initState has
        // long finished by the time this branch can run.
        if (!mounted) return;
        throw Exception(
          AppLocalizations.of(context)!.unsupportedFileFormatMessage,
        );
      }
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  /// Fallback TTS locale when a book's language can't be confidently
  /// detected from its text (e.g. the page is too short). Uses the app's
  /// current UI language as a reasonable guess.
  String _ttsLocaleForApp() {
    final languageCode =
        LocaleService().currentLocale.value?.languageCode ??
        Localizations.localeOf(context).languageCode;
    return ttsLocaleByLanguage[languageCode] ?? 'en-US';
  }

  /// Detects the current page/document's language and repoints TTS at it,
  /// if it differs from whatever locale TTS is currently using.
  Future<void> _updateTtsLanguageFromText(String text) async {
    if (_tts == null) return;
    final detected = detectTtsLocale(text, fallbackLocale: _ttsLocaleForApp());
    if (detected != _currentTtsLocale) {
      _currentTtsLocale = detected;
      await _tts!.setLanguage(detected);
    }
  }

  /// Urdu is conventionally set in the Nastaliq calligraphic style, which
  /// looks broken in a generic Naskh/Latin font. Noto Nastaliq Urdu is
  /// Google's open-source (OFL) Nastaliq font, fetched and cached on demand
  /// by the google_fonts package — applied to any page whose detected
  /// language is Urdu.
  TextStyle _readingTextStyle(TextStyle base) =>
      _currentTtsLocale == 'ur-PK'
          ? GoogleFonts.notoNastaliqUrdu(textStyle: base)
          : base;

  Future<void> _initializeTTS() async {
    try {
      _tts = FlutterTts();

      // Load TTS settings from settings service
      _speechRate = await _settingsService.getTTSSpeechRate();
      _pitch = await _settingsService.getTTSPitch();
      _volume = await _settingsService.getTTSVolume();

      // Load reading settings from settings service
      _readingFontSize = await _settingsService.getReadingFontSize();
      _readingLineHeight = await _settingsService.getReadingLineHeight();

      // Starting guess only — _updateTtsLanguageFromText repoints this at
      // the book's actual language once its text has been extracted.
      _currentTtsLocale = _ttsLocaleForApp();
      await _tts!.setLanguage(_currentTtsLocale);
      await _tts!.setSpeechRate(_speechRate);
      await _tts!.setPitch(_pitch);
      await _tts!.setVolume(_volume);

      _tts!.setStartHandler(() {
        if (mounted) {
          setState(() {
            _isPlaying = true;
            _isPaused = false;
          });
        }
      });

      _tts!.setCompletionHandler(() {
        if (mounted && _isPlaying && !_isPaused) {
          _moveToNextSentence();
        }
      });

      _tts!.setPauseHandler(() {
        if (mounted) {
          setState(() {
            _isPaused = true;
          });
        }
      });

      _tts!.setContinueHandler(() {
        if (mounted) {
          setState(() {
            _isPaused = false;
          });
        }
      });

      _tts!.setErrorHandler((message) {
        if (mounted) {
          _showSnackBar(
            AppLocalizations.of(context)!.ttsErrorMessage(message.toString()),
            isError: true,
          );
        }
      });
    } catch (e) {
      AppLogger.log('TTS initialization failed: $e');
    }
  }

  Future<void> _loadPdfContent() async {
    try {
      // Extract text from the first page
      await _extractTextFromCurrentPage();
    } catch (e) {
      throw Exception('Failed to load PDF content: $e');
    }
  }

  Future<void> _loadTxtContent() async {
    try {
      final file = File(widget.filePath);
      final content = await file.readAsString();
      await _updateTtsLanguageFromText(content);
      _processSentences(content);
    } catch (e) {
      throw Exception('Failed to load text content: $e');
    }
  }

  Future<void> _extractTextFromCurrentPage() async {
    if (!_isPdfFile || !_fileExists) return;

    try {
      final file = File(widget.filePath);
      final bytes = await file.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);

      _totalPages = document.pages.count;

      if (_currentPage >= 1 && _currentPage <= _totalPages) {
        final textExtractor = PdfTextExtractor(document);
        final pageText = textExtractor.extractText(
          startPageIndex: _currentPage - 1,
          endPageIndex: _currentPage - 1,
        );

        await _updateTtsLanguageFromText(pageText);
        _processSentences(pageText);
      }

      document.dispose();
    } catch (e) {
      AppLogger.log('Error extracting text from page $_currentPage: $e');
      if (mounted) {
        setState(() {
          _sentences = [
            AppLocalizations.of(context)!.unableToExtractTextMessage,
          ];
          _currentSentenceIndex = 0;
        });
      }
    }
  }

  void _processSentences(String text) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final sentences = processSentencesFromText(
      text,
      emptyTextMessage: l10n.noReadableTextMessage,
      noSentencesFoundMessage: l10n.noSentencesFoundMessage,
    );
    setState(() {
      _sentences = sentences;
      _currentSentenceIndex = 0;
      _updateTtsBuffer(); // Initialize rolling buffer
    });
  }

  // Rolling TTS Buffer Management
  void _updateTtsBuffer() {
    if (_sentences.isEmpty) {
      _ttsBuffer = [];
      return;
    }

    // Create a rolling buffer centered on current sentence
    _ttsBuffer = [];
    int startIndex = _currentSentenceIndex - _highlightedIndex;

    for (int i = 0; i < _bufferSize; i++) {
      int sentenceIndex = startIndex + i;
      if (sentenceIndex >= 0 && sentenceIndex < _sentences.length) {
        _ttsBuffer.add(_sentences[sentenceIndex]);
      } else {
        _ttsBuffer.add(''); // Empty placeholder for out-of-bounds
      }
    }
  }

  // File validation
  bool get _fileExists {
    try {
      return File(widget.filePath).existsSync();
    } catch (_) {
      return false;
    }
  }

  bool get _isPdfFile => widget.filePath.toLowerCase().endsWith('.pdf');
  bool get _isTxtFile => widget.filePath.toLowerCase().endsWith('.txt');

  // TTS Controls
  Future<void> _togglePlayPause() async {
    if (_tts == null || _sentences.isEmpty) return;
    try {
      if (_isPlaying) {
        if (_isPaused) {
          await _tts!.stop();
          if (mounted) {
            setState(() {
              _isPlaying = false;
              _isPaused = false;
            });
          }
        } else {
          await _tts!.pause();
        }
      } else {
        await _speakCurrentSentence();
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(
        AppLocalizations.of(context)!.ttsControlErrorMessage(e.toString()),
        isError: true,
      );
    }
  }

  Future<void> _speakCurrentSentence() async {
    if (_tts == null ||
        _sentences.isEmpty ||
        _currentSentenceIndex >= _sentences.length) {
      return;
    }

    try {
      await _tts!.speak(_sentences[_currentSentenceIndex]);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(
        AppLocalizations.of(context)!.ttsSpeakErrorMessage(e.toString()),
        isError: true,
      );
    }
  }

  Future<void> _stopReading() async {
    if (_tts == null) return;

    try {
      await _tts!.stop();
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _isPaused = false;
        });
      }
    } catch (e) {
      AppLogger.log('Error stopping TTS: $e');
    }
  }

  void _moveToPreviousSentence() {
    if (_currentSentenceIndex > 0) {
      if (mounted) {
        setState(() {
          _currentSentenceIndex--;
          _updateTtsBuffer(); // Update rolling buffer
        });
      }
      if (_isPlaying && !_isPaused) {
        _speakCurrentSentence();
      }
    }
  }

  void _moveToNextSentence() {
    if (_currentSentenceIndex < _sentences.length - 1) {
      if (mounted) {
        setState(() {
          _currentSentenceIndex++;
          _updateTtsBuffer(); // Update rolling buffer
        });
      }
      if (_isPlaying && !_isPaused) {
        _speakCurrentSentence();
      }
    } else {
      // End of sentences, stop reading
      _stopReading();
    }
  }

  // UI Controls
  void _toggleTextBuffer() {
    if (mounted) {
      setState(() {
        _showTextBuffer = !_showTextBuffer;
      });
    }

    if (_showTextBuffer) {
      _textBufferController.forward();
    } else {
      _textBufferController.reverse();
    }
  }

  // PDF Document Features
  void _zoomIn() {
    if (_pdfController != null && _zoomLevel < 3.0) {
      if (mounted) {
        setState(() {
          _zoomLevel += 0.25;
        });
      }
      _pdfController!.zoomLevel = _zoomLevel;
    }
  }

  void _zoomOut() {
    if (_pdfController != null && _zoomLevel > 0.5) {
      if (mounted) {
        setState(() {
          _zoomLevel -= 0.25;
        });
      }
      _pdfController!.zoomLevel = _zoomLevel;
    }
  }

  void _resetZoom() {
    if (_pdfController != null) {
      if (mounted) {
        setState(() {
          _zoomLevel = 1.0;
        });
      }
      _pdfController!.zoomLevel = _zoomLevel;
    }
  }

  void _toggleBookmark() {
    if (mounted) {
      setState(() {
        _isBookmarked = !_isBookmarked;
        if (_isBookmarked) {
          if (!_bookmarkedPages.contains(_currentPage)) {
            _bookmarkedPages.add(_currentPage);
          }
        } else {
          _bookmarkedPages.remove(_currentPage);
        }
      });

      final l10n = AppLocalizations.of(context)!;
      _showSnackBar(
        _isBookmarked
            ? l10n.pageBookmarkedMessage(_currentPage)
            : l10n.bookmarkRemovedMessage,
      );
    }
  }

  void _showBookmarks() {
    if (_bookmarkedPages.isEmpty) {
      _showSnackBar(
        AppLocalizations.of(context)!.noBookmarksYetMessage,
        isError: true,
      );
      return;
    }
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(l10n.bookmarksDialogTitle),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _bookmarkedPages.length,
                itemBuilder: (context, index) {
                  final page = _bookmarkedPages[index];
                  return ListTile(
                    leading: Icon(Icons.bookmark, color: AppColors.primary),
                    title: Text(l10n.pageLabel(page)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            _bookmarkedPages.remove(page);
                            if (page == _currentPage) {
                              _isBookmarked = false;
                            }
                          });
                        }
                        Navigator.pop(context);
                      },
                    ),
                    onTap: () {
                      _pdfController?.jumpToPage(page);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.closeButton),
              ),
            ],
          ),
    );
  }

  Future<void> _takeSnapshot() async {
    try {
      final RenderRepaintBoundary boundary =
          _repaintBoundaryKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        // Save snapshot to the same directory as the book
        await _saveSnapshotToFile(byteData);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(
        AppLocalizations.of(context)!.snapshotFailedMessage(e.toString()),
        isError: true,
      );
    }
  }

  Future<void> _saveSnapshotToFile(ByteData byteData) async {
    try {
      // Get the directory where the book is located
      final bookFile = File(widget.filePath);
      final bookDirectory = bookFile.parent;

      // Create filename with timestamp and page number
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final bookName = widget.fileName.replaceAll(
        RegExp(r'\.[^.]+$'),
        '',
      ); // Remove extension
      final fileName = '${bookName}_page${_currentPage}_$timestamp.png';

      // Create the snapshot file path
      final snapshotFile = File('${bookDirectory.path}/$fileName');

      // Write the image data to file
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      await snapshotFile.writeAsBytes(pngBytes);

      // Show success message with file location
      _showSnapshotSuccessDialog(snapshotFile.path);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(
        AppLocalizations.of(context)!.snapshotSaveFailedMessage(e.toString()),
        isError: true,
      );
    }
  }

  void _showSnapshotSuccessDialog(String filePath) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.success, size: 24),
                const SizedBox(width: 8),
                Text(l10n.snapshotSavedTitle),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.snapshotSavedBody),
                const SizedBox(height: 12),
                Text(
                  l10n.locationLabel,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  child: Text(
                    filePath,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.commonOk),
              ),
            ],
          ),
    );
  }

  void _goToPage() {
    final controller = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(l10n.goToPageTitle),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.pageNumberLabel(_totalPages),
                border: const OutlineInputBorder(),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.commonCancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final pageNumber = int.tryParse(controller.text);
                  if (pageNumber != null &&
                      pageNumber > 0 &&
                      pageNumber <= _totalPages) {
                    _pdfController?.jumpToPage(pageNumber);
                    Navigator.pop(context);
                  } else {
                    _showSnackBar(l10n.invalidPageNumberMessage, isError: true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Text(l10n.goButton),
              ),
            ],
          ),
    ).then((_) => controller.dispose());
  }

  // PDF Navigation
  void _onPageChanged(PdfPageChangedDetails details) {
    if (details.newPageNumber != _currentPage) {
      if (mounted) {
        setState(() {
          _currentPage = details.newPageNumber;
          _isBookmarked = _bookmarkedPages.contains(_currentPage);
        });
      }
      _extractTextFromCurrentPage();
    }
  }

  // Utility methods
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : AppColors.primary,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }
  void _showTTSSettings() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => TtsSettingsSheet(
            initialSpeechRate: _speechRate,
            initialPitch: _pitch,
            initialVolume: _volume,
            title: l10n.ttsSettingsSheetTitle,
            speechRateLabel: l10n.speechRateWithValue,
            pitchLabel: l10n.pitchWithValue,
            volumeLabel: l10n.volumeWithValue,
            resetButtonLabel: l10n.resetToDefaultButton,
            doneButtonLabel: l10n.doneButton,
            onSpeechRateChanged: (value) {
              _speechRate = value;
              _tts?.setSpeechRate(value);
              _settingsService.setTTSSpeechRate(value);
            },
            onPitchChanged: (value) {
              _pitch = value;
              _tts?.setPitch(value);
              _settingsService.setTTSPitch(value);
            },
            onVolumeChanged: (value) {
              _volume = value;
              _tts?.setVolume(value);
              _settingsService.setTTSVolume(value);
            },
            onReset: () {
              _speechRate = 0.5;
              _pitch = 1.0;
              _volume = 0.8;
              _tts?.setSpeechRate(_speechRate);
              _tts?.setPitch(_pitch);
              _tts?.setVolume(_volume);
              _settingsService.setTTSSpeechRate(_speechRate);
              _settingsService.setTTSPitch(_pitch);
              _settingsService.setTTSVolume(_volume);
            },
          ),
    );
  }

  // Method to refresh reading settings when they change in the settings screen
  Future<void> _refreshReadingSettings() async {
    try {
      final newFontSize = await _settingsService.getReadingFontSize();
      final newLineHeight = await _settingsService.getReadingLineHeight();
      
      if (mounted) {
        setState(() {
          _readingFontSize = newFontSize;
          _readingLineHeight = newLineHeight;
        });
      }
    } catch (e) {
      AppLogger.log('Error refreshing reading settings: $e');
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopReading();
    _textBufferController.dispose();
    _controlsController.dispose();
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomDocumentControls(
        isPdfFile: _isPdfFile,
        zoomLevel: _zoomLevel,
        isBookmarked: _isBookmarked,
        hasBookmarkedPages: _bookmarkedPages.isNotEmpty,
        onZoomIn: _zoomIn,
        onZoomOut: _zoomOut,
        onResetZoom: _resetZoom,
        onToggleBookmark: _toggleBookmark,
        onShowBookmarks: _showBookmarks,
        onTakeSnapshot: _takeSnapshot,
        onGoToPage: _goToPage,
        zoomInLabel: l10n.zoomInLabel,
        zoomOutLabel: l10n.zoomOutLabel,
        resetLabel: l10n.resetLabel,
        bookmarkLabel: l10n.bookmarkLabel,
        moreLabel: l10n.moreLabel,
        bookmarksDialogTitle: l10n.bookmarksDialogTitle,
        snapshotLabel: l10n.snapshotLabel,
        goToPageLabel: l10n.goToPageLabel,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final l10n = AppLocalizations.of(context)!;
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fileName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          if (_isPdfFile && _isInitialized)
            Text(
              l10n.pageOfPagesLabel(_currentPage, _totalPages),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
        ],
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 0,
      actions: [
        if (_sentences.isNotEmpty)
          IconButton(
            onPressed: _toggleTextBuffer,
            icon: Icon(
              _showTextBuffer
                  ? Icons.text_snippet
                  : Icons.text_snippet_outlined,
            ),
            tooltip: l10n.toggleTextBufferTooltip,
          ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'tts_settings':
                _showTTSSettings();
                break;
              case 'reload':
                _initializeApp();
                break;
            }
          },
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'tts_settings',
                  child: Row(
                    children: [
                      const Icon(Icons.settings_voice, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(l10n.ttsSettingsMenuItem),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'reload',
                  child: Row(
                    children: [
                      const Icon(Icons.refresh, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(l10n.reloadMenuItem),
                    ],
                  ),
                ),
              ],
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingScreen();
    }

    if (_errorMessage != null) {
      return _buildErrorScreen();
    }

    return Column(
      children: [
        // Text Buffer (when toggled) - with dynamic height calculation
        AnimatedBuilder(
          animation: _textBufferHeight,
          builder: (context, child) {
            if (!_showTextBuffer) {
              return const SizedBox.shrink();
            }

            // Get screen height and calculate safe text buffer height
            final screenHeight = MediaQuery.of(context).size.height;
            final appBarHeight =
                kToolbarHeight + MediaQuery.of(context).padding.top;
            // Calculate actual custom bottom navigation bar height
            // Container padding (vertical: 8 * 2) + button content (~54px) + SafeArea bottom
            const customBottomNavContentHeight =
                16 + 54; // Container padding + button content
            final bottomNavHeight =
                customBottomNavContentHeight +
                MediaQuery.of(context).padding.bottom;
            const ttsControlsHeight = 80.0;
            const minPdfViewerHeight = 100.0;

            final maxSafeHeight =
                screenHeight -
                appBarHeight -
                bottomNavHeight -
                ttsControlsHeight -
                minPdfViewerHeight;
            final safeTextBufferHeight = (_textBufferHeight.value).clamp(
              0.0,
              maxSafeHeight,
            );

            return SizedBox(
              height: safeTextBufferHeight,
              child: _buildTextBuffer(),
            );
          },
        ),

        // Main PDF/Text Viewer (always visible)
        Expanded(child: _buildMainViewer()),

        // TTS Controls (always visible but disabled if no sentences)
        _buildTtsControlsBar(),
      ],
    );
  }

  Widget _buildTtsControlsBar() {
    final l10n = AppLocalizations.of(context)!;
    return TtsControlsBar(
      opacity: _controlsOpacity,
      hasSentences: _sentences.isNotEmpty,
      canGoPrevious: _currentSentenceIndex > 0,
      canGoNext: _currentSentenceIndex < _sentences.length - 1,
      isPlaying: _isPlaying,
      isPaused: _isPaused,
      previousTooltip: l10n.previousSentenceTooltip,
      playTooltip: l10n.playTooltip,
      pauseTooltip: l10n.pauseTooltip,
      resumeTooltip: l10n.resumeTooltip,
      stopTooltip: l10n.stopTooltip,
      nextTooltip: l10n.nextSentenceTooltip,
      onPrevious: _moveToPreviousSentence,
      onTogglePlayPause: _togglePlayPause,
      onStop: _stopReading,
      onNext: _moveToNextSentence,
    );
  }

  Widget _buildLoadingScreen() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.loadingFileMessage(widget.fileName),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.initializingViewerMessage,
            style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.failedToLoadContentTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? l10n.unknownErrorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _initializeApp,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.commonRetry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainViewer() {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _isPdfFile ? _buildPDFViewer() : _buildTextViewer(),
      ),
    );
  }

  Widget _buildPDFViewer() {
    return RepaintBoundary(
      key: _repaintBoundaryKey,
      child: SfPdfViewer.file(
        File(widget.filePath),
        key: _pdfViewerKey,
        controller: _pdfController,
        onPageChanged: _onPageChanged,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        canShowScrollHead: false,
        canShowScrollStatus: false,
      ),
    );
  }

  Widget _buildTextViewer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          for (int i = 0; i < _sentences.length; i++)
            GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    _currentSentenceIndex = i;
                  });
                  if (_isPlaying && !_isPaused) {
                    _speakCurrentSentence();
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.sm2),
                decoration: BoxDecoration(
                  color:
                      i == _currentSentenceIndex
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      i == _currentSentenceIndex
                          ? Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                          )
                          : null,
                ),                child: Text(
                  _sentences[i],
                  style: _readingTextStyle(
                    TextStyle(
                      fontSize: _readingFontSize,
                      height: _readingLineHeight,
                      color:
                          i == _currentSentenceIndex
                              ? AppColors.primary
                              : Theme.of(context).colorScheme.onSurface,
                      fontWeight:
                          i == _currentSentenceIndex
                              ? FontWeight.w600
                              : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextBuffer() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
            ),
            child: Row(
              children: [
                Icon(Icons.text_snippet, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  l10n.readingBufferLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_currentSentenceIndex + 1} / ${_sentences.length}',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),

          // Rolling text content - Dynamic ListView
          Expanded(
            child:
                _ttsBuffer.isEmpty
                    ? Center(
                      child: Text(
                        l10n.noSentencesAvailableMessage,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(AppSpacing.sm2),
                      itemCount: _ttsBuffer.length,
                      itemBuilder: (context, index) {
                        final sentence = _ttsBuffer[index];
                        final isHighlighted = index == _highlightedIndex;
                        final isCompleted = index < _highlightedIndex;

                        // Skip empty placeholders with minimal space
                        if (sentence.isEmpty) {
                          return const SizedBox(height: 8);
                        }

                        // Determine status and colors
                        String label;
                        Color color;
                        IconData statusIcon;

                        if (isCompleted) {
                          label = l10n.sentenceStatusRead;
                          color = AppColors.success;
                          statusIcon = Icons.check_circle;
                        } else if (isHighlighted) {
                          label = l10n.sentenceStatusCurrent;
                          color = AppColors.primary;
                          statusIcon =
                              _isPlaying
                                  ? (_isPaused
                                      ? Icons.pause_circle
                                      : Icons.play_circle)
                                  : Icons.radio_button_unchecked;
                        } else {
                          label = l10n.sentenceStatusNext;
                          color = Theme.of(context).colorScheme.onSurfaceVariant;
                          statusIcon = Icons.radio_button_unchecked;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                          padding: const EdgeInsets.all(AppSpacing.sm2),
                          decoration: BoxDecoration(
                            color:
                                isHighlighted
                                    ? color.withValues(alpha: 0.1)
                                    : isCompleted
                                    ? AppColors.success.withValues(alpha: 0.05)
                                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.02),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  isHighlighted
                                      ? color.withValues(alpha: 0.4)
                                      : isCompleted
                                      ? AppColors.success.withValues(alpha: 0.2)
                                      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                              width: isHighlighted ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Status indicator row
                              Row(
                                children: [
                                  Icon(statusIcon, size: 16, color: color),
                                  const SizedBox(width: 6),
                                  Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: color,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (isHighlighted && _isPlaying)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: color.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        _isPaused
                                            ? l10n.pausedLabel
                                            : l10n.playingLabel,
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500,
                                          color: color,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              // Sentence text
                              GestureDetector(
                                onTap: isHighlighted ? _togglePlayPause : null,                                child: Text(
                                  sentence,
                                  style: _readingTextStyle(
                                    TextStyle(
                                      fontSize: isHighlighted ? _readingFontSize + 1 : _readingFontSize - 1,
                                      color:
                                          isCompleted
                                              ? AppColors.success
                                              : isHighlighted
                                              ? color
                                              : Theme.of(context).colorScheme.onSurfaceVariant,
                                      fontWeight:
                                          isHighlighted
                                              ? FontWeight.w500
                                              : FontWeight.normal,
                                      height: _readingLineHeight,
                                    ),
                                  ),
                                  maxLines: isHighlighted ? null : 2,
                                  overflow:
                                      isHighlighted
                                          ? TextOverflow.visible
                                          : TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

}
