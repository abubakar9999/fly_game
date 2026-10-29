enum AlphabetType {
  english,
  banglaSwaraborno,
  banglaByanjanborno,
  arabic,
}

/// Information and letter datasets for educational modules.
class AlphabetData {
  AlphabetData._();

  static const List<String> englishLetters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z',
  ];

  static const Map<String, String> englishWords = {
    'A': 'Astronaut',
    'B': 'Balloon',
    'C': 'Comet',
    'D': 'Discovery',
    'E': 'Earth',
    'F': 'Fire',
    'G': 'Galaxy',
    'H': 'Helmet',
    'I': 'Island',
    'J': 'Jupiter',
    'K': 'Kinetic',
    'L': 'Launch',
    'M': 'Moon',
    'N': 'Nebula',
    'O': 'Orbit',
    'P': 'Planet',
    'Q': 'Quasar',
    'R': 'Rocket',
    'S': 'Star',
    'T': 'Telescope',
    'U': 'Universe',
    'V': 'Venus',
    'W': 'Wormhole',
    'X': 'X-Ray',
    'Y': 'Year',
    'Z': 'Zero-G',
  };

  static const List<String> banglaSwarabornoLetters = [
    'অ', 'আ', 'ই', 'ঈ', 'উ', 'ঊ', 'ঋ', 'এ', 'ঐ', 'ও', 'ঔ',
  ];

  static const List<String> banglaByanjanbornoLetters = [
    'ক', 'খ', 'গ', 'ঘ', 'ঙ',
    'চ', 'ছ', 'জ', 'ঝ', 'ঞ',
    'ট', 'ঠ', 'ড', 'ঢ', 'ণ',
    'ত', 'থ', 'দ', 'ধ', 'ন',
    'প', 'ফ', 'ব', 'ভ', 'ম',
    'য', 'র', 'ল', 'শ', 'ষ',
    'স', 'হ',
  ];

  static const List<String> arabicLetters = [
    'أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ',
    'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص',
    'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق',
    'ك', 'ل', 'م', 'ن', 'هـ', 'و', 'ي',
  ];

  static List<String> getLetters(AlphabetType type) {
    switch (type) {
      case AlphabetType.english:
        return englishLetters;
      case AlphabetType.banglaSwaraborno:
        return banglaSwarabornoLetters;
      case AlphabetType.banglaByanjanborno:
        return banglaByanjanbornoLetters;
      case AlphabetType.arabic:
        return arabicLetters;
    }
  }

  static String getTitle(AlphabetType type) {
    switch (type) {
      case AlphabetType.english:
        return 'English ABC (A-Z)';
      case AlphabetType.banglaSwaraborno:
        return 'বাংলা স্বরবর্ণ (অ-ঔ)';
      case AlphabetType.banglaByanjanborno:
        return 'বাংলা ব্যঞ্জনবর্ণ (ক-হ)';
      case AlphabetType.arabic:
        return 'الحروف العربية (أ-ي)';
    }
  }

  static String getLanguageCode(AlphabetType type) {
    switch (type) {
      case AlphabetType.english:
        return 'en-US';
      case AlphabetType.banglaSwaraborno:
      case AlphabetType.banglaByanjanborno:
        return 'bn-BD';
      case AlphabetType.arabic:
        return 'ar';
    }
  }
}

