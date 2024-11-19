import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/infrastructure/onboarding_notifier.dart';
import 'package:translazy/providers/shared_prefrences_provider.dart';

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return OnboardingNotifier(prefs);
});
