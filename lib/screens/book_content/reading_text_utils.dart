/// Pure text-processing helpers for the reading screen: detecting a book's
/// language from its own text (so TTS/font follow the book, not the app's
/// UI language) and splitting page text into TTS-speakable sentences.
///
/// Deliberately free of BuildContext/setState — these were extracted out of
/// _BookContentScreenState so they're plain, testable functions instead of
/// being entangled with widget lifecycle.
library;

/// Fallback TTS locale per app UI language, used only when a book's own
/// language can't be confidently detected from its text (e.g. too short).
const Map<String, String> ttsLocaleByLanguage = {
  'en': 'en-US',
  'es': 'es-ES',
  'fr': 'fr-FR',
  'de': 'de-DE',
  'pt': 'pt-BR',
  'it': 'it-IT',
  'ar': 'ar-SA',
  'hi': 'hi-IN',
  'ur': 'ur-PK',
  'zh': 'zh-CN',
  'ja': 'ja-JP',
  'ru': 'ru-RU',
};

/// Words common enough in each Latin-script language to reliably tell it
/// apart from the others just by counting hits in a page of prose.
const Map<String, List<String>> _latinScriptMarkers = {
  'es-ES': [' el ', ' la ', ' de ', ' que ', ' y ', ' los ', ' se ', ' un ', ' por ', ' con ', ' una ', ' su '],
  'fr-FR': [' le ', ' la ', ' et ', ' les ', ' des ', ' un ', ' une ', ' que ', ' pour ', ' dans ', ' est ', ' qui '],
  'de-DE': [' der ', ' die ', ' und ', ' das ', ' ist ', ' nicht ', ' ein ', ' zu ', ' den ', ' mit ', ' sich ', ' war '],
  'pt-BR': [' o ', ' a ', ' de ', ' que ', ' e ', ' do ', ' da ', ' em ', ' para ', ' com ', ' uma ', ' os '],
  'it-IT': [' il ', ' la ', ' che ', ' di ', ' un ', ' per ', ' non ', ' con ', ' sono ', ' una ', ' della ', ' gli '],
  'en-US': [' the ', ' and ', ' of ', ' to ', ' a ', ' in ', ' that ', ' was ', ' he ', ' for ', ' is ', ' with '],
};

// Letterforms that appear in Urdu orthography but not standard Arabic
// (which uses ك ه ي instead) — enough hits means the Arabic-script text
// is actually Urdu.
const Set<int> _urduOnlyCodepoints = {
  0x0679, // ٹ TTEH
  0x0688, // ڈ DDAL
  0x0691, // ڑ RREH
  0x06AF, // گ GAF
  0x06BA, // ں NOON GHUNNA
  0x06BE, // ھ HEH DOACHASHMEE
  0x06C1, // ہ HEH GOAL
  0x06CC, // ی FARSI YEH
  0x06D2, // ے YEH BARREE
};

/// Best-effort detection of a book's own language from its extracted text,
/// so read-aloud always matches what the book is actually written in (an
/// English book gets English TTS, a Russian one gets Russian TTS, etc.)
/// rather than following the app's UI language setting. Falls back to
/// [fallbackLocale] (normally the app's own UI language) when the text is
/// too short or too ambiguous to trust.
String detectTtsLocale(String text, {required String fallbackLocale}) {
  if (text.trim().length < 20) return fallbackLocale;

  int arabic = 0, devanagari = 0, cyrillic = 0, han = 0, hiragana = 0, latin = 0;
  int urduLetters = 0;
  for (final rune in text.runes) {
    if (rune >= 0x0600 && rune <= 0x06FF) {
      arabic++;
      if (_urduOnlyCodepoints.contains(rune)) urduLetters++;
    } else if (rune >= 0x0900 && rune <= 0x097F) {
      devanagari++;
    } else if (rune >= 0x0400 && rune <= 0x04FF) {
      cyrillic++;
    } else if (rune >= 0x4E00 && rune <= 0x9FFF) {
      han++;
    } else if (rune >= 0x3040 && rune <= 0x30FF) {
      hiragana++;
    } else if ((rune >= 0x0041 && rune <= 0x005A) ||
        (rune >= 0x0061 && rune <= 0x007A)) {
      latin++;
    }
  }

  // Distinct scripts are unambiguous — decide outright once there's
  // enough of one to not just be a stray quoted phrase.
  if (arabic > 15 && arabic > latin) {
    return urduLetters >= 3 ? 'ur-PK' : 'ar-SA';
  }
  if (devanagari > 15 && devanagari > latin) return 'hi-IN';
  if (cyrillic > 15 && cyrillic > latin) return 'ru-RU';
  if (hiragana > 5) return 'ja-JP';
  if (han > 15 && hiragana == 0) return 'zh-CN';

  // Latin-script languages all look alike by codepoint, so fall back to
  // scoring how many of each language's common short words show up.
  final lower = ' ${text.toLowerCase()} ';
  String bestLocale = fallbackLocale;
  int bestScore = 3; // require a minimum signal before trusting a guess
  for (final entry in _latinScriptMarkers.entries) {
    var score = 0;
    for (final word in entry.value) {
      score += word.allMatches(lower).length;
    }
    if (score > bestScore) {
      bestScore = score;
      bestLocale = entry.key;
    }
  }
  return bestLocale;
}

final RegExp _sentencePattern = RegExp(
  r'(?<!\b(?:Mr|Mrs|Ms|Dr|Prof|Sr|Jr|vs|etc|Inc|Corp|Ltd|Co|St|Ave|Blvd|Rd|U\.S|U\.K|Ph\.D|B\.A|M\.A|i\.e|e\.g|A\.M|P\.M|a\.m|p\.m|No|Vol|Fig|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|ft|in|lb|oz|min|hr|sec|mph|km|mi|kg|mg|cm|mm|yr|yrs|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\.)(?<=[.!?])\s+(?=[A-Z0-9])|(?<=[.!?])\s*$',
  multiLine: true,
);

/// Splits [text] into TTS-speakable sentences. Returns [emptyTextMessage]
/// as the sole "sentence" if [text] is blank, or [noSentencesFoundMessage]
/// if splitting somehow yields nothing usable.
List<String> processSentencesFromText(
  String text, {
  required String emptyTextMessage,
  required String noSentencesFoundMessage,
}) {
  if (text.trim().isEmpty) return [emptyTextMessage];

  // Clean text. \p{L}/\p{N} (Unicode letters/digits) are used instead of
  // the ASCII-only \w so that accented Latin, Cyrillic, Arabic, Devanagari
  // and CJK text survive this pass instead of being stripped to fragments
  // before TTS ever sees it.
  final cleanedText =
      text
          .replaceAll(RegExp(r'\s+'), ' ')
          .replaceAll(RegExp(r'[^\p{L}\p{N}\s.,!?;:()-]', unicode: true), '')
          .trim();

  final sentences =
      cleanedText
          .split(_sentencePattern)
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty && s.length > 5)
          .toList();

  return sentences.isEmpty ? [noSentencesFoundMessage] : sentences;
}
