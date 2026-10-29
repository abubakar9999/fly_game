import 'package:flutter/material.dart';

import '../app/strings.dart';
import '../game/config.dart';
import '../game/models/alphabet_data.dart';
import '../services/storage_service.dart';
import 'game_play_screen.dart';

/// Modal dialog allowing kids to choose which language/alphabet world to explore.
class LearningWorldDialog extends StatelessWidget {
  final StorageService storageService;
  final GameDifficulty difficulty;

  const LearningWorldDialog({super.key, required this.storageService, required this.difficulty});

  void _launchLearningMode(BuildContext context, AlphabetType type) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GamePlayScreen(difficulty: difficulty, storageService: storageService, gameMode: GamePlayMode.alphabetQuest, alphabetType: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isBn = GameStrings.currentLanguage == AppLanguage.bn;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Container(
        padding: const EdgeInsets.all(22.0),
        decoration: BoxDecoration(
          color: const Color(0xFF131926).withValues(alpha: 0.97),
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: const Color(0xFF00E5FF), width: 2.5),
          boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.25), blurRadius: 20.0, spreadRadius: 2.0)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32.0),
                Text(
                  isBn ? '🚀 বর্ণমালা বেছে নিন' : '🚀 Choose Alphabet World',
                  style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // English A-Z
            _buildWorldCard(
              context: context,
              title: 'English Alphabet',
              subtitle: 'A, B, C, D ... Z',
              badge: 'A - Z',
              gradientColors: [const Color(0xFF1E88E5), const Color(0xFF00E5FF)],
              onTap: () => _launchLearningMode(context, AlphabetType.english),
            ),
            const SizedBox(height: 12.0),

            // Bangla Swaraborno
            _buildWorldCard(
              context: context,
              title: 'বাংলা স্বরবর্ণ',
              subtitle: 'অ, আ, ই, ঈ ... ঔ',
              badge: 'অ - ঔ',
              gradientColors: [const Color(0xFF43A047), const Color(0xFF69F0AE)],
              onTap: () => _launchLearningMode(context, AlphabetType.banglaSwaraborno),
            ),
            const SizedBox(height: 12.0),

            // Bangla Byanjanborno
            _buildWorldCard(
              context: context,
              title: 'বাংলা ব্যঞ্জনবর্ণ',
              subtitle: 'ক, খ, গ, ঘ ... হ',
              badge: 'ক - হ',
              gradientColors: [const Color(0xFF00897B), const Color(0xFF26A69A)],
              onTap: () => _launchLearningMode(context, AlphabetType.banglaByanjanborno),
            ),
            const SizedBox(height: 12.0),

            // Arabic Huruf
            _buildWorldCard(context: context, title: 'الحروف العربية', subtitle: 'أ, ب, ت, ث ... ي', badge: 'أ - ي', gradientColors: [const Color(0xFF8E24AA), const Color(0xFFE040FB)], onTap: () => _launchLearningMode(context, AlphabetType.arabic)),
          ],
        ),
      ),
    );
  }

  Widget _buildWorldCard({required BuildContext context, required String title, required String subtitle, required String badge, required List<Color> gradientColors, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [gradientColors[0].withValues(alpha: 0.3), gradientColors[1].withValues(alpha: 0.15)]),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: gradientColors[1].withValues(alpha: 0.6), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 52.0,
                height: 52.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColors),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: gradientColors[1].withValues(alpha: 0.4), blurRadius: 8.0)],
                ),
                alignment: Alignment.center,
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2.0),
                    Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 13.0)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 18.0),
            ],
          ),
        ),
      ),
    );
  }
}
