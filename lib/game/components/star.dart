import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../space_game.dart';

/// Collectible Star (+1 point).
class Star extends PositionComponent with HasGameReference<SpaceGame> {
  final double speed;

  Star({
    required this.speed,
    super.position,
  }) : super(
          size: Vector2.all(GameConfig.starSize),
          anchor: Anchor.center,
        );

  final Paint _starPaint = Paint()..color = GameConfig.starColor;
  final Paint _innerPaint = Paint()..color = Colors.white;
  final Path _starPath = Path();
  late final Offset _center;
  late final double _innerRadius;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _center = Offset(size.x * 0.5, size.y * 0.5);
    _innerRadius = size.x * 0.12;
    _buildStarPath();

    // Passive hitbox: only checks collisions against the active Rocket
    add(
      CircleHitbox(
        collisionType: CollisionType.passive,
        radius: size.x * 0.38,
        position: Vector2(size.x * 0.12, size.y * 0.12),
      ),
    );
  }

  void _buildStarPath() {
    _starPath.reset();
    final cx = size.x / 2;
    final cy = size.y / 2;
    final outerR = size.x * 0.48;
    final innerR = size.x * 0.22;
    const points = 5;
    const step = math.pi / points;
    double angle = -math.pi / 2;

    _starPath.moveTo(
      cx + outerR * math.cos(angle),
      cy + outerR * math.sin(angle),
    );

    for (int i = 0; i < points; i++) {
      angle += step;
      _starPath.lineTo(
        cx + innerR * math.cos(angle),
        cy + innerR * math.sin(angle),
      );
      angle += step;
      _starPath.lineTo(
        cx + outerR * math.cos(angle),
        cy + outerR * math.sin(angle),
      );
    }
    _starPath.close();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;

    if (position.y > game.size.y + GameConfig.offScreenMargin) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    // Main star body
    canvas.drawPath(_starPath, _starPaint);

    // Cute sparkle center
    canvas.drawCircle(_center, _innerRadius, _innerPaint);
  }
}

