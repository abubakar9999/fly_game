import 'package:flutter/material.dart';
import '../app/strings.dart';
import '../game/space_game.dart';

/// Friendly "Try again!" result dialog overlay.
class ResultOverlay extends StatelessWidget {
  final SpaceGame game;

  const ResultOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final score = game.scoreManager.score;
    final highScore = game.scoreManager.highScore;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28.0),
        padding: const EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          color: const Color(0xF21A1D2E),
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(
            color: const Color(0xFFFFD54F),
            width: 3.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 24.0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.stars_rounded,
              size: 64.0,
              color: Color(0xFFFFD54F),
            ),
            const SizedBox(height: 12.0),

            // Friendly encouraging message - Never "Game Over"!
            Text(
              GameStrings.tryAgain,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),

            // Score container
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 14.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Text(
                    '${GameStrings.score}: $score',
                    style: const TextStyle(
                      color: Color(0xFF81D4FA),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    '${GameStrings.highScore}: $highScore',
                    style: const TextStyle(
                      color: Color(0xFFFFE082),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),

            // Big Try Again / Play Again button (min 56px height)
            SizedBox(
              width: double.infinity,
              height: 58.0,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A047),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 6.0,
                ),
                onPressed: () => game.restart(),
                icon: const Icon(Icons.replay_rounded, size: 28.0),
                label: Text(
                  GameStrings.restart,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Home button (min 56px height)
            SizedBox(
              width: double.infinity,
              height: 56.0,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37474F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.home_rounded, size: 26.0),
                label: Text(
                  GameStrings.home,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

