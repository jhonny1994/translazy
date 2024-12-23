import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/infrastructure/infrastructure.dart';
import 'package:translazy/providers/providers.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeService, bool>(
  (ref) => ThemeService(ref.read(sharedPreferencesProvider)),
);
