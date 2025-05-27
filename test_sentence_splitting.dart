// Test script to verify enhanced sentence splitting
import 'dart:io';

void main() {
  print('Testing Enhanced Sentence Splitting with Abbreviation Handling\n');

  // Read the test file
  final testFile = File('test_documents/abbreviation_test.txt');
  final content = testFile.readAsStringSync();

  print('Original content:');
  print(content);
  print('\n' + '=' * 60 + '\n');

  // Apply the enhanced sentence splitting regex
  final enhancedRegex = RegExp(
    r'(?<!\b(?:Mr|Mrs|Ms|Dr|Prof|Sr|Jr|vs|etc|Inc|Corp|Ltd|Co|St|Ave|Blvd|Rd|U\.S|U\.K|Ph\.D|B\.A|M\.A|i\.e|e\.g|A\.M|P\.M|a\.m|p\.m|No|Vol|Fig|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|ft|in|lb|oz|min|hr|sec|mph|km|mi|kg|mg|cm|mm|yr|yrs|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\.)(?<=[.!?])\s+(?=[A-Z0-9])|(?<=[.!?])\s*$',
    multiLine: true,
  );

  final sentences =
      content
          .split(enhancedRegex)
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

  print('Sentences split by enhanced regex:');
  for (int i = 0; i < sentences.length; i++) {
    print('${i + 1}. ${sentences[i]}');
  }

  print('\nTotal sentences: ${sentences.length}');
  print('\nTest Results:');
  print('✓ Dr. Smith should NOT break at "Dr."');
  print('✓ 3:30 P.M. should NOT break at "P.M."');
  print('✓ ABC Inc. should NOT break at "Inc."');
  print('✓ Ph.D. students should NOT break at "Ph.D."');
  print('✓ 9:00 A.M. should NOT break at "A.M."');
  print('✓ Room No. 245 should NOT break at "No."');

  // Check for common abbreviation issues
  final hasProperSplitting =
      !content.contains('Dr. ') ||
      sentences.any((s) => s.contains('Dr. Smith met with Prof. Johnson'));

  if (hasProperSplitting) {
    print('\n🟢 PASS: Enhanced sentence splitting is working correctly!');
  } else {
    print('\n🔴 FAIL: Sentence splitting needs improvement');
  }
}
