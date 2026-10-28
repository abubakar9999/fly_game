import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/game/managers/audio_manager.dart';

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

  group('AudioManager', () {
    test('initializes unmuted by default', () {
      final manager = AudioManager();
      expect(manager.isMuted, isFalse);
    });

    test('setMuted updates mute state', () {
      final manager = AudioManager();
      manager.setMuted(true);
      expect(manager.isMuted, isTrue);

      manager.setMuted(false);
      expect(manager.isMuted, isFalse);
    });

    test('plays sounds gracefully without throwing even when audio files are absent', () async {
      final manager = AudioManager();
      manager.setMuted(true);

      // Muted should safely return without trying to play
      await expectLater(manager.playCollect(), completes);
      await expectLater(manager.playHit(), completes);
      await expectLater(manager.playTap(), completes);
      await expectLater(manager.startBgm(), completes);
    });
  });
}
