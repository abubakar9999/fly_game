import 'package:flutter/material.dart';

import '../app/strings.dart';
import '../game/space_game.dart';

/// Victory celebration overlay shown when a kid completes all letters in the alphabet.
class AlphabetWinOverlay extends StatelessWidget {
  final SpaceGame game;

  const AlphabetWinOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        padding: const EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          color: const Color(0xFF131926).withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(
            color: const Color(0xFFFFD54F),
            width: 3.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD54F).withValues(alpha: 0.3),
              blurRadius: 24.0,
              spreadRadius: 4.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.military_tech_rounded,
              color: Color(0xFFFFD54F),
              size: 80.0,
            ),
            const SizedBox(height: 12.0),
            Text(
              GameStrings.currentLanguage == AppLanguage.bn
                  ? 'দারুণ! বর্ণমালা সম্পন্ন!'
                  : 'Awesome! Alphabet Complete!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              GameStrings.currentLanguage == AppLanguage.bn
                  ? 'তুমি সব অক্ষর শিখে ফেলেছ! 🚀'
                  : 'You caught all the letters like a true astronaut! 🚀',
              style: const TextStyle(
                color: Color(0xFF90CAF9),
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),

            // Play Again button
            SizedBox(
              width: double.infinity,
              height: 56.0,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.replay_rounded, size: 28.0),
                label: Text(
                  GameStrings.tryAgain,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  game.restart();
                },
              ),
            ),
            const SizedBox(height: 12.0),

            // Return to Home button
            SizedBox(
              width: double.infinity,
              height: 52.0,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.home_rounded, size: 24.0),
                label: Text(
                  GameStrings.home,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white24, width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
