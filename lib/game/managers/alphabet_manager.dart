import 'dart:math' as math;
import 'package:flutter/foundation.dart';

import '../models/alphabet_data.dart';

/// Manages alphabet learning progression, current target letter, and completion state.
class AlphabetManager {
  AlphabetType _type = AlphabetType.english;
  late List<String> _letters;
  int _currentIndex = 0;
  final math.Random _random = math.Random();

  late final ValueNotifier<String> targetLetterNotifier;
  late final ValueNotifier<double> progressNotifier;
  final ValueNotifier<bool> isCompletedNotifier = ValueNotifier<bool>(false);

  AlphabetManager({AlphabetType? type}) {
    if (type != null) {
      _type = type;
    }
    _letters = AlphabetData.getLetters(_type);
    targetLetterNotifier = ValueNotifier<String>(_letters.isNotEmpty ? _letters[0] : '');
    progressNotifier = ValueNotifier<double>(0.0);
  }

  AlphabetType get type => _type;
  List<String> get letters => _letters;
  int get currentIndex => _currentIndex;
  int get totalLetters => _letters.length;
  String get currentTarget => _currentIndex < _letters.length ? _letters[_currentIndex] : '';
  bool get isCompleted => _currentIndex >= _letters.length;

  /// Changes the active alphabet set and resets progress.
  void setType(AlphabetType newType) {
    _type = newType;
    _letters = AlphabetData.getLetters(newType);
    reset();
  }

  /// Checks if the collided letter matches the active target.
  /// If matched, advances to the next letter.
  bool checkHit(String letter) {
    if (isCompleted) return false;

    if (letter == currentTarget) {
      _currentIndex++;
      if (_currentIndex >= _letters.length) {
        progressNotifier.value = 1.0;
        isCompletedNotifier.value = true;
      } else {
        targetLetterNotifier.value = currentTarget;
        progressNotifier.value = _currentIndex / _letters.length;
      }
      return true;
    }
    return false;
  }

  /// Returns a random letter other than the current target to serve as a distractor.
  String getRandomDistractor() {
    if (_letters.length <= 1) return currentTarget;
    String candidate;
    do {
      candidate = _letters[_random.nextInt(_letters.length)];
    } while (candidate == currentTarget);
    return candidate;
  }

  /// Resets progression back to the beginning.
  void reset() {
    _currentIndex = 0;
    isCompletedNotifier.value = false;
    targetLetterNotifier.value = _letters.isNotEmpty ? _letters[0] : '';
    progressNotifier.value = 0.0;
  }

  void dispose() {
    targetLetterNotifier.dispose();
    progressNotifier.dispose();
    isCompletedNotifier.dispose();
  }
}
