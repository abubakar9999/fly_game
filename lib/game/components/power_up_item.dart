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
  late final Paint _glowPaint;
  late final TextPainter _textPainter;

  PowerUpItem({
    required this.type,
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(48.0),
          anchor: Anchor.center,
        ) {
    final cfg = PowerUpConfig.of(type);

    _bgPaint = Paint()
      ..color = cfg.color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    _borderPaint = Paint()
      ..color = cfg.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    _glowPaint = Paint()
      ..color = cfg.color.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);

    _textPainter = TextPainter(
      text: TextSpan(
        text: cfg.emoji,
        style: const TextStyle(fontSize: 24.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
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

    final center = Offset(size.x / 2, size.y / 2);
    final radius = size.x / 2;

    // Outer glow & orb
    canvas.drawCircle(center, radius, _glowPaint);
    canvas.drawCircle(center, radius - 2, _bgPaint);
    canvas.drawCircle(center, radius - 2, _borderPaint);

    // Emoji icon
    final textOffset = Offset(
      center.dx - _textPainter.width / 2,
      center.dy - _textPainter.height / 2,
    );
    _textPainter.paint(canvas, textOffset);
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
