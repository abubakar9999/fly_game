import 'package:flutter/foundation.dart';

/// Supported languages in Space Journey.
enum AppLanguage {
  en,
  bn,
}

/// Localized strings provider for Bangla and English.
class GameStrings {
  static final ValueNotifier<AppLanguage> languageNotifier =
      ValueNotifier<AppLanguage>(AppLanguage.en);

  static AppLanguage get currentLanguage => languageNotifier.value;

  static void setLanguage(AppLanguage language) {
    languageNotifier.value = language;
  }

  static String get appTitle =>
      currentLanguage == AppLanguage.bn ? 'মহাকাশ ভ্রমণ' : 'Space Journey';

  static String get play =>
      currentLanguage == AppLanguage.bn ? 'শুরু করো' : 'Play';

  static String get easy =>
      currentLanguage == AppLanguage.bn ? 'সহজ' : 'Easy';

  static String get medium =>
      currentLanguage == AppLanguage.bn ? 'মাঝারি' : 'Medium';

  static String get hard =>
      currentLanguage == AppLanguage.bn ? 'কঠিন' : 'Hard';

  static String get score =>
      currentLanguage == AppLanguage.bn ? 'স্কোর' : 'Score';

  static String get highScore =>
      currentLanguage == AppLanguage.bn ? 'সেরা স্কোর' : 'High Score';

  static String get paused =>
      currentLanguage == AppLanguage.bn ? 'বিরতি' : 'Paused';

  static String get resume =>
      currentLanguage == AppLanguage.bn ? 'চালিয়ে যান' : 'Resume';

  static String get restart =>
      currentLanguage == AppLanguage.bn ? 'আবার খেলুন' : 'Restart';

  static String get home =>
      currentLanguage == AppLanguage.bn ? 'হোম' : 'Home';

  static String get tryAgain =>
      currentLanguage == AppLanguage.bn ? 'আবার চেষ্টা করো!' : 'Try again!';

  static String get soundOn =>
      currentLanguage == AppLanguage.bn ? 'শব্দ: চালু' : 'Sound: ON';

  static String get soundOff =>
      currentLanguage == AppLanguage.bn ? 'শব্দ: বন্ধ' : 'Sound: OFF';

  static String get difficultyTitle =>
      currentLanguage == AppLanguage.bn ? 'লেভেল বাছাই' : 'Select Difficulty';
}

