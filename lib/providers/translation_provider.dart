import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/domain/translation_state.dart';
import 'package:translazy/infrastructure/api_service.dart';
import 'package:translazy/providers/dio_provider.dart';

final translationProvider =
    StateNotifierProvider<TranslationNotifier, TranslationState>((ref) {
  final dio = ref.watch(dioProvider);
  return TranslationNotifier(dio, ref);
});
