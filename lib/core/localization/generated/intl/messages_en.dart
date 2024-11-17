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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("TransLazy"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "clearHistory": MessageLookupByLibrary.simpleMessage("Clear History"),
        "clearSourceText": MessageLookupByLibrary.simpleMessage("Clear text"),
        "copyTranslation":
            MessageLookupByLibrary.simpleMessage("Copy translation"),
        "enterTextToTranslate":
            MessageLookupByLibrary.simpleMessage("Enter text to translate..."),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "noTranslationsYet":
            MessageLookupByLibrary.simpleMessage("No translations yet"),
        "startListening":
            MessageLookupByLibrary.simpleMessage("Start listening"),
        "stopListening": MessageLookupByLibrary.simpleMessage("Stop listening"),
        "sttNotAvailable": MessageLookupByLibrary.simpleMessage(
            "Speech recognition is not available. Please check your microphone settings."),
        "switchLanguages":
            MessageLookupByLibrary.simpleMessage("Switch languages"),
        "textCopiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Text copied to clipboard!"),
        "translate": MessageLookupByLibrary.simpleMessage("Translate"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "translationWillAppearHere": MessageLookupByLibrary.simpleMessage(
            "Translation will appear here...")
      };
}
