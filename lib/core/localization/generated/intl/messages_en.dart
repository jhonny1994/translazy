// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(code, message) => "API Error: ${code} - ${message}";

  static String m1(seconds) =>
      "Too many requests. Please wait ${seconds} seconds.";

  static String m2(maxLength) =>
      "Text exceeds maximum length of ${maxLength} characters";

  static String m3(seconds) =>
      "Request timed out after ${seconds} seconds. Please try again.";

  static String m4(message) => "Unexpected Error: ${message}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "apiError": m0,
        "appName": MessageLookupByLibrary.simpleMessage("TransLazy"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "clearHistory": MessageLookupByLibrary.simpleMessage("Clear History"),
        "clearSourceText": MessageLookupByLibrary.simpleMessage("Clear text"),
        "copyTranslation":
            MessageLookupByLibrary.simpleMessage("Copy translation"),
        "emptyTextError": MessageLookupByLibrary.simpleMessage(
            "Please enter text to translate"),
        "enterTextToTranslate":
            MessageLookupByLibrary.simpleMessage("Enter text to translate..."),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "maxListeningDurationReached": MessageLookupByLibrary.simpleMessage(
            "Maximum listening duration reached. Please try again."),
        "microphonePermissionDenied": MessageLookupByLibrary.simpleMessage(
            "Microphone permission is required for speech recognition."),
        "networkError": MessageLookupByLibrary.simpleMessage(
            "Network error. Please check your connection."),
        "noTranslationsYet":
            MessageLookupByLibrary.simpleMessage("No translations yet"),
        "rateLimitError": m1,
        "selectLanguage":
            MessageLookupByLibrary.simpleMessage("Select language"),
        "startListening":
            MessageLookupByLibrary.simpleMessage("Start listening"),
        "stopListening": MessageLookupByLibrary.simpleMessage("Stop listening"),
        "sttNotAvailable": MessageLookupByLibrary.simpleMessage(
            "Speech recognition is not available. Please check your microphone settings."),
        "switchLanguages":
            MessageLookupByLibrary.simpleMessage("Switch languages"),
        "textCopiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Text copied to clipboard!"),
        "textTooLongError": m2,
        "timeoutError": m3,
        "translate": MessageLookupByLibrary.simpleMessage("Translate"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "translationWillAppearHere": MessageLookupByLibrary.simpleMessage(
            "Translation will appear here..."),
        "unexpectedError": m4
      };
}
