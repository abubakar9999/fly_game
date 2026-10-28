import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/game/config.dart';
import 'package:fly_game_kids/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StorageService', () {
    test('loads and saves high score for each difficulty', () async {
      SharedPreferences.setMockInitialValues({});
      final service = StorageService();

      expect(await service.getHighScore(GameDifficulty.easy), 0);
      await service.saveHighScore(GameDifficulty.easy, 15);
      expect(await service.getHighScore(GameDifficulty.easy), 15);

      // Lower score should not overwrite higher score
      await service.saveHighScore(GameDifficulty.easy, 10);
      expect(await service.getHighScore(GameDifficulty.easy), 15);

      // Higher score overwrites
      await service.saveHighScore(GameDifficulty.easy, 30);
      expect(await service.getHighScore(GameDifficulty.easy), 30);
    });

    test('loads and saves mute and language preferences', () async {
      SharedPreferences.setMockInitialValues({});
      final service = StorageService();

      expect(await service.getIsMuted(), isFalse);
      await service.saveIsMuted(true);
      expect(await service.getIsMuted(), isTrue);

      expect(await service.getLanguage(), 'en');
      await service.saveLanguage('bn');
      expect(await service.getLanguage(), 'bn');
    });
  });
}

