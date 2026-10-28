import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/game/config.dart';

void main() {
  group('DifficultyConfig', () {
    test('Easy mode has 5 lives and gentle speed', () {
      final config = DifficultyConfig.of(GameDifficulty.easy);
      expect(config.initialLives, 5);
      expect(config.baseFallSpeed, lessThan(DifficultyConfig.of(GameDifficulty.medium).baseFallSpeed));
    });

    test('Medium mode has 3 lives and balanced spawn rates', () {
      final config = DifficultyConfig.of(GameDifficulty.medium);
      expect(config.initialLives, 3);
      expect(config.baseFallSpeed, 230.0);
    });

    test('Hard mode has 3 lives and fast fall speed', () {
      final config = DifficultyConfig.of(GameDifficulty.hard);
      expect(config.initialLives, 3);
      expect(config.baseFallSpeed, greaterThan(DifficultyConfig.of(GameDifficulty.medium).baseFallSpeed));
      expect(config.meteorSpawnInterval, lessThan(DifficultyConfig.of(GameDifficulty.medium).meteorSpawnInterval));
    });
  });
}

