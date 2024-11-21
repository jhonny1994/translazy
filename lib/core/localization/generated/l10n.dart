// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `TransLazy`
  String get appName {
    return Intl.message(
      'TransLazy',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Translation`
  String get translation {
    return Intl.message(
      'Translation',
      name: 'translation',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Speech recognition is not available. Please check your microphone settings.`
  String get sttNotAvailable {
    return Intl.message(
      'Speech recognition is not available. Please check your microphone settings.',
      name: 'sttNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Stop listening`
  String get stopListening {
    return Intl.message(
      'Stop listening',
      name: 'stopListening',
      desc: '',
      args: [],
    );
  }

  /// `Start listening`
  String get startListening {
    return Intl.message(
      'Start listening',
      name: 'startListening',
      desc: '',
      args: [],
    );
  }

  /// `Clear text`
  String get clearSourceText {
    return Intl.message(
      'Clear text',
      name: 'clearSourceText',
      desc: '',
      args: [],
    );
  }

  /// `Enter text to translate...`
  String get enterTextToTranslate {
    return Intl.message(
      'Enter text to translate...',
      name: 'enterTextToTranslate',
      desc: '',
      args: [],
    );
  }

  /// `Switch languages`
  String get switchLanguages {
    return Intl.message(
      'Switch languages',
      name: 'switchLanguages',
      desc: '',
      args: [],
    );
  }

  /// `Text copied to clipboard!`
  String get textCopiedToClipboard {
    return Intl.message(
      'Text copied to clipboard!',
      name: 'textCopiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copy translation`
  String get copyTranslation {
    return Intl.message(
      'Copy translation',
      name: 'copyTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Translation will appear here...`
  String get translationWillAppearHere {
    return Intl.message(
      'Translation will appear here...',
      name: 'translationWillAppearHere',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Translate`
  String get translate {
    return Intl.message(
      'Translate',
      name: 'translate',
      desc: '',
      args: [],
    );
  }

  /// `Clear History`
  String get clearHistory {
    return Intl.message(
      'Clear History',
      name: 'clearHistory',
      desc: '',
      args: [],
    );
  }

  /// `No translations yet`
  String get noTranslationsYet {
    return Intl.message(
      'No translations yet',
      name: 'noTranslationsYet',
      desc: '',
      args: [],
    );
  }

  /// `Please enter text to translate`
  String get emptyTextError {
    return Intl.message(
      'Please enter text to translate',
      name: 'emptyTextError',
      desc: '',
      args: [],
    );
  }

  /// `Text exceeds maximum length of {maxLength} characters`
  String textTooLongError(int maxLength) {
    return Intl.message(
      'Text exceeds maximum length of $maxLength characters',
      name: 'textTooLongError',
      desc: '',
      args: [maxLength],
    );
  }

  /// `Too many requests. Please wait {seconds} seconds.`
  String rateLimitError(int seconds) {
    return Intl.message(
      'Too many requests. Please wait $seconds seconds.',
      name: 'rateLimitError',
      desc: '',
      args: [seconds],
    );
  }

  /// `Request timed out after {seconds} seconds. Please try again.`
  String timeoutError(int seconds) {
    return Intl.message(
      'Request timed out after $seconds seconds. Please try again.',
      name: 'timeoutError',
      desc: '',
      args: [seconds],
    );
  }

  /// `Network error. Please check your connection.`
  String get networkError {
    return Intl.message(
      'Network error. Please check your connection.',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `API Error: {code} - {message}`
  String apiError(int code, String message) {
    return Intl.message(
      'API Error: $code - $message',
      name: 'apiError',
      desc: '',
      args: [code, message],
    );
  }

  /// `Unexpected Error: {message}`
  String unexpectedError(String message) {
    return Intl.message(
      'Unexpected Error: $message',
      name: 'unexpectedError',
      desc: '',
      args: [message],
    );
  }

  /// `Select language`
  String get selectLanguage {
    return Intl.message(
      'Select language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Microphone permission is required for speech recognition.`
  String get microphonePermissionDenied {
    return Intl.message(
      'Microphone permission is required for speech recognition.',
      name: 'microphonePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Maximum listening duration reached. Please try again.`
  String get maxListeningDurationReached {
    return Intl.message(
      'Maximum listening duration reached. Please try again.',
      name: 'maxListeningDurationReached',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
