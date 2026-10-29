import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../space_game.dart';

/// Collectible Planet (+5 points).
class Planet extends PositionComponent with HasGameReference<SpaceGame> {
  final double speed;

  Planet({required this.speed, super.position}) : super(size: Vector2.all(GameConfig.planetSize), anchor: Anchor.center);

  final Paint _planetPaint = Paint()..color = const Color(0xFF4DD0E1);
  final Paint _ringPaint = Paint()
    ..color = const Color(0xFFFFD54F)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;
  final Paint _craterPaint = Paint()..color = const Color(0xFF26C6DA);

  late final Offset _center;
  late final double _radius;
  late final Offset _spot1;
  late final Offset _spot2;
  late final Rect _ringRect;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final cx = size.x / 2;
    final cy = size.y / 2;
    _center = Offset(cx, cy);
    _radius = size.x * 0.38;
    _spot1 = Offset(cx - 7, cy - 6);
    _spot2 = Offset(cx + 8, cy + 5);

    _ringRect = Rect.fromCenter(center: _center, width: size.x * 0.95, height: size.y * 0.35);

    // Passive hitbox: only checks collisions against the active Rocket
    add(CircleHitbox(collisionType: CollisionType.passive, radius: size.x * 0.38, position: Vector2(size.x * 0.12, size.y * 0.12)));
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
    // Planet body (zero allocations)
    canvas.drawCircle(_center, _radius, _planetPaint);

    // Cute decorative spot / crater
    canvas.drawCircle(_spot1, 5.0, _craterPaint);
    canvas.drawCircle(_spot2, 3.5, _craterPaint);

    // Saturn-style planetary ring
    canvas.drawOval(_ringRect, _ringPaint);
  }
}
