import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:math';
import '../AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    with TickerProviderStateMixin {
  // Core Controllers
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController? _pdfController;
  FlutterTts? _tts;

  // Animation Controllers
  late AnimationController _textBufferAnimationController;
  late AnimationController _controlsAnimationController;
  late AnimationController _fabAnimationController;

  // Animations
  late Animation<double> _textBufferSlideAnimation;
  late Animation<double> _controlsOpacityAnimation;
  late Animation<double> _fabScaleAnimation;

  // State Variables
  bool _isInitialized = false;
  bool _isLoading = true;
  String _errorMessage = '';

  // PDF State
  int _currentPage = 1;
  int _totalPages = 1;
  double _zoomLevel = 1.0;
  bool _isBookmarked = false;
  final List<int> _bookmarkedPages = [];

  // Text & TTS State
  List<String> _allSentences = [];
  List<String> _currentPageSentences = [];
  int _currentSentenceIndex = 0;
  bool _isReading = false;
  bool _isPaused = false;
  bool _showTextBuffer = false;
  double _speechRate = 0.5;
  double _pitch = 1.0;
  double _volume = 0.8;

  // UI State
  bool _showControls = true;
  bool _isFullScreen = false;
  final bool _showSettings = false;

  // Reading Progress
  final Map<int, double> _readingProgress = {};
  final Duration _totalReadingTime = Duration.zero;
  DateTime? _sessionStartTime;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeComponents();
  }

  void _initializeAnimations() {
    // Text buffer slide animation
    _textBufferAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _textBufferSlideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _textBufferAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Controls fade animation
    _controlsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controlsOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controlsAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // FAB scale animation
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    // Start animations
    _controlsAnimationController.forward();
    _fabAnimationController.forward();
  }

  Future<void> _initializeComponents() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Initialize PDF controller
      _pdfController = PdfViewerController();

      // Initialize TTS
      await _initializeTTS();

      // Load content based on file type
      if (_fileExists) {
        if (_isPdfFile) {
          await _loadPdfContent();
        } else if (_isTxtFile) {
          await _loadTxtContent();
        } else {
          throw Exception('Unsupported file format');
        }
      } else {
        throw Exception('File not found: ${widget.filePath}');
      }

      // Start reading session
      _sessionStartTime = DateTime.now();

      setState(() {
        _isInitialized = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
        _isInitialized = false;
      });
      _showErrorSnackBar('Failed to load content: $e');
    }
  }

  Future<void> _initializeTTS() async {
    try {
      _tts = FlutterTts();

      await _tts!.setLanguage("en-US");
      await _tts!.setSpeechRate(_speechRate);
      await _tts!.setVolume(_volume);
      await _tts!.setPitch(_pitch);

      _tts!.setStartHandler(() {
        if (mounted) {
          setState(() {
            _isReading = true;
            _isPaused = false;
          });
        }
      });

      _tts!.setCompletionHandler(() {
        if (mounted && _isReading && !_isPaused) {
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
    } catch (e) {
      print('TTS initialization error: $e');
    }
  }

  // File validation getters
  bool get _fileExists {
    try {
      return widget.filePath.isNotEmpty && File(widget.filePath).existsSync();
    } catch (_) {
      return false;
    }
  }

  bool get _isPdfFile {
    return widget.filePath.toLowerCase().endsWith('.pdf');
  }

  bool get _isTxtFile {
    return widget.filePath.toLowerCase().endsWith('.txt');
  }

  // Content loading methods
  Future<void> _loadPdfContent() async {
    try {
      final file = File(widget.filePath);
      final bytes = await file.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);

      _totalPages = document.pages.count;

      // Extract text from first page initially
      await _extractTextFromPage(1);

      document.dispose();
    } catch (e) {
      throw Exception('Failed to load PDF: $e');
    }
  }

  Future<void> _loadTxtContent() async {
    try {
      final file = File(widget.filePath);
      final content = await file.readAsString();
      _processPureText(content);
    } catch (e) {
      throw Exception('Failed to load text file: $e');
    }
  }

  Future<void> _extractTextFromPage(int pageNumber) async {
    try {
      if (!_isPdfFile || !_fileExists) return;

      final file = File(widget.filePath);
      final bytes = await file.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);

      if (pageNumber < 1 || pageNumber > document.pages.count) {
        document.dispose();
        return;
      }

      final pageText = PdfTextExtractor(document).extractText(
        startPageIndex: pageNumber - 1,
        endPageIndex: pageNumber - 1,
      );

      document.dispose();

      if (mounted) {
        setState(() {
          _currentPage = pageNumber;
        });
        _processPureText(pageText, isPageSpecific: true);
      }
    } catch (e) {
      print('Error extracting text from page $pageNumber: $e');
    }
  }

  void _processPureText(String text, {bool isPageSpecific = false}) {
    final cleanedText =
        text
            .replaceAll(RegExp(r'[\n\r\t]+'), ' ')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();

    if (cleanedText.isEmpty) {
      if (mounted) {
        setState(() {
          _currentPageSentences = [];
          if (!isPageSpecific) _allSentences = [];
        });
      }
      return;
    }

    // Enhanced sentence splitting
    final sentences = _splitIntoSentences(cleanedText);

    if (mounted) {
      setState(() {
        if (isPageSpecific) {
          _currentPageSentences = sentences;
        } else {
          _allSentences = sentences;
          _currentPageSentences = sentences;
        }
        _currentSentenceIndex = 0;
      });
    }
  }

  List<String> _splitIntoSentences(String text) {
    // Advanced sentence splitting regex
    final regex = RegExp(
      r'(?<!\b(?:Mr|Mrs|Ms|Dr|Prof|Sr|Jr|vs|etc|Inc|Ltd|Co|Corp)\.|[A-Z]\.|[0-9]\.)[\.\!\?]+\s+(?=[A-Z])',
      multiLine: true,
    );

    return text
        .split(regex)
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty && s.length > 10)
        .toList();
  }

  // TTS Control Methods
  Future<void> _toggleReading() async {
    try {
      if (_tts == null || _currentPageSentences.isEmpty) return;

      if (_isReading) {
        if (_isPaused) {
          await _tts!.stop();
          setState(() {
            _isReading = false;
            _isPaused = false;
          });
        } else {
          await _tts!.pause();
        }
      } else {
        await _speakCurrentSentence();
      }
    } catch (e) {
      print('Error toggling reading: $e');
    }
  }

  Future<void> _speakCurrentSentence() async {
    if (_tts == null ||
        _currentPageSentences.isEmpty ||
        _currentSentenceIndex >= _currentPageSentences.length) {
      return;
    }

    try {
      final sentence = _currentPageSentences[_currentSentenceIndex];
      await _tts!.speak(sentence);
    } catch (e) {
      print('Error speaking sentence: $e');
    }
  }

  void _moveToNextSentence() {
    if (_currentSentenceIndex < _currentPageSentences.length - 1) {
      setState(() {
        _currentSentenceIndex++;
      });
      if (_isReading && !_isPaused) {
        _speakCurrentSentence();
      }
    } else {
      // Auto move to next page if available
      if (_isPdfFile && _currentPage < _totalPages) {
        _goToNextPage();
      } else {
        _stopReading();
      }
    }
  }

  void _moveToPreviousSentence() {
    if (_currentSentenceIndex > 0) {
      setState(() {
        _currentSentenceIndex--;
      });
      if (_isReading && !_isPaused) {
        _speakCurrentSentence();
      }
    } else if (_isPdfFile && _currentPage > 1) {
      _goToPreviousPage();
    }
  }

  Future<void> _stopReading() async {
    try {
      await _tts?.stop();
      setState(() {
        _isReading = false;
        _isPaused = false;
      });
    } catch (e) {
      print('Error stopping TTS: $e');
    }
  }

  // PDF Navigation Methods
  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      _pdfController?.nextPage();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      _pdfController?.previousPage();
    }
  }

  void _onPageChanged(PdfPageChangedDetails details) {
    final newPage = details.newPageNumber;
    if (newPage != _currentPage) {
      _extractTextFromPage(newPage);
      _updateReadingProgress();
    }
  }

  // PDF Controls
  void _zoomIn() {
    if (_pdfController != null) {
      final newZoom = min(_zoomLevel + 0.25, 3.0);
      _pdfController!.zoomLevel = newZoom;
      setState(() {
        _zoomLevel = newZoom;
      });
    }
  }

  void _zoomOut() {
    if (_pdfController != null) {
      final newZoom = max(_zoomLevel - 0.25, 0.5);
      _pdfController!.zoomLevel = newZoom;
      setState(() {
        _zoomLevel = newZoom;
      });
    }
  }

  void _resetZoom() {
    if (_pdfController != null) {
      _pdfController!.zoomLevel = 1.0;
      setState(() {
        _zoomLevel = 1.0;
      });
    }
  }

  // Bookmark functionality
  void _toggleBookmark() {
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

    _showSuccessSnackBar(
      _isBookmarked ? 'Page bookmarked' : 'Bookmark removed',
    );
  }

  // Reading progress tracking
  void _updateReadingProgress() {
    if (_sessionStartTime != null) {
      final sessionDuration = DateTime.now().difference(_sessionStartTime!);
      _readingProgress[_currentPage] = sessionDuration.inSeconds.toDouble();
    }
  }

  // UI State Management
  void _toggleTextBuffer() {
    setState(() {
      _showTextBuffer = !_showTextBuffer;
    });

    if (_showTextBuffer) {
      _textBufferAnimationController.forward();
    } else {
      _textBufferAnimationController.reverse();
    }
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      _showControls = !_isFullScreen;
    });

    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  // Helper methods for sentence navigation
  String get _previousSentence {
    if (_currentSentenceIndex > 0 && _currentPageSentences.isNotEmpty) {
      return _currentPageSentences[_currentSentenceIndex - 1];
    }
    return '';
  }

  String get _currentSentence {
    if (_currentSentenceIndex < _currentPageSentences.length) {
      return _currentPageSentences[_currentSentenceIndex];
    }
    return '';
  }

  String get _nextSentence {
    if (_currentSentenceIndex < _currentPageSentences.length - 1) {
      return _currentPageSentences[_currentSentenceIndex + 1];
    }
    return '';
  }

  // Utility methods
  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showSuccessSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _updateReadingProgress();
    _stopReading();
    _textBufferAnimationController.dispose();
    _controlsAnimationController.dispose();
    _fabAnimationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingScreen();
    }

    if (!_isInitialized || _errorMessage.isNotEmpty) {
      return _buildErrorScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isFullScreen ? null : _buildAppBar(),
      body: _buildMainContent(),
      floatingActionButton: _buildFloatingActionButtons(),
      bottomNavigationBar: _isFullScreen ? null : _buildBottomControls(),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: AppColors.primary.withOpacity(0.05),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeWidth: 3,
            ),
            const SizedBox(height: 24),
            Text(
              'Loading ${widget.fileName}...',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Preparing PDF viewer and TTS engine',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 24),
              Text(
                'Failed to load content',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _errorMessage = '';
                  });
                  _initializeComponents();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fileName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          if (_isPdfFile)
            Text(
              'Page $_currentPage of $_totalPages',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
        ],
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            _showTextBuffer ? Icons.text_snippet : Icons.text_snippet_outlined,
          ),
          onPressed:
              _currentPageSentences.isNotEmpty ? _toggleTextBuffer : null,
          tooltip: 'Toggle Text Buffer',
        ),
        IconButton(
          icon: Icon(_isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
          onPressed: _toggleFullScreen,
          tooltip: 'Toggle Full Screen',
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'settings':
                _showTTSSettings();
                break;
              case 'bookmarks':
                _showBookmarks();
                break;
              case 'progress':
                _showReadingProgress();
                break;
            }
          },
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, size: 20),
                      SizedBox(width: 12),
                      Text('TTS Settings'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'bookmarks',
                  child: Row(
                    children: [
                      Icon(Icons.bookmark, size: 20),
                      SizedBox(width: 12),
                      Text('Bookmarks'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'progress',
                  child: Row(
                    children: [
                      Icon(Icons.analytics, size: 20),
                      SizedBox(width: 12),
                      Text('Reading Progress'),
                    ],
                  ),
                ),
              ],
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Stack(
      children: [
        // Main PDF/Text Viewer
        Column(
          children: [
            // Text Buffer (when enabled)
            if (_showTextBuffer)
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(_textBufferAnimationController),
                child: _buildTextBuffer(),
              ),

            // PDF/Content Viewer
            Expanded(child: _buildContentViewer()),

            // TTS Controls (when not in full screen)
            if (!_isFullScreen && _currentPageSentences.isNotEmpty)
              _buildTTSControls(),
          ],
        ),

        // Tap to show/hide controls in full screen
        if (_isFullScreen)
          GestureDetector(
            onTap: () {
              setState(() {
                _showControls = !_showControls;
              });
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),

        // Full screen overlay controls
        if (_isFullScreen && _showControls) _buildFullScreenOverlay(),
      ],
    );
  }

  Widget _buildContentViewer() {
    if (!_fileExists) {
      return _buildErrorMessage('File not found');
    }

    if (_isPdfFile) {
      return _buildPDFViewer();
    } else if (_isTxtFile) {
      return _buildTextViewer();
    } else {
      return _buildErrorMessage('Unsupported file format');
    }
  }

  Widget _buildPDFViewer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: SfPdfViewer.file(
        File(widget.filePath),
        key: _pdfViewerKey,
        controller: _pdfController,
        onPageChanged: _onPageChanged,
        canShowScrollHead: false,
        canShowScrollStatus: false,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
      ),
    );
  }

  Widget _buildTextViewer() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < _currentPageSentences.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentSentenceIndex = i;
                  });
                  if (_isReading) {
                    _speakCurrentSentence();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        i == _currentSentenceIndex
                            ? AppColors.primary.withOpacity(0.1)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        i == _currentSentenceIndex
                            ? Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                            )
                            : null,
                  ),
                  child: Text(
                    _currentPageSentences[i],
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color:
                          i == _currentSentenceIndex
                              ? AppColors.primary
                              : Colors.black87,
                      fontWeight:
                          i == _currentSentenceIndex
                              ? FontWeight.w600
                              : FontWeight.normal,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber, size: 48, color: Colors.orange[300]),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTextBuffer() {
    return AnimatedBuilder(
      animation: _textBufferAnimationController,
      builder: (context, child) {
        return Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.text_snippet,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Reading Buffer',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_currentSentenceIndex + 1} / ${_currentPageSentences.length}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              // Rolling text content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Previous sentence
                      _buildBufferSentence(
                        _previousSentence,
                        'Previous',
                        Colors.grey[400]!,
                        false,
                      ),
                      const SizedBox(height: 8),

                      // Current sentence (highlighted)
                      _buildBufferSentence(
                        _currentSentence,
                        'Current',
                        AppColors.primary,
                        true,
                      ),
                      const SizedBox(height: 8),

                      // Next sentence
                      _buildBufferSentence(
                        _nextSentence,
                        'Next',
                        Colors.grey[400]!,
                        false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBufferSentence(
    String text,
    String label,
    Color color,
    bool isCurrent,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: isCurrent ? _toggleReading : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCurrent ? color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border:
                isCurrent ? Border.all(color: color.withOpacity(0.3)) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  text.isEmpty ? '...' : text,
                  style: TextStyle(
                    fontSize: isCurrent ? 13 : 12,
                    color: text.isEmpty ? Colors.grey[300] : color,
                    fontWeight: isCurrent ? FontWeight.w500 : FontWeight.normal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTTSControls() {
    return FadeTransition(
      opacity: _controlsOpacityAnimation,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTTSButton(
              icon: Icons.skip_previous,
              onPressed:
                  _currentSentenceIndex > 0 ? _moveToPreviousSentence : null,
              tooltip: 'Previous Sentence',
            ),
            _buildTTSButton(
              icon:
                  _isReading
                      ? (_isPaused ? Icons.play_arrow : Icons.pause)
                      : Icons.play_arrow,
              onPressed: _toggleReading,
              tooltip: _isReading ? (_isPaused ? 'Resume' : 'Pause') : 'Play',
              isPrimary: true,
            ),
            _buildTTSButton(
              icon: Icons.stop,
              onPressed: _isReading ? _stopReading : null,
              tooltip: 'Stop',
            ),
            _buildTTSButton(
              icon: Icons.skip_next,
              onPressed:
                  _currentSentenceIndex < _currentPageSentences.length - 1
                      ? _moveToNextSentence
                      : null,
              tooltip: 'Next Sentence',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTTSButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
    bool isPrimary = false,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: isPrimary ? 56 : 48,
            height: isPrimary ? 56 : 48,
            decoration: BoxDecoration(
              color:
                  isPrimary
                      ? AppColors.primary
                      : (onPressed != null
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.grey[200]),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: isPrimary ? 28 : 24,
              color:
                  isPrimary
                      ? Colors.white
                      : (onPressed != null
                          ? AppColors.primary
                          : Colors.grey[400]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomButton(
            icon: Icons.zoom_out,
            label: 'Zoom Out',
            onTap: _zoomOut,
            isEnabled: _zoomLevel > 0.5,
          ),
          _buildBottomButton(
            icon: Icons.zoom_in,
            label: 'Zoom In',
            onTap: _zoomIn,
            isEnabled: _zoomLevel < 3.0,
          ),
          _buildBottomButton(
            icon: Icons.refresh,
            label: 'Reset',
            onTap: _resetZoom,
            isEnabled: _zoomLevel != 1.0,
          ),
          _buildBottomButton(
            icon: _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            label: 'Bookmark',
            onTap: _toggleBookmark,
            isActive: _isBookmarked,
          ),
          _buildBottomButton(
            icon: Icons.settings,
            label: 'Settings',
            onTap: _showTTSSettings,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isEnabled = true,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color:
                isActive
                    ? AppColors.primary
                    : (isEnabled ? Colors.grey[700] : Colors.grey[400]),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color:
                  isActive
                      ? AppColors.primary
                      : (isEnabled ? Colors.grey[700] : Colors.grey[400]),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return ScaleTransition(
      scale: _fabScaleAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_isPdfFile && _currentPage > 1)
            FloatingActionButton.small(
              onPressed: _goToPreviousPage,
              heroTag: "prevPage",
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          const SizedBox(height: 8),
          if (_isPdfFile && _currentPage < _totalPages)
            FloatingActionButton.small(
              onPressed: _goToNextPage,
              heroTag: "nextPage",
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.arrow_downward, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildFullScreenOverlay() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _controlsOpacityAnimation,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      widget.fileName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleFullScreen,
                    icon: const Icon(
                      Icons.fullscreen_exit,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dialog methods
  void _showTTSSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _buildTTSSettingsSheet(),
    );
  }

  Widget _buildTTSSettingsSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TTS Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              Text('Speech Rate: ${_speechRate.toStringAsFixed(1)}'),
              Slider(
                value: _speechRate,
                min: 0.1,
                max: 1.0,
                divisions: 9,
                onChanged: (value) {
                  setModalState(() {
                    _speechRate = value;
                  });
                  _tts?.setSpeechRate(value);
                },
              ),

              const SizedBox(height: 16),
              Text('Pitch: ${_pitch.toStringAsFixed(1)}'),
              Slider(
                value: _pitch,
                min: 0.5,
                max: 2.0,
                divisions: 15,
                onChanged: (value) {
                  setModalState(() {
                    _pitch = value;
                  });
                  _tts?.setPitch(value);
                },
              ),

              const SizedBox(height: 16),
              Text('Volume: ${(_volume * 100).round()}%'),
              Slider(
                value: _volume,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                onChanged: (value) {
                  setModalState(() {
                    _volume = value;
                  });
                  _tts?.setVolume(value);
                },
              ),

              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setModalState(() {
                          _speechRate = 0.5;
                          _pitch = 1.0;
                          _volume = 0.8;
                        });
                        _tts?.setSpeechRate(_speechRate);
                        _tts?.setPitch(_pitch);
                        _tts?.setVolume(_volume);
                      },
                      child: const Text('Reset to Default'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBookmarks() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Bookmarks'),
            content:
                _bookmarkedPages.isEmpty
                    ? const Text('No bookmarks yet')
                    : SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _bookmarkedPages.length,
                        itemBuilder: (context, index) {
                          final page = _bookmarkedPages[index];
                          return ListTile(
                            leading: const Icon(Icons.bookmark),
                            title: Text('Page $page'),
                            onTap: () {
                              Navigator.pop(context);
                              _pdfController?.jumpToPage(page);
                            },
                          );
                        },
                      ),
                    ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  void _showReadingProgress() {
    final totalPages = _readingProgress.keys.length;
    final totalTime = _readingProgress.values.fold(0.0, (a, b) => a + b);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Reading Progress'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pages read: $totalPages'),
                Text(
                  'Total reading time: ${Duration(seconds: totalTime.round())}',
                ),
                Text(
                  'Average time per page: ${totalPages > 0 ? Duration(seconds: (totalTime / totalPages).round()) : "N/A"}',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}
