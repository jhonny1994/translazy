import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translazy/core/core.dart';

class LocalizationNotifier extends StateNotifier<Locale> {
  LocalizationNotifier(this.prefs) : super(S.delegate.supportedLocales.first) {
    _init();
  }

  final SharedPreferences prefs;

  Future<void> _init() async {
    final currentLocale = prefs.getString('locale');
    if (currentLocale != null) {
      state = Locale(currentLocale);
    } else {
      state = S.delegate.supportedLocales.first;
    }
  }

  Future<void> toggle(Locale locale) async {
    state = locale;
    await prefs.setString('locale', locale.languageCode);
  }
}
