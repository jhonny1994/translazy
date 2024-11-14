import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/infrastructure/theme_service.dart';
import 'package:translazy/providers/shared_prefrences_provider.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeService, bool>(
  (ref) => ThemeService(ref.read(sharedPreferencesProvider)),
);
