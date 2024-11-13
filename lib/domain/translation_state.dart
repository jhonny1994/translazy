import 'package:freezed_annotation/freezed_annotation.dart';
part 'translation_state.freezed.dart';

@freezed
class TranslationState with _$TranslationState {
  const factory TranslationState({
    @Default(false) bool isLoading,
    String? translation,
    String? error,
  }) = _TranslationState;

  factory TranslationState.initial() => const TranslationState();
}
