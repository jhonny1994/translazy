import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/infrastructure/localization_service.dart';
import 'package:translazy/providers/shared_prefrences_provider.dart';

final localizationNotifierProvider =
    StateNotifierProvider<LocalizationNotifier, Locale>((ref) {
  return LocalizationNotifier(ref.read(sharedPreferencesProvider));
});
