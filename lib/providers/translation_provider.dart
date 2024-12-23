import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/domain/domain.dart';
import 'package:translazy/infrastructure/infrastructure.dart';
import 'package:translazy/providers/providers.dart';

final translationProvider =
    StateNotifierProvider<TranslationNotifier, TranslationState>((ref) {
  final dio = ref.watch(dioProvider);
  return TranslationNotifier(dio, ref);
});
