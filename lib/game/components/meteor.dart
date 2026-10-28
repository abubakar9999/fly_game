import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../space_game.dart';

/// Hazard Meteor (costs 1 life upon collision).
class Meteor extends PositionComponent with HasGameReference<SpaceGame> {
  final double speed;
  final double rotationSpeed;

  Meteor({
    required this.speed,
    this.rotationSpeed = 1.2,
    super.position,
  }) : super(
          size: Vector2.all(GameConfig.meteorSize),
          anchor: Anchor.center,
        );

  final Paint _meteorPaint = Paint()..color = GameConfig.meteorColor;
  final Paint _craterPaint = Paint()..color = const Color(0xFF6D4C41);
  final Paint _edgeHighlightPaint = Paint()
    ..color = const Color(0xFFA1887F)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Fair hitbox: slightly smaller than the asteroid visual
    add(
      CircleHitbox(
        radius: size.x * 0.36,
        position: Vector2(size.x * 0.14, size.y * 0.14),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;
    angle += rotationSpeed * dt;

    if (position.y > game.size.y + GameConfig.offScreenMargin) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final cx = size.x / 2;
    final cy = size.y / 2;
    final radius = size.x * 0.40;

    // Rocky body
    canvas.drawCircle(Offset(cx, cy), radius, _meteorPaint);
    canvas.drawCircle(Offset(cx, cy), radius, _edgeHighlightPaint);

    // Craters
    canvas.drawCircle(Offset(cx - 5, cy - 6), 5.0, _craterPaint);
    canvas.drawCircle(Offset(cx + 7, cy + 4), 4.0, _craterPaint);
    canvas.drawCircle(Offset(cx - 4, cy + 8), 3.0, _craterPaint);
  }
}

