import 'dart:io';
import 'lib/services/settings_service.dart';

void main() async {
  print('Testing Reading Settings Integration...\n');

  final settingsService = SettingsService();

  try {
    // Test default reading settings
    print('1. Testing default reading settings:');
    final defaultFontSize = await settingsService.getReadingFontSize();
    final defaultLineHeight = await settingsService.getReadingLineHeight();
    
    print('   Default font size: $defaultFontSize');
    print('   Default line height: $defaultLineHeight');
    assert(defaultFontSize == 16.0, 'Default font size should be 16.0');
    assert(defaultLineHeight == 1.5, 'Default line height should be 1.5');
    print('   ✓ Default reading settings are correct\n');

    // Test setting and getting font size
    print('2. Testing font size persistence:');
    const testFontSize = 20.0;
    await settingsService.setReadingFontSize(testFontSize);
    final retrievedFontSize = await settingsService.getReadingFontSize();
    print('   Set font size: $testFontSize');
    print('   Retrieved font size: $retrievedFontSize');
    assert(retrievedFontSize == testFontSize, 'Font size should persist correctly');
    print('   ✓ Font size persistence works\n');

    // Test setting and getting line height
    print('3. Testing line height persistence:');
    const testLineHeight = 2.0;
    await settingsService.setReadingLineHeight(testLineHeight);
    final retrievedLineHeight = await settingsService.getReadingLineHeight();
    print('   Set line height: $testLineHeight');
    print('   Retrieved line height: $retrievedLineHeight');
    assert(retrievedLineHeight == testLineHeight, 'Line height should persist correctly');
    print('   ✓ Line height persistence works\n');

    // Test settings export includes reading settings
    print('4. Testing settings export:');
    final exportedSettings = await settingsService.exportSettings();
    print('   Exported settings: $exportedSettings');
    assert(exportedSettings.containsKey('reading'), 'Exported settings should contain reading section');
    assert(exportedSettings['reading']['fontSize'] == testFontSize, 'Exported font size should match');
    assert(exportedSettings['reading']['lineHeight'] == testLineHeight, 'Exported line height should match');
    print('   ✓ Settings export includes reading settings\n');

    // Test reset to defaults
    print('5. Testing reset to defaults:');
    await settingsService.resetToDefaults();
    final resetFontSize = await settingsService.getReadingFontSize();
    final resetLineHeight = await settingsService.getReadingLineHeight();
    print('   Reset font size: $resetFontSize');
    print('   Reset line height: $resetLineHeight');
    assert(resetFontSize == 16.0, 'Reset font size should be 16.0');
    assert(resetLineHeight == 1.5, 'Reset line height should be 1.5');
    print('   ✓ Reset to defaults works\n');

    print('🎉 All reading settings tests passed!');
    print('✅ Reading settings integration is working correctly.');
    
  } catch (e) {
    print('❌ Test failed: $e');
    exit(1);
  }
}
