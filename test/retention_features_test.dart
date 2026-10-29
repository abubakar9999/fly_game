import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/game/components/rocket.dart';
import 'package:fly_game_kids/game/config.dart';
import 'package:fly_game_kids/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Retention & Engagement Features Tests', () {
    test('Rocket combo streak triggers Star-Power at 3 consecutive hits', () {
      final rocket = Rocket();
      expect(rocket.comboStreak, 0);
      expect(rocket.isStarPower, isFalse);

      rocket.registerHitSuccess();
      expect(rocket.comboStreak, 1);
      expect(rocket.isStarPower, isFalse);

      rocket.registerHitSuccess();
      expect(rocket.comboStreak, 2);
      expect(rocket.isStarPower, isFalse);

      rocket.registerHitSuccess();
      expect(rocket.comboStreak, 3);
      expect(rocket.isStarPower, isTrue);

      rocket.resetCombo();
      expect(rocket.comboStreak, 0);
      expect(rocket.isStarPower, isFalse);
    });

    test('Rocket changes skins cleanly', () {
      final rocket = Rocket(skin: RocketSkin.classic);
      expect(rocket.skin, RocketSkin.classic);

      rocket.setSkin(RocketSkin.ufo);
      expect(rocket.skin, RocketSkin.ufo);

      rocket.setSkin(RocketSkin.candy);
      expect(rocket.skin, RocketSkin.candy);
    });

    test('StorageService persists rocket skins, stickers, and stars', () async {
      SharedPreferences.setMockInitialValues({});
      final storage = StorageService();

      // Test skin
      expect(await storage.getRocketSkin(), RocketSkin.classic);
      await storage.saveRocketSkin(RocketSkin.dragon);
      expect(await storage.getRocketSkin(), RocketSkin.dragon);

      // Test stickers
      expect(await storage.getUnlockedStickers(), isEmpty);
      await storage.unlockSticker('A');
      await storage.unlockSticker('B');
      await storage.unlockSticker('A'); // Duplicate should be handled
      final stickers = await storage.getUnlockedStickers();
      expect(stickers, {'A', 'B'});

      // Test stars
      expect(await storage.getTotalStars(), 0);
      await storage.addTotalStars(15);
      expect(await storage.getTotalStars(), 15);
    });
  });
}

