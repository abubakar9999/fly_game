import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/config.dart';
import '../game/space_game.dart';
import '../services/storage_service.dart';
import 'hud_overlay.dart';
import 'pause_overlay.dart';
import 'result_overlay.dart';

/// Screen hosting the active GameWidget and overlays.
class GamePlayScreen extends StatefulWidget {
  final GameDifficulty difficulty;
  final StorageService storageService;

  const GamePlayScreen({
    super.key,
    required this.difficulty,
    required this.storageService,
  });

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  late final SpaceGame _game;

  @override
  void initState() {
    super.initState();
    _game = SpaceGame(difficulty: widget.difficulty);

    _initializeSettings();

    // Listen to score changes to persist high score automatically
    _game.scoreManager.highScoreNotifier.addListener(_onHighScoreChanged);
  }

  Future<void> _initializeSettings() async {
    final muted = await widget.storageService.getIsMuted();
    _game.isInitiallyMuted = muted;

    final highScore = await widget.storageService.getHighScore(widget.difficulty);
    _game.scoreManager.setHighScore(highScore);
  }

  void _onHighScoreChanged() {
    final newHighScore = _game.scoreManager.highScore;
    widget.storageService.saveHighScore(widget.difficulty, newHighScore);
  }

  @override
  void dispose() {
    _game.scoreManager.highScoreNotifier.removeListener(_onHighScoreChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: GameWidget<SpaceGame>(
        game: _game,
        initialActiveOverlays: const ['hud'],
        overlayBuilderMap: {
          'hud': (context, game) => HudOverlay(game: game),
          'pause': (context, game) => PauseOverlay(game: game),
          'result': (context, game) => ResultOverlay(game: game),
        },
      ),
    );
  }
}
