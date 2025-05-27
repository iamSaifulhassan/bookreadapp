import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../AppColors.dart';

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
  List<String> _sentences = [];
  int _currentSentenceIndex = 0;
  bool _isPlaying = false;
  bool _isPaused = false;
  bool _showTextBuffer = false;
  // TTS Settings
  double _speechRate = 0.5;
  double _pitch = 1.0;
  double _volume = 0.8;
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
    _initializeAnimations();
    _initializeApp();
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

    _textBufferHeight = Tween<double>(begin: 0.0, end: 200.0).animate(
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
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

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
        throw Exception(
          'Unsupported file format. Only PDF and TXT files are supported.',
        );
      }

      setState(() {
        _isInitialized = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _initializeTTS() async {
    try {
      _tts = FlutterTts();

      await _tts!.setLanguage("en-US");
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
          _showSnackBar('TTS Error: $message', isError: true);
        }
      });
    } catch (e) {
      print('TTS initialization failed: $e');
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

        _processSentences(pageText);
      }

      document.dispose();
    } catch (e) {
      print('Error extracting text from page $_currentPage: $e');
      if (mounted) {
        setState(() {
          _sentences = ['Unable to extract text from this page.'];
          _currentSentenceIndex = 0;
        });
      }
    }
  }

  void _processSentences(String text) {
    if (text.trim().isEmpty) {
      setState(() {
        _sentences = ['No readable text found.'];
        _currentSentenceIndex = 0;
      });
      return;
    }

    // Clean text
    final cleanedText =
        text
            .replaceAll(RegExp(r'\s+'), ' ')
            .replaceAll(RegExp(r'[^\w\s.,!?;:()-]'), '')
            .trim(); // Enhanced sentence splitting with comprehensive abbreviation handling
    final sentencePattern = RegExp(
      r'(?<!\b(?:Mr|Mrs|Ms|Dr|Prof|Sr|Jr|vs|etc|Inc|Corp|Ltd|Co|St|Ave|Blvd|Rd|U\.S|U\.K|Ph\.D|B\.A|M\.A|i\.e|e\.g|A\.M|P\.M|a\.m|p\.m|No|Vol|Fig|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|ft|in|lb|oz|min|hr|sec|mph|km|mi|kg|mg|cm|mm|yr|yrs|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\.)(?<=[.!?])\s+(?=[A-Z0-9])|(?<=[.!?])\s*$',
      multiLine: true,
    );

    final sentences =
        cleanedText
            .split(sentencePattern)
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty && s.length > 5)
            .toList();
    if (mounted) {
      setState(() {
        _sentences = sentences.isEmpty ? ['No sentences found.'] : sentences;
        _currentSentenceIndex = 0;
        _updateTtsBuffer(); // Initialize rolling buffer
      });
    }
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
          setState(() {
            _isPlaying = false;
            _isPaused = false;
          });
        } else {
          await _tts!.pause();
        }
      } else {
        await _speakCurrentSentence();
      }
    } catch (e) {
      _showSnackBar('Error controlling TTS: $e', isError: true);
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
      _showSnackBar('Error speaking sentence: $e', isError: true);
    }
  }

  Future<void> _stopReading() async {
    if (_tts == null) return;

    try {
      await _tts!.stop();
      setState(() {
        _isPlaying = false;
        _isPaused = false;
      });
    } catch (e) {
      print('Error stopping TTS: $e');
    }
  }

  void _moveToPreviousSentence() {
    if (_currentSentenceIndex > 0) {
      setState(() {
        _currentSentenceIndex--;
        _updateTtsBuffer(); // Update rolling buffer
      });
      if (_isPlaying && !_isPaused) {
        _speakCurrentSentence();
      }
    }
  }

  void _moveToNextSentence() {
    if (_currentSentenceIndex < _sentences.length - 1) {
      setState(() {
        _currentSentenceIndex++;
        _updateTtsBuffer(); // Update rolling buffer
      });
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
    setState(() {
      _showTextBuffer = !_showTextBuffer;
    });

    if (_showTextBuffer) {
      _textBufferController.forward();
    } else {
      _textBufferController.reverse();
    }
  }

  // PDF Document Features
  void _zoomIn() {
    if (_pdfController != null && _zoomLevel < 3.0) {
      setState(() {
        _zoomLevel += 0.25;
      });
      _pdfController!.zoomLevel = _zoomLevel;
    }
  }

  void _zoomOut() {
    if (_pdfController != null && _zoomLevel > 0.5) {
      setState(() {
        _zoomLevel -= 0.25;
      });
      _pdfController!.zoomLevel = _zoomLevel;
    }
  }

  void _resetZoom() {
    if (_pdfController != null) {
      setState(() {
        _zoomLevel = 1.0;
      });
      _pdfController!.zoomLevel = _zoomLevel;
    }
  }

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

    _showSnackBar(
      _isBookmarked ? 'Page $_currentPage bookmarked' : 'Bookmark removed',
    );
  }

  void _showBookmarks() {
    if (_bookmarkedPages.isEmpty) {
      _showSnackBar('No bookmarks yet', isError: true);
      return;
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Bookmarks'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _bookmarkedPages.length,
                itemBuilder: (context, index) {
                  final page = _bookmarkedPages[index];
                  return ListTile(
                    leading: Icon(Icons.bookmark, color: AppColors.primary),
                    title: Text('Page $page'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _bookmarkedPages.remove(page);
                          if (page == _currentPage) {
                            _isBookmarked = false;
                          }
                        });
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
                child: const Text('Close'),
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
        // Here you could save to gallery or share
        _showSnackBar('Snapshot captured successfully!');

        // Optional: Show save dialog
        _showSaveSnapshotDialog(byteData);
      }
    } catch (e) {
      _showSnackBar('Failed to capture snapshot: $e', isError: true);
    }
  }

  void _showSaveSnapshotDialog(ByteData byteData) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Snapshot Captured'),
            content: const Text(
              'Snapshot has been captured successfully. What would you like to do?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Here you could implement save to gallery
                  Navigator.pop(context);
                  _showSnackBar('Snapshot saved to gallery');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void _goToPage() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Go to Page'),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Page Number (1-$_totalPages)',
                border: const OutlineInputBorder(),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
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
                    _showSnackBar('Invalid page number', isError: true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Go'),
              ),
            ],
          ),
    );
  }

  // PDF Navigation
  void _onPageChanged(PdfPageChangedDetails details) {
    if (details.newPageNumber != _currentPage) {
      setState(() {
        _currentPage = details.newPageNumber;
        _isBookmarked = _bookmarkedPages.contains(_currentPage);
      });
      _extractTextFromCurrentPage();
    }
  }

  // Utility methods
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : AppColors.primary,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  void _showTTSSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _buildTTSSettingsSheet(),
    );
  }

  @override
  void dispose() {
    _stopReading();
    _textBufferController.dispose();
    _controlsController.dispose();
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomDocumentControls(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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
              'Page $_currentPage of $_totalPages',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
        ],
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
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
            tooltip: 'Toggle Text Buffer',
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
                const PopupMenuItem(
                  value: 'tts_settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings_voice),
                      SizedBox(width: 8),
                      Text('TTS Settings'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'reload',
                  child: Row(
                    children: [
                      Icon(Icons.refresh),
                      SizedBox(width: 8),
                      Text('Reload'),
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
        // Text Buffer (when toggled)
        AnimatedBuilder(
          animation: _textBufferHeight,
          builder: (context, child) {
            return SizedBox(
              height: _textBufferHeight.value,
              child: _showTextBuffer ? _buildTextBuffer() : null,
            );
          },
        ),

        // Main PDF/Text Viewer (always visible)
        Expanded(child: _buildMainViewer()),

        // TTS Controls (always visible but disabled if no sentences)
        _buildTTSControls(),
      ],
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading ${widget.fileName}...',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Initializing PDF viewer and TTS engine',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            const Text(
              'Failed to Load Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _initializeApp,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainViewer() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          for (int i = 0; i < _sentences.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentSentenceIndex = i;
                });
                if (_isPlaying && !_isPaused) {
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
                  _sentences[i],
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
    );
  }

  Widget _buildTextBuffer() {
    return Container(
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
                Icon(Icons.text_snippet, color: AppColors.primary, size: 20),
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
                  '${_currentSentenceIndex + 1} / ${_sentences.length}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Rolling text content - Dynamic ListView
          Expanded(
            child:
                _ttsBuffer.isEmpty
                    ? const Center(
                      child: Text(
                        'No sentences available',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(12),
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
                          label = 'Read';
                          color = Colors.green;
                          statusIcon = Icons.check_circle;
                        } else if (isHighlighted) {
                          label = 'Current';
                          color = AppColors.primary;
                          statusIcon =
                              _isPlaying
                                  ? (_isPaused
                                      ? Icons.pause_circle
                                      : Icons.play_circle)
                                  : Icons.radio_button_unchecked;
                        } else {
                          label = 'Next';
                          color = Colors.grey;
                          statusIcon = Icons.radio_button_unchecked;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                isHighlighted
                                    ? color.withOpacity(0.1)
                                    : isCompleted
                                    ? Colors.green.withOpacity(0.05)
                                    : Colors.grey.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  isHighlighted
                                      ? color.withOpacity(0.4)
                                      : isCompleted
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.grey.withOpacity(0.2),
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
                                        color: color.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        _isPaused ? 'Paused' : 'Playing',
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
                                onTap: isHighlighted ? _togglePlayPause : null,
                                child: Text(
                                  sentence,
                                  style: TextStyle(
                                    fontSize: isHighlighted ? 14 : 13,
                                    color:
                                        isCompleted
                                            ? Colors.green.shade700
                                            : isHighlighted
                                            ? color
                                            : Colors.grey.shade600,
                                    fontWeight:
                                        isHighlighted
                                            ? FontWeight.w500
                                            : FontWeight.normal,
                                    height: 1.4,
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

  Widget _buildTTSControls() {
    return FadeTransition(
      opacity: _controlsOpacity,
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
                  _sentences.isNotEmpty && _currentSentenceIndex > 0
                      ? _moveToPreviousSentence
                      : null,
              tooltip: 'Previous Sentence',
            ),
            _buildTTSButton(
              icon:
                  _isPlaying
                      ? (_isPaused ? Icons.play_arrow : Icons.pause)
                      : Icons.play_arrow,
              onPressed: _sentences.isNotEmpty ? _togglePlayPause : null,
              tooltip: _isPlaying ? (_isPaused ? 'Resume' : 'Pause') : 'Play',
              isPrimary: true,
            ),
            _buildTTSButton(
              icon: Icons.stop,
              onPressed: _isPlaying ? _stopReading : null,
              tooltip: 'Stop',
            ),
            _buildTTSButton(
              icon: Icons.skip_next,
              onPressed:
                  _sentences.isNotEmpty &&
                          _currentSentenceIndex < _sentences.length - 1
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

  Widget _buildTTSSettingsSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.settings_voice, color: AppColors.primary),
                  const SizedBox(width: 8),
                  const Text(
                    'TTS Settings',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text('Speech Rate: ${_speechRate.toStringAsFixed(1)}'),
              Slider(
                value: _speechRate,
                min: 0.1,
                max: 1.0,
                divisions: 9,
                activeColor: AppColors.primary,
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
                activeColor: AppColors.primary,
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
                activeColor: AppColors.primary,
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
                    child: OutlinedButton(
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

  Widget _buildBottomDocumentControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_isPdfFile) ...[
              _buildBottomButton(
                icon: Icons.zoom_in,
                label: 'Zoom In',
                onTap: _zoomLevel < 3.0 ? _zoomIn : null,
              ),
              _buildBottomButton(
                icon: Icons.zoom_out,
                label: 'Zoom Out',
                onTap: _zoomLevel > 0.5 ? _zoomOut : null,
              ),
              _buildBottomButton(
                icon: Icons.center_focus_strong,
                label: 'Reset',
                onTap: _zoomLevel != 1.0 ? _resetZoom : null,
              ),
            ],
            _buildBottomButton(
              icon: _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              label: 'Bookmark',
              onTap: _toggleBookmark,
              isActive: _isBookmarked,
            ),
            if (_bookmarkedPages.isNotEmpty)
              _buildBottomButton(
                icon: Icons.bookmarks,
                label: 'Bookmarks',
                onTap: _showBookmarks,
              ),
            _buildBottomButton(
              icon: Icons.camera_alt_outlined,
              label: 'Snapshot',
              onTap: _takeSnapshot,
            ),
            if (_isPdfFile)
              _buildBottomButton(
                icon: Icons.my_location,
                label: 'Go to Page',
                onTap: _goToPage,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(8),
          border:
              isActive
                  ? Border.all(color: AppColors.primary.withOpacity(0.3))
                  : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color:
                  onTap != null
                      ? (isActive ? AppColors.primary : Colors.grey[700])
                      : Colors.grey[400],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color:
                    onTap != null
                        ? (isActive ? AppColors.primary : Colors.grey[700])
                        : Colors.grey[400],
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
