import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../models/power_up_type.dart';
import '../space_game.dart';
import 'rocket.dart';

/// Floating cosmic power-up capsule (Magnet 🧲, Shield 🛡️, Slow-Mo ⏱️).
class PowerUpItem extends PositionComponent
    with CollisionCallbacks, HasGameReference<SpaceGame> {
  final PowerUpType type;
  double _age = 0.0;
  bool _isCollected = false;

  late final Paint _bgPaint;
  late final Paint _borderPaint;
  late final Paint _haloPaint;
  late final TextPainter _textPainter;
  late final Offset _center;
  late final double _radius;
  late final Offset _textOffset;

  PowerUpItem({
    required this.type,
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(48.0),
          anchor: Anchor.center,
        ) {
    final cfg = PowerUpConfig.of(type);

    _center = Offset(size.x / 2, size.y / 2);
    _radius = size.x / 2;

    _bgPaint = Paint()
      ..color = cfg.color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    _borderPaint = Paint()
      ..color = cfg.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Fast GPU halo
    _haloPaint = Paint()
      ..color = cfg.color.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;

    _textPainter = TextPainter(
      text: TextSpan(
        text: cfg.emoji,
        style: const TextStyle(fontSize: 24.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    _textOffset = Offset(
      _center.dx - _textPainter.width / 2,
      _center.dy - _textPainter.height / 2,
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    _age += dt;

    // Gentle downward fall with light bobbing
    position.y += (game.currentFallSpeed * 0.75) * dt;
    position.x += math.sin(_age * 3.5) * 15.0 * dt;

    if (position.y > game.size.y + 60.0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Outer glow halo & orb (zero allocations, 100% GPU)
    canvas.drawCircle(_center, _radius + 4.0, _haloPaint);
    canvas.drawCircle(_center, _radius - 2, _bgPaint);
    canvas.drawCircle(_center, _radius - 2, _borderPaint);

    // Emoji icon
    _textPainter.paint(canvas, _textOffset);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (!_isCollected && other is Rocket) {
      _isCollected = true;
      game.activatePowerUp(type);
      removeFromParent();
    }
  }
}

