import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/game/components/meteor.dart';
import 'package:fly_game_kids/game/models/power_up_type.dart';
import 'package:fly_game_kids/game/space_game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Power-Up Mechanics Tests', () {
    test('SpaceGame activates power-up timers accurately', () {
      final game = SpaceGame();
      expect(game.isMagnetActive, isFalse);
      expect(game.isSlowMoActive, isFalse);
      expect(game.rocket.hasShield, isFalse);

      // Magnet
      game.activatePowerUp(PowerUpType.magnet);
      expect(game.isMagnetActive, isTrue);
      expect(game.magnetTimer, 6.0);

      // Shield
      game.activatePowerUp(PowerUpType.shield);
      expect(game.rocket.hasShield, isTrue);

      // Slow-Mo
      game.activatePowerUp(PowerUpType.slowMo);
      expect(game.isSlowMoActive, isTrue);
      expect(game.slowMoTimer, 6.0);
    });

    test('Slow-Mo power-up reduces fall speed', () {
      final game = SpaceGame();
      final normalSpeed = game.currentFallSpeed;

      game.activatePowerUp(PowerUpType.slowMo);
      final slowedSpeed = game.currentFallSpeed;
      expect(slowedSpeed, lessThan(normalSpeed));
      expect(slowedSpeed, closeTo(normalSpeed * 0.55, 0.01));
    });

    test('Shield absorbs meteor collision and protects player lives', () async {
      final game = SpaceGame();
      await game.add(game.rocket);
      game.rocket.hasShield = true;
      final initialLives = game.scoreManager.lives;

      final meteor = Meteor(speed: 100, position: Vector2.zero());
      game.rocket.onCollisionStart({Vector2.zero()}, meteor);

      expect(game.rocket.hasShield, isFalse);
      expect(game.scoreManager.lives, initialLives); // Lives protected!
    });
  });
}
