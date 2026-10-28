import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

/// Manages sound effects and background music with safety checks and mute support.
class AudioManager {
  bool _isMuted = false;
  bool _isMusicPlaying = false;

  bool get isMuted => _isMuted;

  void setMuted(bool muted) {
    _isMuted = muted;
    try {
      if (_isMuted) {
        stopBgm();
      } else {
        resumeBgm();
      }
    } catch (e) {
      debugPrint('AudioManager: setMuted failed ($e)');
    }
  }

  /// Plays item collection SFX.
  Future<void> playCollect() async {
    if (_isMuted) return;
    try {
      // TODO: replace asset with custom audio in assets/audio/collect.wav
      await FlameAudio.play('collect.wav');
    } catch (e) {
      debugPrint('AudioManager: collect sound skipped ($e)');
    }
  }

  /// Plays damage/hit SFX.
  Future<void> playHit() async {
    if (_isMuted) return;
    try {
      // TODO: replace asset with custom audio in assets/audio/hit.wav
      await FlameAudio.play('hit.wav');
    } catch (e) {
      debugPrint('AudioManager: hit sound skipped ($e)');
    }
  }

  /// Plays UI button tap SFX.
  Future<void> playTap() async {
    if (_isMuted) return;
    try {
      // TODO: replace asset with custom audio in assets/audio/tap.wav
      await FlameAudio.play('tap.wav');
    } catch (e) {
      debugPrint('AudioManager: tap sound skipped ($e)');
    }
  }

  /// Starts background music loop.
  Future<void> startBgm() async {
    if (_isMuted || _isMusicPlaying) return;
    try {
      // TODO: replace asset with custom audio in assets/audio/music.mp3
      await FlameAudio.bgm.play('music.mp3', volume: 0.5);
      _isMusicPlaying = true;
    } catch (e) {
      debugPrint('AudioManager: background music skipped ($e)');
    }
  }

  /// Pauses background music.
  void pauseBgm() {
    try {
      if (_isMusicPlaying) {
        FlameAudio.bgm.pause();
      }
    } catch (_) {}
  }

  /// Resumes background music.
  void resumeBgm() {
    if (_isMuted) return;
    try {
      FlameAudio.bgm.resume();
      _isMusicPlaying = true;
    } catch (_) {}
  }

  /// Stops background music completely.
  void stopBgm() {
    try {
      FlameAudio.bgm.stop();
      _isMusicPlaying = false;
    } catch (_) {}
  }

  void dispose() {
    try {
      stopBgm();
      FlameAudio.bgm.dispose();
    } catch (_) {}
  }
}
