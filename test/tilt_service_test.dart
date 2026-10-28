import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/services/tilt_service.dart';

void main() {
  group('TiltSmoother', () {
    test('starts at zero', () {
      final smoother = TiltSmoother(factor: 0.2);
      expect(smoother.value, 0.0);
    });

    test('smooths values with 0.8 / 0.2 weight', () {
      final smoother = TiltSmoother(factor: 0.2);

      // Step 1: feed 1.0 -> 0 * 0.8 + 1.0 * 0.2 = 0.2
      final step1 = smoother.add(1.0);
      expect(step1, closeTo(0.2, 0.0001));

      // Step 2: feed 1.0 -> 0.2 * 0.8 + 1.0 * 0.2 = 0.36
      final step2 = smoother.add(1.0);
      expect(step2, closeTo(0.36, 0.0001));

      // Step 3: feed 0.0 -> 0.36 * 0.8 + 0.0 * 0.2 = 0.288
      final step3 = smoother.add(0.0);
      expect(step3, closeTo(0.288, 0.0001));
    });

    test('reset clears the current value', () {
      final smoother = TiltSmoother(factor: 0.2);
      smoother.add(1.0);
      smoother.reset();
      expect(smoother.value, 0.0);
    });
  });

  group('TiltService manual feeding', () {
    test('feed clamps values to [-1.0, 1.0]', () {
      final service = TiltService(smoothingFactor: 1.0); // instant pass-through
      service.feed(5.0);
      expect(service.currentTilt, 1.0);

      service.feed(-10.0);
      expect(service.currentTilt, -1.0);
      service.dispose();
    });
  });
}

