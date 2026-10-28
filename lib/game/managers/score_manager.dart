import 'package:flutter/foundation.dart';

/// Manages game score, lives, and high scores using ValueNotifier.
class ScoreManager {
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> livesNotifier = ValueNotifier<int>(3);
  final ValueNotifier<int> highScoreNotifier = ValueNotifier<int>(0);

  int get score => scoreNotifier.value;
  int get lives => livesNotifier.value;
  int get highScore => highScoreNotifier.value;

  ScoreManager({int initialLives = 3, int initialHighScore = 0}) {
    livesNotifier.value = initialLives;
    highScoreNotifier.value = initialHighScore;
  }

  /// Adds points to the current score and updates high score if exceeded.
  void addScore(int points) {
    if (points <= 0) return;
    final newScore = scoreNotifier.value + points;
    scoreNotifier.value = newScore;

    if (newScore > highScoreNotifier.value) {
      highScoreNotifier.value = newScore;
    }
  }

  /// Decrements lives by 1. Returns true if remaining lives reach 0 (game ended).
  bool loseLife() {
    if (livesNotifier.value > 0) {
      livesNotifier.value -= 1;
    }
    return livesNotifier.value <= 0;
  }

  /// Resets score and lives for a new game session.
  void reset({required int initialLives}) {
    scoreNotifier.value = 0;
    livesNotifier.value = initialLives;
  }

  /// Sets high score (e.g. loaded from persistence).
  void setHighScore(int newHighScore) {
    highScoreNotifier.value = newHighScore;
  }

  void dispose() {
    scoreNotifier.dispose();
    livesNotifier.dispose();
    highScoreNotifier.dispose();
  }
}

