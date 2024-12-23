import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/infrastructure/infrastructure.dart';
import 'package:translazy/providers/providers.dart';

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return OnboardingNotifier(prefs);
});
