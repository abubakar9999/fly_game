import 'package:flutter/material.dart';

import '../game/models/alphabet_data.dart';
import '../game/space_game.dart';
import 'cosmo_mascot_widget.dart';

/// HUD overlay tailored for Alphabet Learning mode with prominent target letter display, mascot companion, and power-up meters.
class AlphabetHudOverlay extends StatelessWidget {
  final SpaceGame game;

  const AlphabetHudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pause button
                IconButton(
                  iconSize: 32.0,
                  icon: const Icon(Icons.pause_circle_filled, color: Colors.white),
                  onPressed: () => game.pauseGame(),
                ),

                // Center Target Letter & Phonics Card
                ValueListenableBuilder<String>(
                  valueListenable: game.alphabetManager.targetLetterNotifier,
                  builder: (context, targetLetter, _) {
                    final emoji = AlphabetData.getEmoji(targetLetter);
                    final word = AlphabetData.getWord(targetLetter);

                    return GestureDetector(
                      onTap: () {
                        // Re-pronounce target letter on tap
                        game.voiceService.speakLetterWithPhonics(
                          targetLetter,
                          type: game.alphabetManager.type,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2638).withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color(0xFFFFD54F),
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD54F).withValues(alpha: 0.35),
                              blurRadius: 12.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '🎯 Catch: ',
                              style: TextStyle(
                                color: Color(0xFF90CAF9),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD54F),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                targetLetter,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            if (emoji.isNotEmpty) ...[
                              const SizedBox(width: 8.0),
                              Text(emoji, style: const TextStyle(fontSize: 22.0)),
                            ],
                            if (word.isNotEmpty) ...[
                              const SizedBox(width: 6.0),
                              Text(
                                word,
                                style: const TextStyle(
                                  color: Color(0xFF90CAF9),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            const SizedBox(width: 8.0),
                            const Icon(
                              Icons.volume_up_rounded,
                              color: Color(0xFFFFD54F),
                              size: 22.0,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Score Display
                ValueListenableBuilder<int>(
                  valueListenable: game.scoreManager.scoreNotifier,
                  builder: (context, score, _) {
                    return Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFFD54F), size: 26.0),
                        const SizedBox(width: 4.0),
                        Text(
                          '$score',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 6.0),

            // Middle Row: Cosmo Mascot & Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cosmo Mascot Companion
                CosmoMascotWidget(
                  isStarPower: game.rocket.isStarPower,
                  voiceService: game.voiceService,
                ),

                // Progress bar
                ValueListenableBuilder<double>(
                  valueListenable: game.alphabetManager.progressNotifier,
                  builder: (context, progress, _) {
                    final currentStep = game.alphabetManager.currentIndex;
                    final total = game.alphabetManager.totalLetters;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SizedBox(
                            height: 7.0,
                            width: 170.0,
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.white.withValues(alpha: 0.15),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00E676)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          '$currentStep / $total',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}
