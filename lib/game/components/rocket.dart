import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../space_game.dart';
import 'meteor.dart';
import 'planet.dart';
import 'star.dart';

/// Player controlled rocket component with customizable skins and Star-Power combo thrusters.
class Rocket extends PositionComponent
    with HasGameReference<SpaceGame>, CollisionCallbacks, DragCallbacks {
  RocketSkin skin = RocketSkin.classic;

  Rocket({this.skin = RocketSkin.classic})
      : super(
          size: Vector2(GameConfig.rocketWidth, GameConfig.rocketHeight),
          anchor: Anchor.center,
        ) {
    _updatePaints();
  }

  // Invincibility & blink state
  bool _isInvincible = false;
  double _invincibilityTimer = 0.0;
  double _blinkTimer = 0.0;
  bool _isVisible = true;

  // Flame animation timer & combo streak
  double _flameTime = 0.0;
  int comboStreak = 0;
  bool get isStarPower => comboStreak >= 3;

  // Reusable paints
  late Paint _bodyPaint;
  late Paint _windowPaint;
  late Paint _finPaint;
  late Paint _flamePaint;
  final Paint _flameInnerPaint = Paint()..color = Colors.yellowAccent;
  final Paint _starPowerGlow = Paint()
    ..color = const Color(0xFFFFD700).withValues(alpha: 0.4)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);

  bool get isInvincible => _isInvincible;

  void setSkin(RocketSkin newSkin) {
    skin = newSkin;
    _updatePaints();
  }

  void _updatePaints() {
    final cfg = RocketSkinConfig.of(skin);
    _bodyPaint = Paint()..color = cfg.bodyColor;
    _windowPaint = Paint()..color = cfg.windowColor;
    _finPaint = Paint()..color = cfg.finColor;
    _flamePaint = Paint()..color = cfg.flameColor;
  }

  void registerHitSuccess() {
    comboStreak++;
  }

  void resetCombo() {
    comboStreak = 0;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Hitbox slightly smaller than the rocket body to feel fair and kid-friendly
    add(
      RectangleHitbox(
        size: Vector2(size.x * 0.7, size.y * 0.75),
        position: Vector2(size.x * 0.15, size.y * 0.15),
      ),
    );

    // Initial position at bottom center
    resetPosition();
  }

  /// Positions the rocket at the bottom center of the game view.
  void resetPosition() {
    position = Vector2(
      game.size.x / 2,
      game.size.y - GameConfig.rocketBottomPadding,
    );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position.y = size.y - GameConfig.rocketBottomPadding;
    _clampPosition();
  }

  /// Triggers temporary invincibility after taking damage.
  void triggerHit() {
    _isInvincible = true;
    _invincibilityTimer = GameConfig.invincibilityDuration;
    _blinkTimer = 0.0;
    _isVisible = true;
    resetCombo();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update invincibility and blinking
    if (_isInvincible) {
      _invincibilityTimer -= dt;
      _blinkTimer += dt;
      if (_blinkTimer >= GameConfig.blinkInterval) {
        _blinkTimer = 0.0;
        _isVisible = !_isVisible;
      }
      if (_invincibilityTimer <= 0) {
        _isInvincible = false;
        _isVisible = true;
      }
    }

    // Update flame animation
    _flameTime += dt * 15.0;

    // Movement via tilt
    final tilt = game.tiltService.currentTilt;
    position.x += tilt * GameConfig.rocketMaxSpeed * dt;

    _clampPosition();
  }

  /// Move horizontally by a delta (for touch/drag fallback).
  void moveBy(double dx) {
    position.x += dx * GameConfig.rocketDragSensitivity;
    _clampPosition();
  }

  void _clampPosition() {
    final halfWidth = size.x / 2;
    final minX = halfWidth;
    final maxX = game.size.x - halfWidth;
    if (maxX > minX) {
      position.x = position.x.clamp(minX, maxX);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    moveBy(event.localDelta.x);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Star) {
      other.removeFromParent();
      game.onStarCollected(other);
    } else if (other is Planet) {
      other.removeFromParent();
      game.onPlanetCollected(other);
    } else if (other is Meteor) {
      if (!_isInvincible) {
        other.removeFromParent();
        triggerHit();
        game.onMeteorHit(other);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if (!_isVisible) return;

    final w = size.x;
    final h = size.y;

    // Draw Star-Power cosmic aura when combo >= 3
    if (isStarPower) {
      canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.65, _starPowerGlow);
    }

    // 1. Draw animated thruster flame (Rainbow boosted if in Star-Power!)
    final flameFlicker = math.sin(_flameTime).abs() * (isStarPower ? 12.0 : 6.0);
    final flameExtraLength = isStarPower ? 14.0 : 8.0;

    final flamePaint = isStarPower
        ? (Paint()
          ..shader = const LinearGradient(
            colors: [Colors.purpleAccent, Colors.cyanAccent, Colors.yellowAccent],
          ).createShader(Rect.fromLTWH(0, h * 0.88, w, 24.0)))
        : _flamePaint;

    final flamePath = Path()
      ..moveTo(w * 0.35, h * 0.88)
      ..lineTo(w * 0.5, h + flameExtraLength + flameFlicker)
      ..lineTo(w * 0.65, h * 0.88)
      ..close();
    canvas.drawPath(flamePath, flamePaint);

    final innerFlamePath = Path()
      ..moveTo(w * 0.42, h * 0.90)
      ..lineTo(w * 0.5, h + 3.0 + (flameFlicker * 0.6))
      ..lineTo(w * 0.58, h * 0.90)
      ..close();
    canvas.drawPath(innerFlamePath, _flameInnerPaint);

    // 2. Draw side fins
    final leftFin = Path()
      ..moveTo(w * 0.25, h * 0.55)
      ..lineTo(0, h * 0.85)
      ..lineTo(w * 0.25, h * 0.82)
      ..close();
    canvas.drawPath(leftFin, _finPaint);

    final rightFin = Path()
      ..moveTo(w * 0.75, h * 0.55)
      ..lineTo(w, h * 0.85)
      ..lineTo(w * 0.75, h * 0.82)
      ..close();
    canvas.drawPath(rightFin, _finPaint);

    // 3. Draw streamlined rocket body
    final bodyPath = Path()
      ..moveTo(w * 0.5, 0)
      ..quadraticBezierTo(w * 0.85, h * 0.35, w * 0.75, h * 0.88)
      ..lineTo(w * 0.25, h * 0.88)
      ..quadraticBezierTo(w * 0.15, h * 0.35, w * 0.5, 0)
      ..close();
    canvas.drawPath(bodyPath, _bodyPaint);

    // 4. Draw cockpit window
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.36),
      w * 0.16,
      _windowPaint,
    );

    // Cute reflection highlight inside cockpit
    final shinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(w * 0.46, h * 0.32),
      w * 0.05,
      shinePaint,
    );
  }
}
