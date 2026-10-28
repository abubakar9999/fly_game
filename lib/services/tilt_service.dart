import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../game/config.dart';

/// Low-pass filter for smoothing raw accelerometer readings.
class TiltSmoother {
  final double factor;
  double _current = 0.0;

  TiltSmoother({this.factor = GameConfig.tiltSmoothingFactor});

  /// Feeds a new raw value and returns the smoothed value.
  double add(double raw) {
    _current = (_current * (1.0 - factor)) + (raw * factor);
    return _current;
  }

  /// Resets smoothed state to zero.
  void reset() {
    _current = 0.0;
  }

  double get value => _current;
}

/// Service that provides smoothed horizontal tilt values in [-1.0, 1.0].
class TiltService {
  final TiltSmoother _smoother;
  final StreamController<double> _tiltController =
      StreamController<double>.broadcast();

  StreamSubscription<AccelerometerEvent>? _subscription;
  double _lastTilt = 0.0;

  TiltService({double smoothingFactor = GameConfig.tiltSmoothingFactor})
      : _smoother = TiltSmoother(factor: smoothingFactor);

  /// Current smoothed tilt between -1.0 (left) and 1.0 (right).
  double get currentTilt => _lastTilt;

  /// Stream of smoothed horizontal tilt values.
  Stream<double> get tiltStream => _tiltController.stream;

  /// Starts listening to the device accelerometer.
  void start() {
    _subscription?.cancel();
    try {
      _subscription = accelerometerEventStream().listen(
        (AccelerometerEvent event) {
          // Negative X in portrait tilts to the right; invert so positive = right.
          final normalized = (-event.x / GameConfig.tiltMaxAngle)
              .clamp(-1.0, 1.0);
          _lastTilt = _smoother.add(normalized);
          if (!_tiltController.isClosed) {
            _tiltController.add(_lastTilt);
          }
        },
        onError: (_) {
          // Accelerometer might be unavailable (e.g. desktop/emulator).
          _lastTilt = 0.0;
        },
      );
    } catch (_) {
      _lastTilt = 0.0;
    }
  }

  /// Manually feeds a tilt value (useful for tests or touch fallback).
  void feed(double rawTilt) {
    final clamped = rawTilt.clamp(-1.0, 1.0);
    _lastTilt = _smoother.add(clamped);
    if (!_tiltController.isClosed) {
      _tiltController.add(_lastTilt);
    }
  }

  /// Stops listening and releases resources.
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _tiltController.close();
  }
}

