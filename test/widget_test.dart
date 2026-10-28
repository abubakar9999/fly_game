import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/app/app.dart';
import 'package:fly_game_kids/game/space_game.dart';
import 'package:fly_game_kids/services/storage_service.dart';
import 'package:fly_game_kids/ui/game_play_screen.dart';
import 'package:fly_game_kids/ui/home_screen.dart';
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
  });

  testWidgets('App launches and displays HomeScreen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'highScore_medium': 42,
    });

    final storageService = StorageService();

    await tester.pumpWidget(
      SpaceJourneyApp(storageService: storageService),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.textContaining('Space Journey'), findsOneWidget);
  });

  testWidgets('Tapping Play transitions to GamePlayScreen without LateError', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'highScore_medium': 42,
    });

    final storageService = StorageService();

    await tester.pumpWidget(
      SpaceJourneyApp(storageService: storageService),
    );
    await tester.pumpAndSettle();

    // Tap Play button
    final playButton = find.text('Play');
    expect(playButton, findsOneWidget);
    await tester.tap(playButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify GamePlayScreen and GameWidget are mounted
    expect(find.byType(GamePlayScreen), findsOneWidget);
    expect(find.byType(GameWidget<SpaceGame>), findsOneWidget);
  });
}
