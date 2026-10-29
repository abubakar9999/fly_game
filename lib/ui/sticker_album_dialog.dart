import 'package:flutter/material.dart';

import '../app/strings.dart';
import '../game/models/alphabet_data.dart';
import '../services/storage_service.dart';
import '../services/voice_service.dart';

/// Interactive Sticker Album where children can inspect their unlocked letters and replay sounds.
class StickerAlbumDialog extends StatefulWidget {
  final StorageService storageService;

  const StickerAlbumDialog({super.key, required this.storageService});

  @override
  State<StickerAlbumDialog> createState() => _StickerAlbumDialogState();
}

class _StickerAlbumDialogState extends State<StickerAlbumDialog> {
  Set<String> _unlockedStickers = {};
  final VoiceService _voiceService = VoiceService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStickers();
  }

  Future<void> _loadStickers() async {
    await _voiceService.init();
    final stickers = await widget.storageService.getUnlockedStickers();
    if (mounted) {
      setState(() {
        _unlockedStickers = stickers;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _voiceService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isBn = GameStrings.currentLanguage == AppLanguage.bn;
    final allLetters = AlphabetData.englishLetters;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF131926).withValues(alpha: 0.98),
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: const Color(0xFFFFD54F), width: 2.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD54F).withValues(alpha: 0.25),
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
                  isBn ? '📖 স্টিকার অ্যালবাম' : '📖 Astronaut Sticker Album',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              isBn
                  ? 'সংগৃহীত: ${_unlockedStickers.length} / ${allLetters.length}'
                  : 'Collected: ${_unlockedStickers.length} / ${allLetters.length}',
              style: const TextStyle(
                color: Color(0xFFFFD54F),
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14.0),

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Flexible(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: allLetters.length,
                  itemBuilder: (context, index) {
                    final letter = allLetters[index];
                    final isUnlocked = _unlockedStickers.contains(letter);
                    final emoji = AlphabetData.getEmoji(letter);

                    return InkWell(
                      onTap: isUnlocked
                          ? () {
                              _voiceService.speakLetterWithPhonics(letter);
                            }
                          : null,
                      borderRadius: BorderRadius.circular(14.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isUnlocked
                              ? const Color(0xFF1E2638)
                              : Colors.white.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: isUnlocked
                                ? const Color(0xFFFFD54F)
                                : Colors.white12,
                            width: isUnlocked ? 2.0 : 1.0,
                          ),
                          boxShadow: isUnlocked
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFFFD54F).withValues(alpha: 0.2),
                                    blurRadius: 6.0,
                                  ),
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              letter,
                              style: TextStyle(
                                color: isUnlocked ? Colors.white : Colors.white30,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              isUnlocked ? emoji : '🔒',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
