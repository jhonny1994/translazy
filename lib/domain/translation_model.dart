import 'package:freezed_annotation/freezed_annotation.dart';
part 'translation_model.g.dart';
part 'translation_model.freezed.dart';

@freezed
class TranslationRecord with _$TranslationRecord {
  const factory TranslationRecord({
    required String sourceText,
    required String translatedText,
    required String sourceLang,
    required String targetLang,
    required DateTime timestamp,
  }) = _TranslationRecord;

  factory TranslationRecord.fromJson(Map<String, dynamic> json) =>
      _$TranslationRecordFromJson(json);
}
