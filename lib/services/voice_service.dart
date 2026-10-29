import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../game/models/alphabet_data.dart';

/// Text-to-speech voice service to pronounce letters and celebratory praises for kids.
class VoiceService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool isMuted = false;

  VoiceService({this.isMuted = false});

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await _flutterTts.setSpeechRate(0.45); // Slower, clearer cadence for children
      await _flutterTts.setPitch(1.15); // Friendly, gentle pitch
      _isInitialized = true;
    } catch (e) {
      debugPrint('VoiceService: init skipped ($e)');
    }
  }

  /// Pronounces a single letter with the appropriate accent/locale.
  Future<void> speakLetter(String letter, {AlphabetType type = AlphabetType.english}) async {
    if (isMuted) return;
    try {
      if (!_isInitialized) {
        await init();
      }
      final langCode = AlphabetData.getLanguageCode(type);
      await _flutterTts.setLanguage(langCode);
      await _flutterTts.speak(letter);
    } catch (e) {
      debugPrint('VoiceService: speakLetter skipped ($e)');
    }
  }

  /// Speaks a celebratory prompt or friendly encouragement.
  Future<void> speakText(String text, {AlphabetType type = AlphabetType.english}) async {
    if (isMuted) return;
    try {
      if (!_isInitialized) {
        await init();
      }
      final langCode = AlphabetData.getLanguageCode(type);
      await _flutterTts.setLanguage(langCode);
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('VoiceService: speakText skipped ($e)');
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (_) {}
  }
}

