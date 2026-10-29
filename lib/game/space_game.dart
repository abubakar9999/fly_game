import 'dart:math' as math;
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/tilt_service.dart';
import '../services/voice_service.dart';
import 'components/collect_effect.dart';
import 'components/letter_bubble.dart';
import 'components/meteor.dart';
import 'components/planet.dart';
import 'components/rocket.dart';
import 'components/spawner.dart';
import 'components/star.dart';
import 'components/star_background.dart';
import 'config.dart';
import 'managers/alphabet_manager.dart';
import 'managers/audio_manager.dart';
import 'managers/score_manager.dart';
import 'models/alphabet_data.dart';

/// Main Flame game loop for Space Journey & Alphabet Astronaut.
class SpaceGame extends FlameGame with HasCollisionDetection, PanDetector {
  final TiltService tiltService = TiltService();
  final StarBackground starBackground = StarBackground();
  final Rocket rocket = Rocket();
  final AudioManager audioManager = AudioManager();
  final ScoreManager scoreManager = ScoreManager();
  final VoiceService voiceService = VoiceService();
  final AlphabetManager alphabetManager = AlphabetManager();
  Spawner? spawner;

  GameDifficulty difficulty = GameDifficulty.medium;
  DifficultyConfig difficultyConfig = DifficultyConfig.medium;
  GamePlayMode gameMode = GamePlayMode.arcade;
  RocketSkin rocketSkin = RocketSkin.classic;
  void Function(String sticker)? onStickerUnlocked;

  double speedMultiplier = 1.0;
  double _difficultyTimer = 0.0;
  bool isPlaying = false;
  bool isInitiallyMuted = false;

  bool get isLearningMode => gameMode == GamePlayMode.alphabetQuest;

  // Screen shake state
  final math.Random _random = math.Random();
  double _shakeTimer = 0.0;
  final Vector2 _shakeOffset = Vector2.zero();

  double get currentFallSpeed => difficultyConfig.baseFallSpeed * speedMultiplier;

  SpaceGame({
    GameDifficulty? difficulty,
    bool? isInitiallyMuted,
    GamePlayMode? gameMode,
    AlphabetType? alphabetType,
    RocketSkin? rocketSkin,
    this.onStickerUnlocked,
  }) {
    if (difficulty != null) {
      this.difficulty = difficulty;
      difficultyConfig = DifficultyConfig.of(difficulty);
      scoreManager.reset(initialLives: difficultyConfig.initialLives);
    }
    if (isInitiallyMuted != null) {
      this.isInitiallyMuted = isInitiallyMuted;
    }
    if (gameMode != null) {
      this.gameMode = gameMode;
    }
    if (alphabetType != null) {
      alphabetManager.setType(alphabetType);
    }
    if (rocketSkin != null) {
      this.rocketSkin = rocketSkin;
      rocket.setSkin(rocketSkin);
    }
  }

  @override
  Color backgroundColor() => const Color(0xFF0B0E14);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    audioManager.setMuted(isInitiallyMuted);
    audioManager.startBgm();

    voiceService.isMuted = isInitiallyMuted;
    await voiceService.init();

    tiltService.start();

    // 1. Parallax background
    if (!starBackground.isMounted) {
      await add(starBackground);
    }

    // 2. Rocket player
    if (!rocket.isMounted) {
      await add(rocket);
    }

    // 3. Spawner
    spawner ??= Spawner();
    if (!spawner!.isMounted) {
      await add(spawner!);
    }

