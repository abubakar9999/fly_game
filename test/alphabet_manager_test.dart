import 'package:flutter_test/flutter_test.dart';
import 'package:fly_game_kids/game/managers/alphabet_manager.dart';
import 'package:fly_game_kids/game/models/alphabet_data.dart';

void main() {
  group('AlphabetManager Tests', () {
    test('Initializes with English alphabet by default starting at A', () {
      final manager = AlphabetManager(type: AlphabetType.english);
      expect(manager.currentTarget, 'A');
      expect(manager.currentIndex, 0);
      expect(manager.totalLetters, 26);
      expect(manager.isCompleted, isFalse);
      expect(manager.progressNotifier.value, 0.0);
    });

    test('checkHit rejects wrong letters without advancing', () {
      final manager = AlphabetManager(type: AlphabetType.english);
      final result = manager.checkHit('X');
      expect(result, isFalse);
      expect(manager.currentTarget, 'A');
      expect(manager.currentIndex, 0);
    });

    test('checkHit accepts matching letter and advances sequence', () {
      final manager = AlphabetManager(type: AlphabetType.english);
      final hitA = manager.checkHit('A');
      expect(hitA, isTrue);
      expect(manager.currentTarget, 'B');
      expect(manager.currentIndex, 1);
      expect(manager.targetLetterNotifier.value, 'B');

      final hitB = manager.checkHit('B');
      expect(hitB, isTrue);
      expect(manager.currentTarget, 'C');
      expect(manager.currentIndex, 2);
    });

    test('Completing all letters sets isCompleted to true', () {
      final manager = AlphabetManager(type: AlphabetType.english);
      for (final letter in AlphabetData.englishLetters) {
        expect(manager.checkHit(letter), isTrue);
      }
      expect(manager.isCompleted, isTrue);
      expect(manager.isCompletedNotifier.value, isTrue);
      expect(manager.progressNotifier.value, 1.0);
    });

    test('Bangla and Arabic alphabet datasets load correctly', () {
      final swaraborno = AlphabetManager(type: AlphabetType.banglaSwaraborno);
      expect(swaraborno.currentTarget, 'অ');
      expect(swaraborno.totalLetters, 11);

      final byanjanborno = AlphabetManager(type: AlphabetType.banglaByanjanborno);
      expect(byanjanborno.currentTarget, 'ক');
      expect(byanjanborno.totalLetters, 32);

      final arabic = AlphabetManager(type: AlphabetType.arabic);
      expect(arabic.currentTarget, 'أ');
      expect(arabic.totalLetters, 28);
    });

    test('getRandomDistractor never returns the current target', () {
      final manager = AlphabetManager(type: AlphabetType.english);
      for (int i = 0; i < 20; i++) {
        final distractor = manager.getRandomDistractor();
        expect(distractor, isNot(equals('A')));
        expect(AlphabetData.englishLetters.contains(distractor), isTrue);
      }
    });

    test('reset restores progress back to initial letter', () {
      final manager = AlphabetManager(type: AlphabetType.english);
      manager.checkHit('A');
      manager.checkHit('B');
      expect(manager.currentIndex, 2);

      manager.reset();
      expect(manager.currentIndex, 0);
      expect(manager.currentTarget, 'A');
      expect(manager.isCompleted, isFalse);
    });
  });
}
