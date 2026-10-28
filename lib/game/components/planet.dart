import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../space_game.dart';

/// Collectible Planet (+5 points).
class Planet extends PositionComponent with HasGameReference<SpaceGame> {
  final double speed;

  Planet({
    required this.speed,
    super.position,
  }) : super(
          size: Vector2.all(GameConfig.planetSize),
          anchor: Anchor.center,
        );

  final Paint _planetPaint = Paint()..color = const Color(0xFF4DD0E1);
  final Paint _ringPaint = Paint()
    ..color = const Color(0xFFFFD54F)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;
  final Paint _craterPaint = Paint()..color = const Color(0xFF26C6DA);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Hitbox for the planet body
    add(
      CircleHitbox(
        radius: size.x * 0.38,
        position: Vector2(size.x * 0.12, size.y * 0.12),
      ),
    );
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
    final cx = size.x / 2;
    final cy = size.y / 2;
    final radius = size.x * 0.38;

    // Planet body
    canvas.drawCircle(Offset(cx, cy), radius, _planetPaint);

    // Cute decorative spot / crater
    canvas.drawCircle(Offset(cx - 7, cy - 6), 5.0, _craterPaint);
    canvas.drawCircle(Offset(cx + 8, cy + 5), 3.5, _craterPaint);

    // Saturn-style planetary ring
    final ringRect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: size.x * 0.95,
      height: size.y * 0.35,
    );
    canvas.drawOval(ringRect, _ringPaint);
  }
}

