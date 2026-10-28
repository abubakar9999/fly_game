import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class _Particle {
  double x;
  double y;
  final double vx;
  final double vy;
  final double size;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
  });
}

/// Particle burst effect when collecting stars or planets.
class CollectEffect extends PositionComponent {
  final Color particleColor;
  final List<_Particle> _particles = [];
  final double _duration = 0.4;
  double _elapsed = 0.0;
  final Paint _paint = Paint();

  CollectEffect({
    required Vector2 position,
    required this.particleColor,
    int particleCount = 10,
  }) : super(position: position) {
    final random = math.Random();
    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * math.pi * 2 + (random.nextDouble() * 0.4);
      final speed = 80.0 + random.nextDouble() * 120.0;
      _particles.add(
        _Particle(
          x: 0,
          y: 0,
          vx: math.cos(angle) * speed,
          vy: math.sin(angle) * speed,
          size: 3.0 + random.nextDouble() * 3.5,
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _elapsed += dt;

    if (_elapsed >= _duration) {
      removeFromParent();
      return;
    }

    for (final p in _particles) {
      p.x += p.vx * dt;
      p.y += p.vy * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    final progress = (_elapsed / _duration).clamp(0.0, 1.0);
    final alpha = (1.0 - progress).clamp(0.0, 1.0);
    _paint.color = particleColor.withValues(alpha: alpha);

    for (final p in _particles) {
      canvas.drawCircle(Offset(p.x, p.y), p.size * (1.0 - progress * 0.4), _paint);
    }
  }
}

