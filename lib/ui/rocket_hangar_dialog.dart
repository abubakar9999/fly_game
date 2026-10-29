import 'package:flutter/material.dart';

import '../app/strings.dart';
import '../game/config.dart';
import '../services/storage_service.dart';

/// Interactive Rocket Hangar allowing children to choose and customize their spacecraft.
class RocketHangarDialog extends StatefulWidget {
  final StorageService storageService;
  final ValueChanged<RocketSkin> onSkinSelected;

  const RocketHangarDialog({
    super.key,
    required this.storageService,
    required this.onSkinSelected,
  });

  @override
  State<RocketHangarDialog> createState() => _RocketHangarDialogState();
}

class _RocketHangarDialogState extends State<RocketHangarDialog> {
  RocketSkin _activeSkin = RocketSkin.classic;

  @override
  void initState() {
    super.initState();
    _loadSkin();
  }

  Future<void> _loadSkin() async {
    final skin = await widget.storageService.getRocketSkin();
    if (mounted) {
      setState(() {
        _activeSkin = skin;
      });
    }
  }

  Future<void> _selectSkin(RocketSkin skin) async {
    setState(() {
      _activeSkin = skin;
    });
    await widget.storageService.saveRocketSkin(skin);
    widget.onSkinSelected(skin);
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
          color: const Color(0xFF131926).withValues(alpha: 0.98),
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: const Color(0xFFFF9800), width: 2.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF9800).withValues(alpha: 0.25),
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
                  isBn ? '🚀 রকেট হ্যাঙ্গার' : '🚀 Rocket Hangar',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              isBn ? 'তোমার পছন্দের রকেট বেছে নাও!' : 'Pick your favorite spaceship!',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 18.0),

            // Skin Selection Cards
            ...RocketSkin.values.map((skin) {
              final cfg = RocketSkinConfig.of(skin);
              final isSelected = skin == _activeSkin;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: InkWell(
                  onTap: () => _selectSkin(skin),
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? cfg.bodyColor.withValues(alpha: 0.25)
                          : Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        color: isSelected ? cfg.bodyColor : Colors.white24,
                        width: isSelected ? 2.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(cfg.emoji, style: const TextStyle(fontSize: 32.0)),
                        const SizedBox(width: 14.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cfg.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  _buildColorDot(cfg.bodyColor),
                                  const SizedBox(width: 6.0),
                                  _buildColorDot(cfg.finColor),
                                  const SizedBox(width: 6.0),
                                  _buildColorDot(cfg.windowColor),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF00E676),
                            size: 26.0,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDot(Color color) {
    return Container(
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

