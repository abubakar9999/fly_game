import 'package:flutter/material.dart';

import '../game/space_game.dart';

/// HUD overlay tailored for Alphabet Learning mode with prominent target letter display.
class AlphabetHudOverlay extends StatelessWidget {
  final SpaceGame game;

  const AlphabetHudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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

                // Center Target Letter Card
                ValueListenableBuilder<String>(
                  valueListenable: game.alphabetManager.targetLetterNotifier,
                  builder: (context, targetLetter, _) {
                    return GestureDetector(
                      onTap: () {
                        // Re-pronounce target letter on tap
                        game.voiceService.speakLetter(
                          targetLetter,
                          type: game.alphabetManager.type,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2638).withValues(alpha: 0.9),
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
                                fontSize: 16.0,
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

            const SizedBox(height: 8.0),

            // Progress bar
            ValueListenableBuilder<double>(
              valueListenable: game.alphabetManager.progressNotifier,
              builder: (context, progress, _) {
                final currentStep = game.alphabetManager.currentIndex;
                final total = game.alphabetManager.totalLetters;
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: SizedBox(
                        height: 8.0,
                        width: 220.0,
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.white.withValues(alpha: 0.15),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00E676)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '$currentStep / $total',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
