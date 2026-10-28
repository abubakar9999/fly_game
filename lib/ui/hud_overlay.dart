import 'package:flutter/material.dart';
import '../app/strings.dart';
import '../game/space_game.dart';

/// Top in-game HUD showing score, remaining hearts, and pause button.
class HudOverlay extends StatelessWidget {
  final SpaceGame game;

  const HudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Lives hearts display
            ValueListenableBuilder<int>(
              valueListenable: game.scoreManager.livesNotifier,
              builder: (context, lives, _) {
                return Row(
                  children: List.generate(
                    lives.clamp(0, 5),
                    (index) => const Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: Icon(
                        Icons.favorite_rounded,
                        color: Color(0xFFFF3366),
                        size: 32.0,
                      ),
                    ),
                  ),
                );
              },
            ),

            // Score counter
            ValueListenableBuilder<int>(
              valueListenable: game.scoreManager.scoreNotifier,
              builder: (context, score, _) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFFFFD54F),
                      width: 2.0,
                    ),
                  ),
                  child: Text(
                    '${GameStrings.score}: $score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                );
              },
            ),

            // Big friendly pause button (minimum 56x56 tap target)
            SizedBox(
              width: 56.0,
              height: 56.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color(0xFF1E88E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                ),
                onPressed: () => game.pauseGame(),
                child: const Icon(
                  Icons.pause_rounded,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

