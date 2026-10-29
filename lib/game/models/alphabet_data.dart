enum AlphabetType {
  english,
  banglaSwaraborno,
  banglaByanjanborno,
  arabic,
  numbersEnglish,
  numbersBangla,
  numbersArabic,
}

/// Information, phonetic words, emojis, and letter/number datasets for educational modules.
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
    }
  }

  static String getLanguageCode(AlphabetType type) {
    switch (type) {
      case AlphabetType.english:
      case AlphabetType.numbersEnglish:
        return 'en-US';
      case AlphabetType.banglaSwaraborno:
      case AlphabetType.banglaByanjanborno:
      case AlphabetType.numbersBangla:
        return 'bn-BD';
      case AlphabetType.arabic:
      case AlphabetType.numbersArabic:
        return 'ar';
    }
  }

  static String getWord(String char) => phonicsWords[char] ?? '';
  static String getEmoji(String char) => phonicsEmojis[char] ?? '✨';
}
