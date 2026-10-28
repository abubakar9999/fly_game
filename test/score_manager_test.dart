import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/game/managers/score_manager.dart';

void main() {
  group('ScoreManager', () {
    test('initializes with default values', () {
      final manager = ScoreManager(initialLives: 5, initialHighScore: 50);
      expect(manager.score, 0);
      expect(manager.lives, 5);
      expect(manager.highScore, 50);
    });

    test('addScore updates score and updates highScore when exceeded', () {
      final manager = ScoreManager(initialLives: 3, initialHighScore: 10);

      manager.addScore(5);
      expect(manager.score, 5);
      expect(manager.highScore, 10);

      manager.addScore(10);
      expect(manager.score, 15);
      expect(manager.highScore, 15);
    });

    test('loseLife decrements lives and returns true when lives reach 0', () {
      final manager = ScoreManager(initialLives: 2);

      final dead1 = manager.loseLife();
      expect(manager.lives, 1);
      expect(dead1, isFalse);

      final dead2 = manager.loseLife();
      expect(manager.lives, 0);
      expect(dead2, isTrue);

      // Subsequent loseLife shouldn't drop below 0
      final dead3 = manager.loseLife();
      expect(manager.lives, 0);
      expect(dead3, isTrue);
    });

    test('reset restores initial lives and zeroes score while preserving high score', () {
      final manager = ScoreManager(initialLives: 3, initialHighScore: 20);
      manager.addScore(40);
      manager.loseLife();

      manager.reset(initialLives: 5);
      expect(manager.score, 0);
      expect(manager.lives, 5);
      expect(manager.highScore, 40);
    });
  });
}

