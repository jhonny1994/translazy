// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TranslationRecord _$TranslationRecordFromJson(Map<String, dynamic> json) {
  return _TranslationRecord.fromJson(json);
}

/// @nodoc
mixin _$TranslationRecord {
  String get sourceText => throw _privateConstructorUsedError;
  String get translatedText => throw _privateConstructorUsedError;
  String get sourceLang => throw _privateConstructorUsedError;
  String get targetLang => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this TranslationRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TranslationRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslationRecordCopyWith<TranslationRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationRecordCopyWith<$Res> {
  factory $TranslationRecordCopyWith(
          TranslationRecord value, $Res Function(TranslationRecord) then) =
      _$TranslationRecordCopyWithImpl<$Res, TranslationRecord>;
  @useResult
  $Res call(
      {String sourceText,
      String translatedText,
      String sourceLang,
      String targetLang,
      DateTime timestamp});
}

/// @nodoc
class _$TranslationRecordCopyWithImpl<$Res, $Val extends TranslationRecord>
    implements $TranslationRecordCopyWith<$Res> {
  _$TranslationRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceText = null,
    Object? translatedText = null,
    Object? sourceLang = null,
    Object? targetLang = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      sourceText: null == sourceText
          ? _value.sourceText
          : sourceText // ignore: cast_nullable_to_non_nullable
              as String,
      translatedText: null == translatedText
          ? _value.translatedText
          : translatedText // ignore: cast_nullable_to_non_nullable
              as String,
      sourceLang: null == sourceLang
          ? _value.sourceLang
          : sourceLang // ignore: cast_nullable_to_non_nullable
              as String,
      targetLang: null == targetLang
          ? _value.targetLang
          : targetLang // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranslationRecordImplCopyWith<$Res>
    implements $TranslationRecordCopyWith<$Res> {
  factory _$$TranslationRecordImplCopyWith(_$TranslationRecordImpl value,
          $Res Function(_$TranslationRecordImpl) then) =
      __$$TranslationRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sourceText,
      String translatedText,
      String sourceLang,
      String targetLang,
      DateTime timestamp});
}

/// @nodoc
class __$$TranslationRecordImplCopyWithImpl<$Res>
    extends _$TranslationRecordCopyWithImpl<$Res, _$TranslationRecordImpl>
    implements _$$TranslationRecordImplCopyWith<$Res> {
  __$$TranslationRecordImplCopyWithImpl(_$TranslationRecordImpl _value,
      $Res Function(_$TranslationRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceText = null,
    Object? translatedText = null,
    Object? sourceLang = null,
    Object? targetLang = null,
    Object? timestamp = null,
  }) {
    return _then(_$TranslationRecordImpl(
      sourceText: null == sourceText
          ? _value.sourceText
          : sourceText // ignore: cast_nullable_to_non_nullable
              as String,
      translatedText: null == translatedText
          ? _value.translatedText
          : translatedText // ignore: cast_nullable_to_non_nullable
              as String,
      sourceLang: null == sourceLang
          ? _value.sourceLang
          : sourceLang // ignore: cast_nullable_to_non_nullable
              as String,
      targetLang: null == targetLang
          ? _value.targetLang
          : targetLang // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TranslationRecordImpl implements _TranslationRecord {
  const _$TranslationRecordImpl(
      {required this.sourceText,
      required this.translatedText,
      required this.sourceLang,
      required this.targetLang,
      required this.timestamp});

  factory _$TranslationRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranslationRecordImplFromJson(json);

  @override
  final String sourceText;
  @override
  final String translatedText;
  @override
  final String sourceLang;
  @override
  final String targetLang;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'TranslationRecord(sourceText: $sourceText, translatedText: $translatedText, sourceLang: $sourceLang, targetLang: $targetLang, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationRecordImpl &&
            (identical(other.sourceText, sourceText) ||
                other.sourceText == sourceText) &&
            (identical(other.translatedText, translatedText) ||
                other.translatedText == translatedText) &&
            (identical(other.sourceLang, sourceLang) ||
                other.sourceLang == sourceLang) &&
            (identical(other.targetLang, targetLang) ||
                other.targetLang == targetLang) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sourceText, translatedText,
      sourceLang, targetLang, timestamp);

  /// Create a copy of TranslationRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationRecordImplCopyWith<_$TranslationRecordImpl> get copyWith =>
      __$$TranslationRecordImplCopyWithImpl<_$TranslationRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TranslationRecordImplToJson(
      this,
    );
  }
}

abstract class _TranslationRecord implements TranslationRecord {
  const factory _TranslationRecord(
      {required final String sourceText,
      required final String translatedText,
      required final String sourceLang,
      required final String targetLang,
      required final DateTime timestamp}) = _$TranslationRecordImpl;

  factory _TranslationRecord.fromJson(Map<String, dynamic> json) =
      _$TranslationRecordImpl.fromJson;

  @override
  String get sourceText;
  @override
  String get translatedText;
  @override
  String get sourceLang;
  @override
  String get targetLang;
  @override
  DateTime get timestamp;

  /// Create a copy of TranslationRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationRecordImplCopyWith<_$TranslationRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
