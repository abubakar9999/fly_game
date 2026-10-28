import 'dart:math' as math;
import 'package:flame/components.dart';

import '../config.dart';
import '../space_game.dart';
import 'meteor.dart';
import 'planet.dart';
import 'star.dart';

/// Manages timed spawning of stars, planets, and meteors.
class Spawner extends Component with HasGameReference<SpaceGame> {
  final math.Random _random = math.Random();

  Timer? _starTimer;
  Timer? _planetTimer;
  Timer? _meteorTimer;

  bool _isSpawning = true;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _configureTimers();
  }

  void _configureTimers() {
    final config = game.difficultyConfig;

    _starTimer = Timer(
      config.starSpawnInterval,
      repeat: true,
      onTick: _spawnStar,
    );

    _planetTimer = Timer(
      config.planetSpawnInterval,
      repeat: true,
      onTick: _spawnPlanet,
    );

    _meteorTimer = Timer(
      config.meteorSpawnInterval,
      repeat: true,
      onTick: _spawnMeteor,
    );
  }

  /// Updates timer intervals when difficulty or speed changes.
  void updateIntervals(double speedMultiplier) {
    final config = game.difficultyConfig;
    final starInterval = math.max(0.4, config.starSpawnInterval / speedMultiplier);
    final planetInterval = math.max(1.8, config.planetSpawnInterval / speedMultiplier);
    final meteorInterval = math.max(0.6, config.meteorSpawnInterval / speedMultiplier);

    _starTimer?.limit = starInterval;
    _planetTimer?.limit = planetInterval;
    _meteorTimer?.limit = meteorInterval;
  }

  void startSpawning() {
    _isSpawning = true;
    _starTimer?.start();
    _planetTimer?.start();
    _meteorTimer?.start();
  }

  void stopSpawning() {
    _isSpawning = false;
    _starTimer?.stop();
    _planetTimer?.stop();
    _meteorTimer?.stop();
  }

  void reset() {
    _starTimer?.reset();
    _planetTimer?.reset();
    _meteorTimer?.reset();
    startSpawning();
  }

  double _getRandomX(double padding) {
    final w = game.size.x;
    if (w <= padding * 2) return w / 2;
    return padding + _random.nextDouble() * (w - padding * 2);
  }

  void _spawnStar() {
    if (!_isSpawning || game.size.x <= 0) return;
    final x = _getRandomX(GameConfig.starSize);
    final y = -GameConfig.offScreenMargin / 2;
    final speed = game.currentFallSpeed;
    game.add(Star(speed: speed, position: Vector2(x, y)));
  }

  void _spawnPlanet() {
    if (!_isSpawning || game.size.x <= 0) return;
    final x = _getRandomX(GameConfig.planetSize);
    final y = -GameConfig.offScreenMargin / 2;
    final speed = game.currentFallSpeed * 0.9;
    game.add(Planet(speed: speed, position: Vector2(x, y)));
  }

  void _spawnMeteor() {
    if (!_isSpawning || game.size.x <= 0) return;
    final x = _getRandomX(GameConfig.meteorSize);
    final y = -GameConfig.offScreenMargin / 2;
    final speed = game.currentFallSpeed * 1.1;
    final rotation = (_random.nextDouble() * 2.0 - 1.0) * 2.0;
    game.add(Meteor(speed: speed, rotationSpeed: rotation, position: Vector2(x, y)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_isSpawning) return;

    _starTimer?.update(dt);
    _planetTimer?.update(dt);
    _meteorTimer?.update(dt);
  }
}
