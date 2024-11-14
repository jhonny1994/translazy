import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/domain/translation_model.dart';
import 'package:translazy/infrastructure/translation_history_service.dart';
import 'package:translazy/providers/shared_prefrences_provider.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<TranslationRecord>>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return HistoryNotifier(prefs);
});
