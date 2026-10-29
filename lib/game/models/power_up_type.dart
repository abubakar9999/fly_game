import 'package:flutter/material.dart';

enum PowerUpType {
  magnet,
  shield,
  slowMo,
}

class PowerUpConfig {
  final PowerUpType type;
  final String name;
  final String emoji;
  final Color color;

  const PowerUpConfig({
    required this.type,
    required this.name,
    required this.emoji,
    required this.color,
  });

  static const PowerUpConfig magnet = PowerUpConfig(
    type: PowerUpType.magnet,
    name: 'Cosmic Magnet',
    emoji: '🧲',
    color: Color(0xFFFF5252),
  );

  static const PowerUpConfig shield = PowerUpConfig(
    type: PowerUpType.shield,
    name: 'Bubble Shield',
    emoji: '🛡️',
    color: Color(0xFF00E5FF),
  );

  static const PowerUpConfig slowMo = PowerUpConfig(
    type: PowerUpType.slowMo,
    name: 'Cosmic Slow-Mo',
    emoji: '⏱️',
    color: Color(0xFFFFD600),
  );

  static PowerUpConfig of(PowerUpType type) {
    switch (type) {
      case PowerUpType.magnet:
        return magnet;
      case PowerUpType.shield:
        return shield;
      case PowerUpType.slowMo:
        return slowMo;
    }
  }
}
