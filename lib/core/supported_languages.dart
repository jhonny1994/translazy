class SupportedLanguages {
  static const Map<String, String> languages = {
    'zh': '中文', // Chinese
    'es': 'Español', // Spanish
    'en': 'English', // English
    'hi': 'हिन्दी', // Hindi
    'ar': 'العربية', // Arabic
    'bn': 'বাংলা', // Bengali
    'pt': 'Português', // Portuguese
    'ru': 'русский', // Russian
    'ur': 'Urdu', // Urdu
    'tr': 'Türkçe', // Turkish
    'fr': 'French', // French
    'de': 'Deutsch', // German
    'it': 'Italiano', // Italian
    'ko': '한국어', // Korean
    'ja': '日本語', // Japanese
    'vi': 'Vietnames', // Vietnamese
    'te': 'Telugu', // Telugu
    'mr': 'Marathi', // Marathi
    'ta': 'Tamil', // Tamil
    'pa': 'Punjabi', // Punjabi
    'sw': 'Swahili', // Swahili
    'jv': 'Javanese', // Javanese
    'ms': 'Malay', // Malay
    'ha': 'Hausa', // Hausa
    'gu': 'Gujarati', // Gujarati
    'pl': 'Polski', // Polish
    'ro': 'Romanian', // Romanian
    'uk': 'Ukrainian', // Ukrainian
  };

  static const Map<String, String> flags = {
    'zh': '🇨🇳', // Chinese
    'es': '🇪🇸', // Spanish
    'en': '🇬🇧', // English
    'hi': '🇮🇳', // Hindi
    'ar': '🇸🇦', // Arabic
    'bn': '🇧🇩', // Bengali
    'pt': '🇧🇷', // Portuguese
    'ru': '🇷🇺', // Russian
    'ur': '🇵🇰', // Urdu
    'tr': '🇹🇷', // Turkish
    'fr': '🇫🇷', // French
    'de': '🇩🇪', // German
    'it': '🇮🇹', // Italian
    'ko': '🇰🇷', // Korean
    'ja': '🇯🇵', // Japanese
    'vi': '🇻🇳', // Vietnamese
    'te': '🇮🇳', // Telugu
    'mr': '🇮🇳', // Marathi
    'ta': '🇮🇳', // Tamil
    'pa': '🇮🇳', // Punjabi
    'sw': '🇰🇪', // Swahili
    'jv': '🇮🇩', // Javanese
    'ms': '🇲🇾', // Malay
    'ha': '🇳🇬', // Hausa
    'gu': '🇮🇳', // Gujarati
    'pl': '🇵🇱', // Polish
    'ro': '🇷🇴', // Romanian
    'uk': '🇺🇦', // Ukrainian
  };

  // Method to get the flag emoji by language code
  static String getFlag(String languageCode) {
    return flags[languageCode] ?? '';
  }

  // Method to get the language name by language code
  static String getLanguage(String languageCode) {
    return languages[languageCode] ?? '';
  }
}
