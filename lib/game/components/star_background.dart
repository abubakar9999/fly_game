import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../space_game.dart';

class _StarData {
  final double normX;
  final double normY;
  final double radius;
  final double alpha;

  const _StarData({
    required this.normX,
    required this.normY,
    required this.radius,
    required this.alpha,
  });
}

/// Parallax scrolling stars background with 2 layers.
class StarBackground extends Component with HasGameReference<SpaceGame> {
  final List<_StarData> _slowStars = [];
  final List<_StarData> _fastStars = [];

  double _slowOffset = 0.0;
  double _fastOffset = 0.0;

  final Paint _slowPaint = Paint()
    ..color = Colors.white.withValues(alpha: 0.5)
    ..style = PaintingStyle.fill;

  final Paint _fastPaint = Paint()
    ..color = const Color(0xFFFFF9C4).withValues(alpha: 0.85)
    ..style = PaintingStyle.fill;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _initStars();
  }

  void _initStars() {
    final random = math.Random(42); // Deterministic seed for pleasing layout

    // Layer 1: Distant small stars
    for (int i = 0; i < 35; i++) {
      _slowStars.add(
        _StarData(
          normX: random.nextDouble(),
          normY: random.nextDouble(),
          radius: 1.0 + random.nextDouble() * 1.0,
          alpha: 0.5,
        ),
      );
    }

    // Layer 2: Closer, brighter, faster stars
    for (int i = 0; i < 20; i++) {
      _fastStars.add(
        _StarData(
          normX: random.nextDouble(),
          normY: random.nextDouble(),
          radius: 1.8 + random.nextDouble() * 1.5,
          alpha: 0.85,
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    final h = game.size.y > 0 ? game.size.y : 800.0;
    _slowOffset = (_slowOffset + GameConfig.backgroundSlowSpeed * dt) % h;
    _fastOffset = (_fastOffset + GameConfig.backgroundFastSpeed * dt) % h;
  }

  @override
  void render(Canvas canvas) {
    final w = game.size.x;
    final h = game.size.y;
    if (w <= 0 || h <= 0) return;

    // Batched render of distant stars with single paint state
    for (final star in _slowStars) {
      final x = star.normX * w;
      final y = (star.normY * h + _slowOffset) % h;
      canvas.drawCircle(Offset(x, y), star.radius, _slowPaint);
    }

    // Batched render of foreground stars with single paint state
    for (final star in _fastStars) {
      final x = star.normX * w;
      final y = (star.normY * h + _fastOffset) % h;
      canvas.drawCircle(Offset(x, y), star.radius, _fastPaint);
    }
  }
}

