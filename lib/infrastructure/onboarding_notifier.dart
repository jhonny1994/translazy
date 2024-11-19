import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingNotifier extends StateNotifier<bool> {
  OnboardingNotifier(this.prefs) : super(false) {
    _loadOnboardingState();
  }
  final SharedPreferences prefs;

  Future<void> _loadOnboardingState() async {
    state = prefs.getBool('has_completed_onboarding') ?? false;
  }

  Future<void> completeOnboarding() async {
    await prefs.setBool('has_completed_onboarding', true);
    state = true;
  }
}
