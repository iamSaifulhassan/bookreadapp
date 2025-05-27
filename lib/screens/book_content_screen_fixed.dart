import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import '../../AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class _BookContentScreenState extends State<BookContentScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController? _pdfController;
  final GlobalKey _pdfBoundaryKey = GlobalKey();
  FlutterTts? flutterTts;
  List<String> _sentences = [];
  int _currentSentence = 0;
  bool _isReadingAloud = false;
  bool _isTtsProcessing = false;
  bool _showTextBuffer = false;
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isBookmarked = false;
  bool _isInitialized = false;

  // Rolling TTS Buffer state
  List<String> _ttsBuffer = [];
  final int _bufferSize = 5; // Show 5 sentences at a time
  final int _highlightedIndex = 2; // Middle position (0-indexed)

  @override
  void initState() {
    super.initState();
    _initializeComponents();
  }

  Future<void> _initializeComponents() async {
    try {
      _pdfController = PdfViewerController();
      flutterTts = FlutterTts();
      await _initializeTts();
      _loadInitialContent();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Initialization error: $e');
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _sentences = [];
        });
      }
    }
  }

  void _loadInitialContent() {
    if (_isPdfFile && _fileExists) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _extractPdfPageText(_currentPage);
      });
    } else if (_isTxtFile && _fileExists) {
      _extractTxtFile();
    }
  }

  bool get _fileExists {
    try {
      return widget.filePath.isNotEmpty && File(widget.filePath).existsSync();
    } catch (_) {
      return false;
    }
  }

  bool get _isPdfFile {
    try {
      return widget.filePath.toLowerCase().endsWith('.pdf');
    } catch (_) {
      return false;
    }
  }

  bool get _isTxtFile {
    try {
      return widget.filePath.toLowerCase().endsWith('.txt');
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    try {
      flutterTts?.stop();
    } catch (_) {}
    super.dispose();
  }

  Future<void> _initializeTts() async {
    try {
      if (flutterTts == null) return;
      await flutterTts!.setLanguage("en-US");
      await flutterTts!.setSpeechRate(0.5);
      await flutterTts!.setVolume(1.0);
      await flutterTts!.setPitch(1.0);
      flutterTts!.setCompletionHandler(() {
        if (mounted && !_isTtsProcessing) _onTtsComplete();
      });
    } catch (_) {}
  }

  Future<void> _extractTxtFile() async {
    try {
      final file = File(widget.filePath);
      final text = await file.readAsString();
      _splitIntoSentences(text);
    } catch (_) {
      if (mounted) setState(() => _sentences = []);
    }
  }

  Future<void> _extractPdfPageText(int page) async {
    try {
      final file = File(widget.filePath);
      if (!mounted || !_fileExists || !_isPdfFile) {
        if (mounted) setState(() => _sentences = []);
        return;
      }
      final bytes = await file.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);
      _totalPages = document.pages.count;
      if (page < 1 || page > _totalPages) page = 1;
      final pageText = PdfTextExtractor(
        document,
      ).extractText(startPageIndex: page - 1, endPageIndex: page - 1);
      document.dispose();
      _splitIntoSentences(pageText);
      if (mounted) setState(() => _currentPage = page);
    } catch (_) {
      if (mounted) setState(() => _sentences = []);
    }
  }

  void _splitIntoSentences(String text) {
    final cleaned =
        text
            .replaceAll(RegExp(r'[\n\r\t]+'), ' ')
            .replaceAll(RegExp(r' +'), ' ')
            .trim();
    final regex = RegExp(
      r'(?<!\b[A-Z][a-z]{0,3}|\d)\.(?=\s+[A-Z0-9])|(?<=[!?])\s+(?=[A-Z0-9])',
    );
    final sentences =
        cleaned
            .split(regex)
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
    setState(() {
      _sentences = sentences;
      _currentSentence = 0;
      _updateTtsBuffer();
    });
  }

  void _updateTtsBuffer() {
    if (_sentences.isEmpty) {
      _ttsBuffer = [];
      return;
    }

    // Create a rolling buffer centered on current sentence
    _ttsBuffer = [];
    int startIndex = _currentSentence - _highlightedIndex;

    for (int i = 0; i < _bufferSize; i++) {
      int sentenceIndex = startIndex + i;
      if (sentenceIndex >= 0 && sentenceIndex < _sentences.length) {
        _ttsBuffer.add(_sentences[sentenceIndex]);
      } else {
        _ttsBuffer.add(''); // Empty placeholder for out-of-bounds
      }
    }
  }

  void _onPdfPageChanged(int pageNumber) {
    if (_isPdfFile) _extractPdfPageText(pageNumber);
  }

  void _onTtsComplete() {
    if (!mounted || _isTtsProcessing) return;
    _isTtsProcessing = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          if (_currentSentence < _sentences.length - 1) {
            _currentSentence++;
            _updateTtsBuffer(); // Update rolling buffer
            _speakCurrentSentence();
          } else {
            _isReadingAloud = false;
          }
          _isTtsProcessing = false;
        });
      } else {
        _isTtsProcessing = false;
      }
    });
  }

  Future<void> _toggleReadAloud() async {
    try {
      if (flutterTts == null) return;
      if (_isReadingAloud) {
        await flutterTts!.stop();
        setState(() => _isReadingAloud = false);
      } else {
        setState(() => _isReadingAloud = true);
        await _speakCurrentSentence();
      }
    } catch (_) {}
  }

  Future<void> _speakCurrentSentence() async {
    if (_currentSentence < _sentences.length &&
        _isReadingAloud &&
        flutterTts != null) {
      try {
        await flutterTts!.stop();
        await Future.delayed(const Duration(milliseconds: 100));
        await flutterTts!.speak(_sentences[_currentSentence]);
      } catch (_) {}
    }
  }

  void _nextSentence() {
    if (_currentSentence < _sentences.length - 1) {
      setState(() {
        _currentSentence++;
        _updateTtsBuffer(); // Update rolling buffer
      });
      if (_isReadingAloud) _speakCurrentSentence();
    }
  }

  void _previousSentence() {
    if (_currentSentence > 0) {
      setState(() {
        _currentSentence--;
        _updateTtsBuffer(); // Update rolling buffer
      });
      if (_isReadingAloud) _speakCurrentSentence();
    }
  }

  void _toggleBookmark() {
    setState(() => _isBookmarked = !_isBookmarked);
  }

  void _zoomIn() {
    if (_pdfController != null && _pdfController!.zoomLevel < 3.0) {
      _pdfController!.zoomLevel += 0.25;
      setState(() {});
    }
  }

  void _zoomOut() {
    if (_pdfController != null && _pdfController!.zoomLevel > 0.5) {
      _pdfController!.zoomLevel -= 0.25;
      setState(() {});
    }
  }

  Future<void> _takeSnapshot() async {
    try {
      RenderRepaintBoundary boundary =
          _pdfBoundaryKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF snapshot taken (implement saving logic)'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error taking snapshot: $e')));
    }
  }

  // Helper methods for rolling text buffer
  String _getPreviousSentence() {
    if (_sentences.isEmpty || _currentSentence <= 0) {
      return '';
    }
    return _sentences[_currentSentence - 1];
  }

  String _getCurrentSentence() {
    if (_sentences.isEmpty ||
        _currentSentence < 0 ||
        _currentSentence >= _sentences.length) {
      return '';
    }
    return _sentences[_currentSentence];
  }

  String _getNextSentence() {
    if (_sentences.isEmpty || _currentSentence >= _sentences.length - 1) {
      return '';
    }
    return _sentences[_currentSentence + 1];
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.fileName),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.text_snippet),
            onPressed:
                _sentences.isNotEmpty
                    ? () => setState(() => _showTextBuffer = !_showTextBuffer)
                    : null,
            tooltip: 'Toggle Text Buffer',
          ),
        ],
      ),
      body: Column(
        children: [
          // PDF Viewer (always visible, fills most space)
          Expanded(
            flex: 7,
            child: RepaintBoundary(
              key: _pdfBoundaryKey,
              child:
                  (!_fileExists || !_isPdfFile)
                      ? Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'PDF preview not available. File missing or not a PDF.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )
                      : Builder(
                        builder: (context) {
                          try {
                            if (_pdfController == null) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  'PDF controller not initialized.',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                            return SfPdfViewer.file(
                              File(widget.filePath),
                              key: _pdfViewerKey,
                              controller: _pdfController!,
                              onPageChanged: (details) {
                                _onPdfPageChanged(details.newPageNumber);
                              },
                            );
                          } catch (_) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              child: const Text(
                                'PDF preview failed to load.',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        },
                      ),
            ),
          ),
          const Divider(height: 1),

          // Text Buffer + TTS controls section
          Expanded(
            flex: 3,
            child:
                _sentences.isEmpty
                    ? const Center(
                      child: Text(
                        'No readable sentences found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    )
                    : Column(
                      children: [
                        // Rolling TTS Buffer (only visible when toggled)
                        if (_showTextBuffer)
                          Container(
                            height: 180,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header
                                Row(
                                  children: [
                                    Icon(
                                      Icons.playlist_play,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'TTS Reading Buffer',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${_currentSentence + 1} / ${_sentences.length}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Rolling sentence buffer
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: _ttsBuffer.length,
                                    itemBuilder: (context, index) {
                                      final sentence = _ttsBuffer[index];
                                      final isCurrentlyReading =
                                          index == _highlightedIndex;
                                      final isPrevious =
                                          index < _highlightedIndex;
                                      final isUpcoming =
                                          index > _highlightedIndex;

                                      if (sentence.isEmpty) {
                                        return const SizedBox(
                                          height: 24,
                                        ); // Empty placeholder
                                      }

                                      return Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              isCurrentlyReading
                                                  ? AppColors.primary
                                                      .withOpacity(0.15)
                                                  : isPrevious
                                                  ? Colors.grey[200]
                                                  : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          border:
                                              isCurrentlyReading
                                                  ? Border.all(
                                                    color: AppColors.primary
                                                        .withOpacity(0.5),
                                                    width: 2,
                                                  )
                                                  : Border.all(
                                                    color: Colors.grey[300]!,
                                                  ),
                                        ),
                                        child: Row(
                                          children: [
                                            // Status indicator
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color:
                                                    isCurrentlyReading &&
                                                            _isReadingAloud
                                                        ? Colors.green
                                                        : isCurrentlyReading
                                                        ? AppColors.primary
                                                        : isPrevious
                                                        ? Colors.grey[400]
                                                        : Colors.orange,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 10),

                                            // Sentence text
                                            Expanded(
                                              child: Text(
                                                sentence,
                                                style: TextStyle(
                                                  color:
                                                      isCurrentlyReading
                                                          ? AppColors.primary
                                                          : isPrevious
                                                          ? Colors.grey[600]
                                                          : Colors.black87,
                                                  fontWeight:
                                                      isCurrentlyReading
                                                          ? FontWeight.w600
                                                          : FontWeight.normal,
                                                  fontSize:
                                                      isCurrentlyReading
                                                          ? 13
                                                          : 12,
                                                  fontStyle:
                                                      isPrevious
                                                          ? FontStyle.italic
                                                          : FontStyle.normal,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),

                                            // Position indicator
                                            if (isCurrentlyReading &&
                                                _isReadingAloud)
                                              Icon(
                                                Icons.volume_up,
                                                color: AppColors.primary,
                                                size: 16,
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // TTS Controls (always visible when sentences exist)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Previous button
                                    IconButton(
                                      onPressed:
                                          (_currentSentence > 0)
                                              ? _previousSentence
                                              : null,
                                      icon: const Icon(
                                        Icons.skip_previous,
                                        size: 28,
                                      ),
                                      color: AppColors.primary,
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.primary
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    const SizedBox(width: 20),

                                    // Play/Pause button
                                    IconButton(
                                      onPressed: _toggleReadAloud,
                                      icon: Icon(
                                        _isReadingAloud
                                            ? Icons.pause_circle_filled
                                            : Icons.play_circle_filled,
                                        size: 48,
                                      ),
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 20),

                                    // Stop button
                                    IconButton(
                                      onPressed: () {
                                        setState(() => _isReadingAloud = false);
                                        flutterTts?.stop();
                                      },
                                      icon: const Icon(Icons.stop, size: 28),
                                      color: AppColors.primary,
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.primary
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    const SizedBox(width: 20),

                                    // Next button
                                    IconButton(
                                      onPressed:
                                          (_currentSentence <
                                                  _sentences.length - 1)
                                              ? _nextSentence
                                              : null,
                                      icon: const Icon(
                                        Icons.skip_next,
                                        size: 28,
                                      ),
                                      color: AppColors.primary,
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.primary
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
          ),
          const Divider(height: 1),
        ],
      ),

      // PDF Options Row (always at bottom)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPdfOptionButton(
              icon: Icons.zoom_in,
              label: 'Zoom In',
              onTap: _zoomIn,
            ),
            _buildPdfOptionButton(
              icon: Icons.zoom_out,
              label: 'Zoom Out',
              onTap: _zoomOut,
            ),
            _buildPdfOptionButton(
              icon: _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              label: 'Bookmark',
              onTap: _toggleBookmark,
              isActive: _isBookmarked,
            ),
            _buildPdfOptionButton(
              icon:
                  _showTextBuffer
                      ? Icons.text_snippet
                      : Icons.text_snippet_outlined,
              label: 'Text Buffer',
              onTap:
                  _sentences.isNotEmpty
                      ? () => setState(() => _showTextBuffer = !_showTextBuffer)
                      : () {},
              isActive: _showTextBuffer,
            ),
            _buildPdfOptionButton(
              icon: Icons.camera_alt_outlined,
              label: 'Snapshot',
              onTap: _takeSnapshot,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  isActive
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border:
                  isActive
                      ? Border.all(color: AppColors.primary.withOpacity(0.3))
                      : null,
            ),
            child: Icon(
              icon,
              color: isActive ? AppColors.primary : Colors.grey[600],
              size: 22,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? AppColors.primary : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
