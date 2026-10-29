import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

/// Manages sound effects and background music with safety checks and mute support.
class AudioManager {
  bool _isMuted = false;
  bool _isMusicPlaying = false;

  bool get isMuted => _isMuted;
  bool get isMusicPlaying => _isMusicPlaying;

  Future<void> setMuted(bool muted) async {
    _isMuted = muted;
    try {
      if (_isMuted) {
        await stopBgm();
      } else {
        await resumeBgm();
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
      _isMusicPlaying = false;
    }
  }

  /// Pauses background music.
  Future<void> pauseBgm() async {
    if (!_isMusicPlaying) return;
    try {
      await FlameAudio.bgm.pause();
    } catch (e) {
      debugPrint('AudioManager: pauseBgm skipped ($e)');
    }
  }

  /// Resumes background music.
  Future<void> resumeBgm() async {
    if (_isMuted || !_isMusicPlaying) return;
    try {
      await FlameAudio.bgm.resume();
    } catch (e) {
      debugPrint('AudioManager: resumeBgm skipped ($e)');
    }
  }

  /// Stops background music completely.
  Future<void> stopBgm() async {
    if (!_isMusicPlaying) return;
    try {
      await FlameAudio.bgm.stop();
    } catch (e) {
      debugPrint('AudioManager: stopBgm skipped ($e)');
    } finally {
      _isMusicPlaying = false;
    }
  }

  void dispose() {
    try {
      if (_isMusicPlaying) {
        FlameAudio.bgm.stop().catchError((_) {});
        _isMusicPlaying = false;
      }
      FlameAudio.bgm.dispose();
    } catch (_) {}
  }
}
