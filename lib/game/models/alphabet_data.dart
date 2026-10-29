enum AlphabetType {
  english,
  banglaSwaraborno,
  banglaByanjanborno,
  arabic,
  numbersEnglish,
  numbersBangla,
  numbersArabic,
  wordsEnglish,
  wordsBangla,
  wordsArabic,
}

/// A word-spelling challenge mission for kids.
class WordMission {
  final String word;
  final String emoji;
  final List<String> letters;

  const WordMission({
    required this.word,
    required this.emoji,
    required this.letters,
  });
}

/// Information, phonetic words, emojis, word spelling missions, and datasets for educational modules.
class AlphabetData {
  AlphabetData._();

  static const List<String> englishLetters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z',
  ];

  static const List<String> englishNumbers = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
    '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
  ];

  static const List<String> banglaNumbers = [
    '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯', '১০',
    '১১', '১২', '১৩', '১৪', '১৫', '১৬', '১৭', '১৮', '১৯', '২০',
  ];

  static const List<String> arabicNumbers = [
    '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩', '١٠',
    '١١', '١٢', '١٣', '١٤', '١٥', '١٦', '١٧', '١٨', '١٩', '٢٠',
  ];

  static const List<WordMission> englishWordMissions = [
    WordMission(word: 'CAT', emoji: '🐱', letters: ['C', 'A', 'T']),
    WordMission(word: 'SUN', emoji: '☀️', letters: ['S', 'U', 'N']),
    WordMission(word: 'DOG', emoji: '🐶', letters: ['D', 'O', 'G']),
    WordMission(word: 'JET', emoji: '🚀', letters: ['J', 'E', 'T']),
    WordMission(word: 'STAR', emoji: '⭐', letters: ['S', 'T', 'A', 'R']),
  ];

  static const List<WordMission> banglaWordMissions = [
    WordMission(word: 'আম', emoji: '🥭', letters: ['আ', 'ম']),
    WordMission(word: 'বই', emoji: '📖', letters: ['ব', 'ই']),
    WordMission(word: 'মাছ', emoji: '🐟', letters: ['ম', 'া', 'ছ']),
    WordMission(word: 'ফুল', emoji: '🌸', letters: ['ফ', 'ু', 'ল']),
    WordMission(word: 'চাঁদ', emoji: '🌙', letters: ['চ', 'া', 'ঁ', 'দ']),
  ];

  static const List<WordMission> arabicWordMissions = [
    WordMission(word: 'قمر', emoji: '🌙', letters: ['ق', 'م', 'ر']),
    WordMission(word: 'أسد', emoji: '🦁', letters: ['أ', 'س', 'د']),
    WordMission(word: 'شمس', emoji: '☀️', letters: ['ش', 'م', 'س']),
    WordMission(word: 'كرة', emoji: '⚽', letters: ['ك', 'ر', 'ة']),
  ];

  static const Map<String, String> phonicsWords = {
    'A': 'Apple',
    'B': 'Balloon',
    'C': 'Cat',
    'D': 'Dog',
    'E': 'Earth',
    'F': 'Fish',
    'G': 'Grapes',
    'H': 'Hat',
    'I': 'Ice',
    'J': 'Jet',
    'K': 'Kite',
    'L': 'Lion',
    'M': 'Moon',
    'N': 'Nest',
    'O': 'Orange',
    'P': 'Planet',
    'Q': 'Queen',
    'R': 'Rocket',
    'S': 'Star',
    'T': 'Tiger',
    'U': 'Umbrella',
    'V': 'Violin',
    'W': 'Whale',
    'X': 'Xylophone',
    'Y': 'Yo-yo',
    'Z': 'Zebra',
    'অ': 'অলি',
    'আ': 'আম',
    'ই': 'ইঁদুর',
    'ঈ': 'ঈগল',
    'উ': 'উট',
    'ঊ': 'ঊষা',
    'ঋ': 'ঋষি',
    'এ': 'একতারা',
    'ঐ': 'ঐরাবত',
    'ও': 'ওল',
    'ঔ': 'ঔষধ',
    'ক': 'কলা',
    'খ': 'খরগোশ',
    'গ': 'গরু',
    'ঘ': 'ঘোড়া',
    'ঙ': 'ব্যাঙ',
    'চ': 'চাঁদ',
    'ছ': 'ছাতা',
    'জ': 'জাহাজ',
    'ঝ': 'ঝুড়ি',
    'ঞ': 'মিঞা',
    'ট': 'টিয়া',
    'ঠ': 'ঠেলাগাড়ি',
    'ড': 'ডাব',
    'ঢ': 'ঢাক',
    'ণ': 'হরিণ',
    'ত': 'তরমুজ',
    'থ': 'থালা',
    'দ': 'দুধ',
    'ধ': 'ধনুক',
    'ন': 'নৌকা',
    'প': 'পাখি',
    'ফ': 'ফুল',
    'ব': 'বই',
    'ভ': 'ভালুক',
    'ম': 'মাছ',
    'য': 'যানবাহন',
    'র': 'রংধনু',
    'ল': 'লাটিম',
    'শ': 'শাপলা',
    'ষ': 'ষাঁড়',
    'স': 'সিংহ',
    'হ': 'হাতি',
    'أ': 'أسد',
    'ب': 'بطة',
    'ت': 'تفاحة',
    'ث': 'ثعلب',
    'ج': 'جمل',
    'ح': 'حصان',
    'خ': 'خروف',
    'د': 'دب',
    'ذ': 'ذئب',
    'ر': 'صاروخ',
    'ز': 'زرافة',
    'س': 'سمكة',
    'ش': 'شمس',
    'ص': 'صقر',
    'ض': 'ضفدع',
    'ط': 'طائرة',
    'ظ': 'ظرف',
    'ع': 'عنب',
    'غ': 'غراب',
    'ف': 'فيل',
    'ق': 'قمر',
    'ك': 'كرة',
    'ل': 'ليمون',
    'م': 'موز',
    'ن': 'نجمة',
    'هـ': 'هدية',
    'و': 'وردة',
    'ي': 'يد',
  };

  static const Map<String, String> phonicsEmojis = {
    'A': '🍎',
    'B': '🎈',
    'C': '🐱',
    'D': '🐶',
    'E': '🌍',
    'F': '🐟',
    'G': '🍇',
    'H': '🎩',
    'I': '🍦',
    'J': '✈️',
    'K': '🪁',
    'L': '🦁',
    'M': '🌙',
    'N': '🪺',
    'O': '🍊',
    'P': '🪐',
    'Q': '👑',
    'R': '🚀',
    'S': '⭐',
    'T': '🐯',
    'U': '☂️',
    'V': '🎻',
    'W': '🐳',
    'X': '🎼',
    'Y': '🪀',
    'Z': '🦓',
    'অ': '🐝',
    'আ': '🥭',
    'ই': '🐀',
    'ঈ': '🦅',
    'উ': '🐫',
    'ঊ': '🌅',
    'ঋ': '🧘',
    'এ': '🎸',
    'ঐ': '🐘',
    'ও': '🥔',
    'ঔ': '💊',
    'ক': '🍌',
    'খ': '🐇',
    'গ': '🐄',
    'ঘ': '🐎',
    'ঙ': '🐸',
    'চ': '🌙',
    'ছ': '☂️',
    'জ': '🚢',
    'ঝ': '🧺',
    'ঞ': '🐱',
    'ট': '🦜',
    'ঠ': '🛒',
    'ড': '🥥',
    'ঢ': '🥁',
    'ণ': '🦌',
    'ত': '🍉',
    'থ': '🍽️',
    'দ': '🥛',
    'ধ': '🏹',
    'ন': '⛵',
    'প': '🐦',
    'ফ': '🌺',
    'ব': '📖',
    'ভ': '🐻',
    'ম': '🐟',
    'য': '🚗',
    'র': '🌈',
    'ল': '🍭',
    'শ': '🪷',
    'ষ': '🐂',
    'স': '🦁',
    'হ': '🐘',
    'أ': '🦁',
    'ب': '🦆',
    'ت': '🍎',
    'ث': '🦊',
    'ج': '🐫',
    'ح': '🐎',
    'خ': '🐑',
    'د': '🐻',
    'ذ': '🐺',
    'ر': '🚀',
    'ز': '🦒',
    'س': '🐟',
    'ش': '☀️',
    'ص': '🦅',
    'ض': '🐸',
    'ط': '✈️',
    'ظ': '✉️',
    'ع': '🍇',
    'غ': '🐦',
    'ف': '🐘',
    'ق': '🌙',
    'ك': '⚽',
    'ل': '🍋',
    'م': '🍌',
    'ن': '🌟',
    'هـ': '🎁',
    'و': '🌹',
    'ي': '🖐️',
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
      case AlphabetType.numbersEnglish:
        return englishNumbers;
      case AlphabetType.numbersBangla:
        return banglaNumbers;
      case AlphabetType.numbersArabic:
        return arabicNumbers;
      case AlphabetType.wordsEnglish:
        return englishWordMissions.expand((m) => m.letters).toList();
      case AlphabetType.wordsBangla:
        return banglaWordMissions.expand((m) => m.letters).toList();
      case AlphabetType.wordsArabic:
        return arabicWordMissions.expand((m) => m.letters).toList();
    }
  }

  static List<WordMission> getWordMissions(AlphabetType type) {
    switch (type) {
      case AlphabetType.wordsEnglish:
        return englishWordMissions;
      case AlphabetType.wordsBangla:
        return banglaWordMissions;
      case AlphabetType.wordsArabic:
        return arabicWordMissions;
      default:
        return const [];
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
      case AlphabetType.numbersEnglish:
        return 'Numbers (1 - 20)';
      case AlphabetType.numbersBangla:
        return 'বাংলা সংখ্যা (১ - ২০)';
      case AlphabetType.numbersArabic:
        return 'الأرقام العربية (١ - ٢٠)';
      case AlphabetType.wordsEnglish:
        return 'Word Builder (English)';
      case AlphabetType.wordsBangla:
        return 'শব্দ গঠন (বাংলা)';
      case AlphabetType.wordsArabic:
        return 'بناء الكلمات (العربية)';
    }
  }

  static String getLanguageCode(AlphabetType type) {
    switch (type) {
      case AlphabetType.english:
      case AlphabetType.numbersEnglish:
      case AlphabetType.wordsEnglish:
        return 'en-US';
      case AlphabetType.banglaSwaraborno:
      case AlphabetType.banglaByanjanborno:
      case AlphabetType.numbersBangla:
      case AlphabetType.wordsBangla:
        return 'bn-BD';
      case AlphabetType.arabic:
      case AlphabetType.numbersArabic:
      case AlphabetType.wordsArabic:
        return 'ar';
    }
  }

  static String getWord(String char) => phonicsWords[char] ?? '';
  static String getEmoji(String char) => phonicsEmojis[char] ?? '✨';
}
