import 'lib/services/streak_service.dart';

void main() async {
  // Initialize the streak service
  final streakService = StreakService();
  await streakService.loadStreaks();

  // Test streak functionality
  print('Testing Streak Functionality');
  print('==========================');

  final testFilePath = '/test/document.pdf';

  // Test 1: Record document opened
  print('\n1. Opening document for the first time...');
  await streakService.recordDocumentOpened(testFilePath);
  int streakCount = streakService.getCurrentStreakCount(testFilePath);
  print('Streak count: $streakCount (should be 1)');

  // Test 2: Check if streak is about to expire
  bool aboutToExpire = streakService.isStreakAboutToExpire(testFilePath);
  print('About to expire: $aboutToExpire (should be false)');

  // Test 3: Mark document as completed
  print('\n2. Marking document as completed...');
  await streakService.markDocumentCompleted(testFilePath);
  streakCount = streakService.getCurrentStreakCount(testFilePath);
  print('Streak count after completion: $streakCount (should be 1)');

  // Test 4: Check completed status
  final streak = streakService.getStreak(testFilePath);
  print('Is completed: ${streak?.isCompleted} (should be true)');
  print('Completed at: ${streak?.completedAt}');

  // Test 5: Simulate opening again (should maintain streak)
  print('\n3. Opening completed document again...');
  await streakService.recordDocumentOpened(testFilePath);
  streakCount = streakService.getCurrentStreakCount(testFilePath);
  print('Streak count after reopening: $streakCount (should still be 1)');

  print('\n✅ Streak functionality test completed!');
}
