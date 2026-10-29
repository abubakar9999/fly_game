import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../space_game.dart';

/// Hazard Meteor (costs 1 life upon collision).
class Meteor extends PositionComponent with HasGameReference<SpaceGame> {
  final double speed;
  final double rotationSpeed;

  Meteor({required this.speed, this.rotationSpeed = 1.2, super.position}) : super(size: Vector2.all(GameConfig.meteorSize), anchor: Anchor.center);

  final Paint _meteorPaint = Paint()..color = GameConfig.meteorColor;
  final Paint _craterPaint = Paint()..color = const Color(0xFF6D4C41);
  final Paint _edgeHighlightPaint = Paint()
    ..color = const Color(0xFFA1887F)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  late final Offset _center;
  late final double _radius;
  late final Offset _c1;
  late final Offset _c2;
  late final Offset _c3;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final cx = size.x / 2;
    final cy = size.y / 2;
    _center = Offset(cx, cy);
    _radius = size.x * 0.40;
    _c1 = Offset(cx - 5, cy - 6);
    _c2 = Offset(cx + 7, cy + 4);
    _c3 = Offset(cx - 4, cy + 8);

    // Passive hitbox: only checks collisions against the active Rocket
    add(CircleHitbox(collisionType: CollisionType.passive, radius: size.x * 0.36, position: Vector2(size.x * 0.14, size.y * 0.14)));
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
    // Rocky body (zero allocations)
    canvas.drawCircle(_center, _radius, _meteorPaint);
    canvas.drawCircle(_center, _radius, _edgeHighlightPaint);

    // Craters
    canvas.drawCircle(_c1, 5.0, _craterPaint);
    canvas.drawCircle(_c2, 4.0, _craterPaint);
    canvas.drawCircle(_c3, 3.0, _craterPaint);
  }
}
