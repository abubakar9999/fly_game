import 'package:flutter/material.dart';

import '../app/strings.dart';
import '../game/config.dart';
import '../game/models/alphabet_data.dart';
import '../services/storage_service.dart';
import 'game_play_screen.dart';

/// Modal dialog allowing kids to choose which language/alphabet/number world to explore.
class LearningWorldDialog extends StatelessWidget {
  final StorageService storageService;
  final GameDifficulty difficulty;

  const LearningWorldDialog({
    super.key,
    required this.storageService,
    required this.difficulty,
  });

  void _launchLearningMode(BuildContext context, AlphabetType type) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GamePlayScreen(
          difficulty: difficulty,
          storageService: storageService,
          gameMode: GamePlayMode.alphabetQuest,
          alphabetType: type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isBn = GameStrings.currentLanguage == AppLanguage.bn;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 620.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF131926).withValues(alpha: 0.98),
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: const Color(0xFF00E5FF), width: 2.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.25),
              blurRadius: 20.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32.0),
                Text(
                  isBn ? '🚀 মহাকাশ শিখন জগত' : '🚀 Cosmic Learning Worlds',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12.0),

            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Alphabets
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                      child: Text(
                        isBn ? '🔤 বর্ণমালা মিশন' : '🔤 Alphabet Missions',
                        style: const TextStyle(
                          color: Color(0xFFFFD54F),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // English A-Z
                    _buildWorldCard(
                      context: context,
                      title: 'English Alphabet',
                      subtitle: 'A, B, C, D ... Z',
                      badge: 'A - Z',
                      gradientColors: [const Color(0xFF1E88E5), const Color(0xFF00E5FF)],
                      onTap: () => _launchLearningMode(context, AlphabetType.english),
                    ),
                    const SizedBox(height: 10.0),

                    // Bangla Swaraborno
                    _buildWorldCard(
                      context: context,
                      title: 'বাংলা স্বরবর্ণ',
                      subtitle: 'অ, আ, ই, ঈ ... ঔ',
                      badge: 'অ - ঔ',
                      gradientColors: [const Color(0xFF43A047), const Color(0xFF69F0AE)],
                      onTap: () => _launchLearningMode(context, AlphabetType.banglaSwaraborno),
                    ),
                    const SizedBox(height: 10.0),

                    // Bangla Byanjanborno
                    _buildWorldCard(
                      context: context,
                      title: 'বাংলা ব্যঞ্জনবর্ণ',
                      subtitle: 'ক, খ, গ, ঘ ... হ',
                      badge: 'ক - হ',
                      gradientColors: [const Color(0xFF00897B), const Color(0xFF26A69A)],
                      onTap: () => _launchLearningMode(context, AlphabetType.banglaByanjanborno),
                    ),
                    const SizedBox(height: 10.0),

                    // Arabic Huruf
                    _buildWorldCard(
                      context: context,
                      title: 'الحروف العربية',
                      subtitle: 'أ, ب, ت, ث ... ي',
                      badge: 'أ - ي',
                      gradientColors: [const Color(0xFF8E24AA), const Color(0xFFE040FB)],
                      onTap: () => _launchLearningMode(context, AlphabetType.arabic),
                    ),
                    const SizedBox(height: 18.0),

                    // Section 2: Numbers
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                      child: Text(
                        isBn ? '🔢 সংখ্যা মিশন' : '🔢 Number Counting Missions',
                        style: const TextStyle(
                          color: Color(0xFFFFD54F),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // English Numbers
                    _buildWorldCard(
                      context: context,
                      title: 'Numbers (1 - 20)',
                      subtitle: '1, 2, 3, 4 ... 20',
                      badge: '1 - 20',
                      gradientColors: [const Color(0xFFFF6D00), const Color(0xFFFFAB40)],
                      onTap: () => _launchLearningMode(context, AlphabetType.numbersEnglish),
                    ),
                    const SizedBox(height: 10.0),

                    // Bangla Numbers
                    _buildWorldCard(
                      context: context,
                      title: 'বাংলা সংখ্যা (১ - ২০)',
                      subtitle: '১, ২, ৩, ৪ ... ২০',
                      badge: '১ - ২০',
                      gradientColors: [const Color(0xFF00B0FF), const Color(0xFF80D8FF)],
                      onTap: () => _launchLearningMode(context, AlphabetType.numbersBangla),
                    ),
                    const SizedBox(height: 10.0),

                    // Arabic Numbers
                    _buildWorldCard(
                      context: context,
                      title: 'الأرقام العربية (١ - ٢٠)',
                      subtitle: '١, ٢, ٣, ٤ ... ٢٠',
                      badge: '١ - ٢٠',
                      gradientColors: [const Color(0xFFE91E63), const Color(0xFFFF4081)],
                      onTap: () => _launchLearningMode(context, AlphabetType.numbersArabic),
                    ),
                    const SizedBox(height: 18.0),

                    // Section 3: Word Builder Missions
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                      child: Text(
                        isBn ? '🐱 শব্দ গঠন মিশন (Word Builder)' : '🐱 Word Builder Missions',
                        style: const TextStyle(
                          color: Color(0xFFFFD54F),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // English Word Builder
                    _buildWorldCard(
                      context: context,
                      title: 'Word Builder (English)',
                      subtitle: '🐱 CAT, ☀️ SUN, 🐶 DOG, 🚀 JET',
                      badge: 'Words',
                      gradientColors: [const Color(0xFF7C4DFF), const Color(0xFFB388FF)],
                      onTap: () => _launchLearningMode(context, AlphabetType.wordsEnglish),
                    ),
                    const SizedBox(height: 10.0),

                    // Bangla Word Builder
                    _buildWorldCard(
                      context: context,
                      title: 'শব্দ গঠন (বাংলা)',
                      subtitle: '🥭 আম, 📖 বই, 🐟 মাছ, 🌸 ফুল',
                      badge: 'শব্দ',
                      gradientColors: [const Color(0xFF00C853), const Color(0xFFB9F6CA)],
                      onTap: () => _launchLearningMode(context, AlphabetType.wordsBangla),
                    ),
                    const SizedBox(height: 10.0),

                    // Arabic Word Builder
                    _buildWorldCard(
                      context: context,
                      title: 'بناء الكلمات (العربية)',
                      subtitle: '🌙 قمر, 🦁 أسد, ☀️ شمس',
                      badge: 'كلمات',
                      gradientColors: [const Color(0xFFD500F9), const Color(0xFFEA80FC)],
                      onTap: () => _launchLearningMode(context, AlphabetType.wordsArabic),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorldCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String badge,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                gradientColors[0].withValues(alpha: 0.3),
                gradientColors[1].withValues(alpha: 0.15),
              ],
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: gradientColors[1].withValues(alpha: 0.6), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColors),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[1].withValues(alpha: 0.4),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
