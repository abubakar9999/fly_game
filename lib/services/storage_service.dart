import 'package:shared_preferences/shared_preferences.dart';
import '../game/config.dart';

/// Service to persist high scores, unlocked stickers, and user preferences using SharedPreferences.
class StorageService {
  static const String _keyEasy = 'highScore_easy';
  static const String _keyMedium = 'highScore_medium';
  static const String _keyHard = 'highScore_hard';
  static const String _keyMuted = 'isMuted';
  static const String _keyLanguage = 'language';
  static const String _keyRocketSkin = 'rocket_skin';
  static const String _keyStickers = 'unlocked_stickers';
  static const String _keyTotalStars = 'total_stars_stardust';

  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  String _getKeyForDifficulty(GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return _keyEasy;
      case GameDifficulty.medium:
        return _keyMedium;
      case GameDifficulty.hard:
        return _keyHard;
    }
  }

  /// Retrieves high score for the requested difficulty.
  Future<int> getHighScore(GameDifficulty difficulty) async {
    final prefs = await _getPrefs();
    return prefs.getInt(_getKeyForDifficulty(difficulty)) ?? 0;
  }

  /// Saves a new high score if it is higher than the current saved score.
  Future<void> saveHighScore(GameDifficulty difficulty, int newScore) async {
    final prefs = await _getPrefs();
    final key = _getKeyForDifficulty(difficulty);
    final current = prefs.getInt(key) ?? 0;
    if (newScore > current) {
      await prefs.setInt(key, newScore);
    }
  }

  /// Gets mute setting.
  Future<bool> getIsMuted() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_keyMuted) ?? false;
  }

  /// Saves mute setting.
  Future<void> saveIsMuted(bool isMuted) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyMuted, isMuted);
  }

  /// Gets selected language code ('en' or 'bn').
  Future<String> getLanguage() async {
    final prefs = await _getPrefs();
    return prefs.getString(_keyLanguage) ?? 'en';
  }

  /// Saves selected language code.
  Future<void> saveLanguage(String langCode) async {
    final prefs = await _getPrefs();
    await prefs.setString(_keyLanguage, langCode);
  }

  /// Gets the selected rocket skin.
  Future<RocketSkin> getRocketSkin() async {
    final prefs = await _getPrefs();
    final index = prefs.getInt(_keyRocketSkin) ?? 0;
    return RocketSkin.values[index.clamp(0, RocketSkin.values.length - 1)];
  }

  /// Saves the selected rocket skin.
  Future<void> saveRocketSkin(RocketSkin skin) async {
    final prefs = await _getPrefs();
    await prefs.setInt(_keyRocketSkin, skin.index);
  }

  /// Gets unlocked sticker characters.
  Future<Set<String>> getUnlockedStickers() async {
    final prefs = await _getPrefs();
    final list = prefs.getStringList(_keyStickers) ?? <String>[];
    return list.toSet();
  }

  /// Unlocks a sticker and persists it.
  Future<void> unlockSticker(String char) async {
    final prefs = await _getPrefs();
    final list = prefs.getStringList(_keyStickers) ?? <String>[];
    if (!list.contains(char)) {
      list.add(char);
      await prefs.setStringList(_keyStickers, list);
    }
  }

  /// Gets total stardust stars collected.
  Future<int> getTotalStars() async {
    final prefs = await _getPrefs();
    return prefs.getInt(_keyTotalStars) ?? 0;
  }

  /// Adds stars to total stardust bank.
  Future<void> addTotalStars(int stars) async {
    final prefs = await _getPrefs();
    final current = prefs.getInt(_keyTotalStars) ?? 0;
    await prefs.setInt(_keyTotalStars, current + stars);
  }
}
