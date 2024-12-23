import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/domain/domain.dart';
import 'package:translazy/infrastructure/infrastructure.dart';
import 'package:translazy/providers/providers.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<TranslationRecord>>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return HistoryNotifier(prefs);
});
