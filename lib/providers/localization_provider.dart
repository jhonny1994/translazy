import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/infrastructure/infrastructure.dart';
import 'package:translazy/providers/providers.dart';

final localizationNotifierProvider =
    StateNotifierProvider<LocalizationNotifier, Locale>((ref) {
  return LocalizationNotifier(ref.read(sharedPreferencesProvider));
});
