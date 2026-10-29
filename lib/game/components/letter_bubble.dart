import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../space_game.dart';
import 'rocket.dart';

/// A glowing celestial bubble carrying an alphabet letter for the player rocket to hit.
class LetterBubble extends PositionComponent with CollisionCallbacks, HasGameReference<SpaceGame> {
  final String letter;
  final bool isTarget;

  double _age = 0.0;
  bool _isCollected = false;
  late final Paint _bubblePaint;
  late final Paint _borderPaint;
  late final Paint _haloPaint;
  late final Paint _highlightPaint;
  late final Rect _highlightRect;
  late final TextPainter _textPainter;
  late final Offset _center;
  late final double _radius;
  late final Offset _textOffset;

  // Curated vibrant kid-friendly bubble colors
  static const List<Color> _palette = [
    Color(0xFFFF4081), // Pink
    Color(0xFF00E5FF), // Cyan
    Color(0xFFFFD600), // Gold
    Color(0xFF76FF03), // Lime
    Color(0xFFE040FB), // Purple
    Color(0xFFFF6E40), // Orange
  ];

  LetterBubble({required this.letter, required this.isTarget, required Vector2 position}) : super(position: position, size: Vector2.all(56.0), anchor: Anchor.center) {
    // Choose bubble tint based on letter
    final color = _palette[letter.codeUnitAt(0) % _palette.length];

    _center = Offset(size.x / 2, size.y / 2);
    _radius = size.x / 2;

    _bubblePaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    _borderPaint = Paint()
      ..color = color.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isTarget ? 3.5 : 2.5;

    // Hardware-accelerated smooth outer glow without GPU/CPU blur filter overhead
    _haloPaint = Paint()
      ..color = color.withValues(alpha: isTarget ? 0.22 : 0.12)
      ..style = PaintingStyle.fill;

    _highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    _highlightRect = Rect.fromCircle(center: _center, radius: _radius - 6);

    _textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: Colors.black87, offset: Offset(1.5, 1.5))],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    _textOffset = Offset(_center.dx - _textPainter.width / 2, _center.dy - _textPainter.height / 2);
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

    // Gentle downward fall with light celestial drifting
    final fallSpeed = game.currentFallSpeed * 0.85;
    position.y += fallSpeed * dt;
    position.x += math.sin(_age * 3.0) * 20.0 * dt;

    // Auto cleanup when leaving bottom screen
    if (position.y > game.size.y + 60.0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // 1. Hardware accelerated outer glow halo
    canvas.drawCircle(_center, _radius + (isTarget ? 6.0 : 3.0), _haloPaint);

    // 2. Translucent Bubble Body
    canvas.drawCircle(_center, _radius - 2, _bubblePaint);

    // 3. Crisp Neon Border
    canvas.drawCircle(_center, _radius - 2, _borderPaint);

    // 4. Glass highlight shimmer arc (zero allocations)
    canvas.drawArc(_highlightRect, -math.pi * 0.75, math.pi * 0.45, false, _highlightPaint);

    // 5. Letter glyph in center
    _textPainter.paint(canvas, _textOffset);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (!_isCollected && other is Rocket) {
      _isCollected = true;
      game.handleLetterHit(this);
    }
  }
}
