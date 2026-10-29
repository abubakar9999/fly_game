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

/// Primary game modes: classic star arcade vs. educational alphabet quest.
enum GamePlayMode {
  arcade,
  alphabetQuest,
}

/// Unlockable rocket customization skins for children.
enum RocketSkin {
  classic,
  dragon,
  ufo,
  candy,
}

class RocketSkinConfig {
  final String name;
  final String emoji;
  final Color bodyColor;
  final Color finColor;
  final Color windowColor;
  final Color flameColor;

  const RocketSkinConfig({
    required this.name,
    required this.emoji,
    required this.bodyColor,
    required this.finColor,
    required this.windowColor,
    required this.flameColor,
  });

  static const RocketSkinConfig classic = RocketSkinConfig(
    name: 'Classic Apollo',
    emoji: '🚀',
    bodyColor: Color(0xFFFF5252),
    finColor: Color(0xFFFFD54F),
    windowColor: Color(0xFF64B5F6),
    flameColor: Color(0xFFFF9800),
  );

  static const RocketSkinConfig dragon = RocketSkinConfig(
    name: 'Dragon Flame',
    emoji: '🐲',
    bodyColor: Color(0xFFD50000),
    finColor: Color(0xFFFFAB00),
    windowColor: Color(0xFFFFEB3B),
    flameColor: Color(0xFFFF3D00),
  );

  static const RocketSkinConfig ufo = RocketSkinConfig(
    name: 'Cosmo Saucer',
    emoji: '🛸',
    bodyColor: Color(0xFF00E5FF),
    finColor: Color(0xFF76FF03),
    windowColor: Color(0xFF00B0FF),
    flameColor: Color(0xFF1DE9B6),
  );

  static const RocketSkinConfig candy = RocketSkinConfig(
    name: 'Candy Pop',
    emoji: '🍭',
    bodyColor: Color(0xFFFF4081),
    finColor: Color(0xFFE040FB),
    windowColor: Color(0xFF80D8FF),
    flameColor: Color(0xFFFF80AB),
  );

  static RocketSkinConfig of(RocketSkin skin) {
    switch (skin) {
      case RocketSkin.classic:
        return classic;
      case RocketSkin.dragon:
        return dragon;
      case RocketSkin.ufo:
        return ufo;
      case RocketSkin.candy:
        return candy;
    }
  }
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
