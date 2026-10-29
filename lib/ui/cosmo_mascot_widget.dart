import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../app/strings.dart';
import '../services/voice_service.dart';

/// Interactive animated space companion that smiles, cheers, and encourages the child.
class CosmoMascotWidget extends StatefulWidget {
  final bool isStarPower;
  final VoiceService voiceService;

  const CosmoMascotWidget({
    super.key,
    required this.isStarPower,
    required this.voiceService,
  });

  @override
  State<CosmoMascotWidget> createState() => _CosmoMascotWidgetState();
}

class _CosmoMascotWidgetState extends State<CosmoMascotWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCosmoTapped() {
    final isBn = GameStrings.currentLanguage == AppLanguage.bn;
    final phrasesEn = [
      'You are doing great!',
      'Awesome flying astronaut!',
      'Reach for the stars!',
    ];
    final phrasesBn = [
      'তুমি দারুণ করছো!',
      'চমৎকার চালাচ্ছো!',
      'এগিয়ে যাও রকেট বীর!',
    ];
    final phrases = isBn ? phrasesBn : phrasesEn;
    final randomPhrase = phrases[math.Random().nextInt(phrases.length)];
    widget.voiceService.speakText(randomPhrase);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final bob = math.sin(_controller.value * math.pi) * 4.0;

        return GestureDetector(
          onTap: _onCosmoTapped,
          child: Transform.translate(
            offset: Offset(0, -bob),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: widget.isStarPower
                    ? const Color(0xFFFFD700).withValues(alpha: 0.25)
                    : const Color(0xFF1E2638).withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: widget.isStarPower
                      ? const Color(0xFFFFD700)
                      : const Color(0xFF64B5F6).withValues(alpha: 0.6),
                  width: widget.isStarPower ? 2.0 : 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.isStarPower ? '🤩' : '🐰',
                    style: const TextStyle(fontSize: 22.0),
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    widget.isStarPower ? 'Cosmo: WOW!' : 'Cosmo',
                    style: TextStyle(
                      color: widget.isStarPower
                          ? const Color(0xFFFFD700)
                          : Colors.white70,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