    isPlaying = true;
  }

  void onStarCollected(Star star) {
    scoreManager.addScore(GameConfig.starPoints);
    audioManager.playCollect();
    try {
      HapticFeedback.lightImpact();
    } catch (_) {}

    add(
      CollectEffect(
        position: star.position.clone(),
        particleColor: GameConfig.starColor,
      ),
    );
  }

  void onPlanetCollected(Planet planet) {
    scoreManager.addScore(GameConfig.planetPoints);
    audioManager.playCollect();
    try {
      HapticFeedback.mediumImpact();
    } catch (_) {}

    add(
      CollectEffect(
        position: planet.position.clone(),
        particleColor: const Color(0xFF4DD0E1),
        particleCount: 14,
      ),
    );
  }

  void onMeteorHit(Meteor meteor) {
    rocket.resetCombo();
    shakeScreen();
    audioManager.playHit();
    try {
      HapticFeedback.heavyImpact();
    } catch (_) {}

    final isGameOver = scoreManager.loseLife();
    if (isGameOver) {
      endRun();
    }
  }

  /// Handles collision between the player rocket and a falling alphabet bubble.
  void handleLetterHit(LetterBubble bubble) {
    if (!isPlaying) return;

    final targetHit = alphabetManager.checkHit(bubble.letter);
    if (targetHit) {
      // Correct target hit: build combo & star-power
      rocket.registerHitSuccess();
      try {
        HapticFeedback.lightImpact();
      } catch (_) {}

      scoreManager.addScore(10);
      audioManager.playCollect();
      voiceService.speakLetterWithPhonics(bubble.letter, type: alphabetManager.type);
      onStickerUnlocked?.call(bubble.letter);

      add(
        CollectEffect(
          position: bubble.position.clone(),
          particleColor: const Color(0xFFFFD700),
          particleCount: 18,
        ),
      );

      bubble.removeFromParent();

      if (alphabetManager.isCompleted) {
        completeAlphabetRun();
      }
    } else {
      // Distractor hit: gentle playful sound without losing lives
      rocket.resetCombo();
      try {
        HapticFeedback.selectionClick();
      } catch (_) {}
      audioManager.playTap();
      bubble.removeFromParent();
    }
  }

  /// Celebrates completing the alphabet sequence!
  void completeAlphabetRun() {
    isPlaying = false;
    spawner?.stopSpawning();
    audioManager.pauseBgm();
    voiceService.speakText('Awesome job! Alphabet completed!');

    overlays.remove('hud');
    overlays.remove('alphabet_hud');
    overlays.add('alphabet_win');
  }

  /// Triggers a brief screen shake effect.
  void shakeScreen() {
    _shakeTimer = 0.35;
  }

  /// Ends the current run and displays the friendly "Try again!" overlay.
  void endRun() {
    isPlaying = false;
    spawner?.stopSpawning();
    audioManager.pauseBgm();
    overlays.remove('hud');
    overlays.remove('alphabet_hud');
    overlays.add('result');
  }

  /// Pauses the game loop and shows the pause overlay.
  void pauseGame() {
    pauseEngine();
    audioManager.pauseBgm();
    overlays.add('pause');
  }

  /// Resumes the game loop and hides the pause overlay.
  void resumeGame() {
    resumeEngine();
    audioManager.resumeBgm();
    overlays.remove('pause');
  }

  /// Restarts a new session with the given or current difficulty.
  void restart({GameDifficulty? newDifficulty}) {
    if (newDifficulty != null) {
      difficulty = newDifficulty;
    }
    difficultyConfig = DifficultyConfig.of(difficulty);
    speedMultiplier = 1.0;
    _difficultyTimer = 0.0;
    _shakeTimer = 0.0;
    _shakeOffset.setZero();

    // Remove existing falling entities and particles
    children.whereType<Star>().forEach((s) => s.removeFromParent());
    children.whereType<Planet>().forEach((p) => p.removeFromParent());
    children.whereType<Meteor>().forEach((m) => m.removeFromParent());
    children.whereType<LetterBubble>().forEach((l) => l.removeFromParent());
    children.whereType<CollectEffect>().forEach((c) => c.removeFromParent());

    // Reset player rocket and score
    rocket.resetPosition();
    rocket.resetCombo();
    scoreManager.reset(initialLives: difficultyConfig.initialLives);

    // Reset spawner and alphabet state
    spawner?.reset();
    if (isLearningMode) {
      alphabetManager.reset();
    }
    isPlaying = true;

    // Reset overlays
    overlays.remove('result');
    overlays.remove('pause');
    overlays.remove('alphabet_win');

    if (isLearningMode) {
      overlays.remove('hud');
      overlays.add('alphabet_hud');
    } else {
      overlays.remove('alphabet_hud');
      overlays.add('hud');
    }

    resumeEngine();
    audioManager.resumeBgm();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Screen shake update
    if (_shakeTimer > 0) {
      _shakeTimer -= dt;
      if (_shakeTimer <= 0) {
        _shakeOffset.setZero();
      } else {
        _shakeOffset.setValues(
          (_random.nextDouble() * 2.0 - 1.0) * 8.0,
          (_random.nextDouble() * 2.0 - 1.0) * 8.0,
        );
      }
    }

    if (!isPlaying) return;

    // Difficulty scaling: speed increases gradually every 20 seconds
    _difficultyTimer += dt;
    if (_difficultyTimer >= 20.0) {
      _difficultyTimer = 0.0;
      speedMultiplier = (speedMultiplier * 1.05).clamp(1.0, 2.5);
      spawner?.updateIntervals(speedMultiplier);
    }
  }

  @override
  void render(Canvas canvas) {
    if (_shakeTimer > 0) {
      canvas.save();
      canvas.translate(_shakeOffset.x, _shakeOffset.y);
      super.render(canvas);
      canvas.restore();
    } else {
      super.render(canvas);
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (isPlaying) {
      rocket.moveBy(info.delta.global.x);
    }
  }

  @override
  void onDetach() {
    tiltService.dispose();
    scoreManager.dispose();
    audioManager.dispose();
    alphabetManager.dispose();
    voiceService.stop();
    super.onDetach();
  }
}
