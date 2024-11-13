// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TranslationState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get translation => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslationStateCopyWith<TranslationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationStateCopyWith<$Res> {
  factory $TranslationStateCopyWith(
          TranslationState value, $Res Function(TranslationState) then) =
      _$TranslationStateCopyWithImpl<$Res, TranslationState>;
  @useResult
  $Res call({bool isLoading, String? translation, String? error});
}

/// @nodoc
class _$TranslationStateCopyWithImpl<$Res, $Val extends TranslationState>
    implements $TranslationStateCopyWith<$Res> {
  _$TranslationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? translation = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      translation: freezed == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranslationStateImplCopyWith<$Res>
    implements $TranslationStateCopyWith<$Res> {
  factory _$$TranslationStateImplCopyWith(_$TranslationStateImpl value,
          $Res Function(_$TranslationStateImpl) then) =
      __$$TranslationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? translation, String? error});
}

/// @nodoc
class __$$TranslationStateImplCopyWithImpl<$Res>
    extends _$TranslationStateCopyWithImpl<$Res, _$TranslationStateImpl>
    implements _$$TranslationStateImplCopyWith<$Res> {
  __$$TranslationStateImplCopyWithImpl(_$TranslationStateImpl _value,
      $Res Function(_$TranslationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? translation = freezed,
    Object? error = freezed,
  }) {
    return _then(_$TranslationStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      translation: freezed == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TranslationStateImpl implements _TranslationState {
  const _$TranslationStateImpl(
      {this.isLoading = false, this.translation, this.error});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? translation;
  @override
  final String? error;

  @override
  String toString() {
    return 'TranslationState(isLoading: $isLoading, translation: $translation, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, translation, error);

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationStateImplCopyWith<_$TranslationStateImpl> get copyWith =>
      __$$TranslationStateImplCopyWithImpl<_$TranslationStateImpl>(
          this, _$identity);
}

abstract class _TranslationState implements TranslationState {
  const factory _TranslationState(
      {final bool isLoading,
      final String? translation,
      final String? error}) = _$TranslationStateImpl;

  @override
  bool get isLoading;
  @override
  String? get translation;
  @override
  String? get error;

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationStateImplCopyWith<_$TranslationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
