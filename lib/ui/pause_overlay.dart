import 'package:flutter/material.dart';
import '../app/strings.dart';
import '../game/space_game.dart';

/// Pause menu dialog overlay.
class PauseOverlay extends StatelessWidget {
  final SpaceGame game;

  const PauseOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        padding: const EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          color: const Color(0xE6131826),
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(
            color: const Color(0xFF64B5F6),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 20.0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              GameStrings.paused,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28.0),

            // Resume button (min 56px height)
            SizedBox(
              width: double.infinity,
              height: 56.0,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A047),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () => game.resumeGame(),
                icon: const Icon(Icons.play_arrow_rounded, size: 28.0),
                label: Text(
                  GameStrings.resume,
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Restart button (min 56px height)
            SizedBox(
              width: double.infinity,
              height: 56.0,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFB8C00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () => game.restart(),
                icon: const Icon(Icons.replay_rounded, size: 26.0),
                label: Text(
                  GameStrings.restart,
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                  backgroundColor: const Color(0xFFE53935),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.home_rounded, size: 26.0),
                label: Text(
                  GameStrings.home,
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

