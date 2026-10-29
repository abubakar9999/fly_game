import 'package:flutter/material.dart';

import '../app/strings.dart';
import '../game/config.dart';
import '../services/storage_service.dart';
import 'game_play_screen.dart';
import 'learning_world_dialog.dart';
import 'parent_dashboard_dialog.dart';
import 'rocket_hangar_dialog.dart';
import 'sticker_album_dialog.dart';

/// Main menu screen with difficulty selector and settings.
class HomeScreen extends StatefulWidget {
  final StorageService storageService;

  const HomeScreen({super.key, required this.storageService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameDifficulty _selectedDifficulty = GameDifficulty.medium;
  RocketSkin _selectedSkin = RocketSkin.classic;
  int _highScore = 0;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final muted = await widget.storageService.getIsMuted();
    final lang = await widget.storageService.getLanguage();
    final skin = await widget.storageService.getRocketSkin();
    if (lang == 'bn') {
      GameStrings.setLanguage(AppLanguage.bn);
    } else {
      GameStrings.setLanguage(AppLanguage.en);
    }
    final hs = await widget.storageService.getHighScore(_selectedDifficulty);

    if (mounted) {
      setState(() {
        _isMuted = muted;
        _highScore = hs;
        _selectedSkin = skin;
      });
    }
  }

  Future<void> _selectDifficulty(GameDifficulty diff) async {
    final hs = await widget.storageService.getHighScore(diff);
    if (mounted) {
      setState(() {
        _selectedDifficulty = diff;
        _highScore = hs;
      });
    }
  }

  Future<void> _toggleMute() async {
    final newMuted = !_isMuted;
    await widget.storageService.saveIsMuted(newMuted);
    if (mounted) {
      setState(() {
        _isMuted = newMuted;
      });
    }
  }

  Future<void> _toggleLanguage() async {
    final newLang = GameStrings.currentLanguage == AppLanguage.en
        ? AppLanguage.bn
        : AppLanguage.en;
    GameStrings.setLanguage(newLang);
    await widget.storageService.saveLanguage(newLang == AppLanguage.bn ? 'bn' : 'en');
    if (mounted) {
      setState(() {});
    }
  }

  void _startGame() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GamePlayScreen(
          difficulty: _selectedDifficulty,
          storageService: widget.storageService,
          rocketSkin: _selectedSkin,
        ),
      ),
    ).then((_) {
      // Refresh high score when returning to menu
      _loadSettings();
    });
  }

  void _openLearningMode() {
    showDialog(
      context: context,
      builder: (_) => LearningWorldDialog(
        storageService: widget.storageService,
        difficulty: _selectedDifficulty,
      ),
    );
  }

  void _openHangar() {
    showDialog(
      context: context,
      builder: (_) => RocketHangarDialog(
        storageService: widget.storageService,
        onSkinSelected: (skin) {
          setState(() {
            _selectedSkin = skin;
          });
        },
      ),
    );
  }

  void _openStickerAlbum() {
    showDialog(
      context: context,
      builder: (_) => StickerAlbumDialog(
        storageService: widget.storageService,
      ),
    );
  }

  void _openParentDashboard() {
    showDialog(
      context: context,
      builder: (_) => ParentDashboardDialog(
        storageService: widget.storageService,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: GameStrings.languageNotifier,
      builder: (context, _, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0B0E14),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                  // Header & Title
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 26.0,
                            icon: const Icon(Icons.family_restroom_rounded, color: Color(0xFF90CAF9)),
                            tooltip: 'Parent Dashboard',
                            onPressed: _openParentDashboard,
                          ),
                        ],
                      ),
                      Container(
                        width: 96.0,
                        height: 96.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFFFD54F), width: 3.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD54F).withValues(alpha: 0.35),
                              blurRadius: 16.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        GameStrings.appTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '${GameStrings.highScore}: $_highScore',
                        style: const TextStyle(
                          color: Color(0xFFFFD54F),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // Difficulty Selector
                  Column(
                    children: [
                      Text(
                        GameStrings.difficultyTitle,
                        style: const TextStyle(
                          color: Color(0xFF90CAF9),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Row(
                        children: [
                          _buildDifficultyButton(
                            title: GameStrings.easy,
                            subtitle: '5 ❤️',
                            diff: GameDifficulty.easy,
                            color: const Color(0xFF4CAF50),
                          ),
                          const SizedBox(width: 10.0),
                          _buildDifficultyButton(
                            title: GameStrings.medium,
                            subtitle: '3 ❤️',
                            diff: GameDifficulty.medium,
                            color: const Color(0xFF2196F3),
                          ),
                          const SizedBox(width: 10.0),
                          _buildDifficultyButton(
                            title: GameStrings.hard,
                            subtitle: '3 ❤️⚡',
                            diff: GameDifficulty.hard,
                            color: const Color(0xFFFF9800),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Mode Action Buttons: Arcade Play & Alphabet Learning
                  Column(
                    children: [
                      // Big Play Button (min 60px height)
                      SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00E676),
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            elevation: 8.0,
                          ),
                          onPressed: _startGame,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.play_arrow_rounded, size: 36.0),
                              const SizedBox(width: 8.0),
                              Text(
                                GameStrings.play,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),

                      // Alphabet Quest Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C4DFF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 6.0,
                          ),
                          onPressed: _openLearningMode,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.school_rounded, size: 28.0),
                              const SizedBox(width: 8.0),
                              Text(
                                GameStrings.currentLanguage == AppLanguage.bn
                                    ? 'বর্ণমালা ও সংখ্যা 🔤'
                                    : 'Alphabet Quest 🔤',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      // Hangar & Sticker Album Row
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 48.0),
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Color(0xFFFF9800), width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              onPressed: _openHangar,
                              icon: const Icon(Icons.rocket_rounded, color: Color(0xFFFF9800), size: 20.0),
                              label: Text(
                                GameStrings.currentLanguage == AppLanguage.bn
                                    ? 'হ্যাঙ্গার 🛸'
                                    : 'Hangar 🛸',
                                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 48.0),
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Color(0xFFFFD54F), width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              onPressed: _openStickerAlbum,
                              icon: const Icon(Icons.star_rounded, color: Color(0xFFFFD54F), size: 20.0),
                              label: Text(
                                GameStrings.currentLanguage == AppLanguage.bn
                                    ? 'অ্যালবাম 📖'
                                    : 'Stickers 📖',
                                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Bottom Settings Bar (Language & Mute)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Language button
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(130.0, 56.0),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF64B5F6), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: _toggleLanguage,
                        icon: const Icon(Icons.language_rounded, size: 24.0),
                        label: Text(
                          GameStrings.currentLanguage == AppLanguage.en
                              ? 'বাংলা'
                              : 'English',
                          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Mute button
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(130.0, 56.0),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF64B5F6), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: _toggleMute,
                        icon: Icon(
                          _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                          size: 24.0,
                          color: _isMuted ? const Color(0xFFFF5252) : const Color(0xFF69F0AE),
                        ),
                        label: Text(
                          _isMuted ? GameStrings.soundOff : GameStrings.soundOn,
                          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  ),
);
      },
    );
  }

  Widget _buildDifficultyButton({
    required String title,
    required String subtitle,
    required GameDifficulty diff,
    required Color color,
  }) {
    final isSelected = _selectedDifficulty == diff;
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectDifficulty(diff),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 76.0,
          decoration: BoxDecoration(
            color: isSelected ? color : color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              color: isSelected ? Colors.white : color.withValues(alpha: 0.5),
              width: isSelected ? 2.5 : 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: 10.0,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
