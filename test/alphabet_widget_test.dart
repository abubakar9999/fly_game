import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/app/app.dart';
import 'package:fly_game_kids/services/storage_service.dart';
import 'package:fly_game_kids/ui/alphabet_hud_overlay.dart';
import 'package:fly_game_kids/ui/learning_world_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers.global'),
      (MethodCall methodCall) async => null,
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers'),
      (MethodCall methodCall) async => null,
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_tts'),
      (MethodCall methodCall) async => 1,
    );
  });

  testWidgets('Can launch Alphabet Quest and view learning HUD', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'highScore_medium': 50,
    });

    final storageService = StorageService();

    await tester.pumpWidget(
      SpaceJourneyApp(storageService: storageService),
    );
    await tester.pumpAndSettle();

    // Verify Alphabet Quest button exists
    final questButton = find.textContaining('Alphabet Quest');
    expect(questButton, findsOneWidget);

    // Tap Alphabet Quest
    await tester.tap(questButton);
    await tester.pumpAndSettle();

    // Verify dialog opens
    expect(find.byType(LearningWorldDialog), findsOneWidget);
    expect(find.text('English Alphabet'), findsOneWidget);
    expect(find.text('বাংলা স্বরবর্ণ'), findsOneWidget);

    // Tap English Alphabet
    await tester.tap(find.text('English Alphabet'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify AlphabetHudOverlay is active with target 'A'
    expect(find.byType(AlphabetHudOverlay), findsOneWidget);
    expect(find.textContaining('Catch:'), findsOneWidget);
    expect(find.text('A'), findsWidgets);
  });
}

