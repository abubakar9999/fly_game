import 'package:flutter/material.dart';

/// Game configuration and tuning constants.
class GameConfig {
  GameConfig._();

  // Player Rocket settings
  static const double rocketWidth = 54.0;
  static const double rocketHeight = 72.0;
  static const double rocketBottomPadding = 48.0;
  static const double rocketMaxSpeed = 480.0; // px per second
  static const double rocketDragSensitivity = 1.0;

  // Tilt settings
  static const double tiltSmoothingFactor = 0.2; // 20% new, 80% old
  static const double tiltMaxAngle = 5.0; // Radian/accel cutoff for max tilt

  // Collectibles & Hazards sizes and points
  static const double starSize = 36.0;
  static const double planetSize = 56.0;
  static const double meteorSize = 48.0;
  static const int starPoints = 1;
  static const int planetPoints = 5;

  // Background and offscreen margins
  static const double backgroundSlowSpeed = 35.0;
  static const double backgroundFastSpeed = 80.0;
  static const double offScreenMargin = 60.0;

  // Invincibility & Feedback
  static const double invincibilityDuration = 1.5; // seconds
  static const double blinkInterval = 0.1; // seconds

  // Colors for placeholder rendering
  static const Color rocketBodyColor = Color(0xFFFF5252);
  static const Color rocketWindowColor = Color(0xFF64B5F6);
  static const Color rocketFinColor = Color(0xFFFFD54F);
  static const Color flameColor = Color(0xFFFF9800);
  static const Color starColor = Color(0xFFFFEB3B);
  static const Color planetColor = Color(0xFF81C784);
  static const Color meteorColor = Color(0xFF8D6E63);
}

/// Difficulty modes and their runtime values.
enum GameDifficulty {
  easy,
  medium,
  hard,
}

class DifficultyConfig {
  final int initialLives;
  final double baseFallSpeed;
  final double starSpawnInterval;
  final double planetSpawnInterval;
  final double meteorSpawnInterval;

  const DifficultyConfig({
    required this.initialLives,
    required this.baseFallSpeed,
    required this.starSpawnInterval,
    required this.planetSpawnInterval,
    required this.meteorSpawnInterval,
  });

  static const DifficultyConfig easy = DifficultyConfig(
    initialLives: 5,
    baseFallSpeed: 160.0,
    starSpawnInterval: 1.2,
    planetSpawnInterval: 4.5,
    meteorSpawnInterval: 2.8,
  );

  static const DifficultyConfig medium = DifficultyConfig(
    initialLives: 3,
    baseFallSpeed: 230.0,
    starSpawnInterval: 1.0,
    planetSpawnInterval: 5.0,
    meteorSpawnInterval: 1.8,
  );

  static const DifficultyConfig hard = DifficultyConfig(
    initialLives: 3,
    baseFallSpeed: 300.0,
    starSpawnInterval: 0.9,
    planetSpawnInterval: 6.0,
    meteorSpawnInterval: 1.1,
  );

  static DifficultyConfig of(GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return easy;
      case GameDifficulty.medium:
        return medium;
      case GameDifficulty.hard:
        return hard;
    }
  }
}
