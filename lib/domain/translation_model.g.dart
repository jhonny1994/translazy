// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslationRecordImpl _$$TranslationRecordImplFromJson(
  Map<String, dynamic> json,
) =>
    _$TranslationRecordImpl(
      sourceText: json['sourceText'] as String,
      translatedText: json['translatedText'] as String,
      sourceLang: json['sourceLang'] as String,
      targetLang: json['targetLang'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$TranslationRecordImplToJson(
  _$TranslationRecordImpl instance,
) =>
    <String, dynamic>{
      'sourceText': instance.sourceText,
      'translatedText': instance.translatedText,
      'sourceLang': instance.sourceLang,
      'targetLang': instance.targetLang,
      'timestamp': instance.timestamp.toIso8601String(),
    };
