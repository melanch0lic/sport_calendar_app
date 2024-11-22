// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_navigation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BottomNavigationEvent {
  int get newIndex => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int newIndex) changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int newIndex)? changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int newIndex)? changed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PageChanged value) changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PageChanged value)? changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PageChanged value)? changed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of BottomNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BottomNavigationEventCopyWith<BottomNavigationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BottomNavigationEventCopyWith<$Res> {
  factory $BottomNavigationEventCopyWith(BottomNavigationEvent value,
          $Res Function(BottomNavigationEvent) then) =
      _$BottomNavigationEventCopyWithImpl<$Res, BottomNavigationEvent>;
  @useResult
  $Res call({int newIndex});
}

/// @nodoc
class _$BottomNavigationEventCopyWithImpl<$Res,
        $Val extends BottomNavigationEvent>
    implements $BottomNavigationEventCopyWith<$Res> {
  _$BottomNavigationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BottomNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newIndex = null,
  }) {
    return _then(_value.copyWith(
      newIndex: null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PageChangedImplCopyWith<$Res>
    implements $BottomNavigationEventCopyWith<$Res> {
  factory _$$PageChangedImplCopyWith(
          _$PageChangedImpl value, $Res Function(_$PageChangedImpl) then) =
      __$$PageChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int newIndex});
}

/// @nodoc
class __$$PageChangedImplCopyWithImpl<$Res>
    extends _$BottomNavigationEventCopyWithImpl<$Res, _$PageChangedImpl>
    implements _$$PageChangedImplCopyWith<$Res> {
  __$$PageChangedImplCopyWithImpl(
      _$PageChangedImpl _value, $Res Function(_$PageChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of BottomNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newIndex = null,
  }) {
    return _then(_$PageChangedImpl(
      null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PageChangedImpl implements _PageChanged {
  const _$PageChangedImpl(this.newIndex);

  @override
  final int newIndex;

  @override
  String toString() {
    return 'BottomNavigationEvent.changed(newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageChangedImpl &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newIndex);

  /// Create a copy of BottomNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageChangedImplCopyWith<_$PageChangedImpl> get copyWith =>
      __$$PageChangedImplCopyWithImpl<_$PageChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int newIndex) changed,
  }) {
    return changed(newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int newIndex)? changed,
  }) {
    return changed?.call(newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int newIndex)? changed,
    required TResult orElse(),
  }) {
    if (changed != null) {
      return changed(newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PageChanged value) changed,
  }) {
    return changed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PageChanged value)? changed,
  }) {
    return changed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PageChanged value)? changed,
    required TResult orElse(),
  }) {
    if (changed != null) {
      return changed(this);
    }
    return orElse();
  }
}

abstract class _PageChanged implements BottomNavigationEvent {
  const factory _PageChanged(final int newIndex) = _$PageChangedImpl;

  @override
  int get newIndex;

  /// Create a copy of BottomNavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageChangedImplCopyWith<_$PageChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BottomNavigationState {
  int get currentPageIndex => throw _privateConstructorUsedError;

  /// Create a copy of BottomNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BottomNavigationStateCopyWith<BottomNavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BottomNavigationStateCopyWith<$Res> {
  factory $BottomNavigationStateCopyWith(BottomNavigationState value,
          $Res Function(BottomNavigationState) then) =
      _$BottomNavigationStateCopyWithImpl<$Res, BottomNavigationState>;
  @useResult
  $Res call({int currentPageIndex});
}

/// @nodoc
class _$BottomNavigationStateCopyWithImpl<$Res,
        $Val extends BottomNavigationState>
    implements $BottomNavigationStateCopyWith<$Res> {
  _$BottomNavigationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BottomNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPageIndex = null,
  }) {
    return _then(_value.copyWith(
      currentPageIndex: null == currentPageIndex
          ? _value.currentPageIndex
          : currentPageIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BottomNavigationStateImplCopyWith<$Res>
    implements $BottomNavigationStateCopyWith<$Res> {
  factory _$$BottomNavigationStateImplCopyWith(
          _$BottomNavigationStateImpl value,
          $Res Function(_$BottomNavigationStateImpl) then) =
      __$$BottomNavigationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentPageIndex});
}

/// @nodoc
class __$$BottomNavigationStateImplCopyWithImpl<$Res>
    extends _$BottomNavigationStateCopyWithImpl<$Res,
        _$BottomNavigationStateImpl>
    implements _$$BottomNavigationStateImplCopyWith<$Res> {
  __$$BottomNavigationStateImplCopyWithImpl(_$BottomNavigationStateImpl _value,
      $Res Function(_$BottomNavigationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BottomNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPageIndex = null,
  }) {
    return _then(_$BottomNavigationStateImpl(
      currentPageIndex: null == currentPageIndex
          ? _value.currentPageIndex
          : currentPageIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BottomNavigationStateImpl implements _BottomNavigationState {
  const _$BottomNavigationStateImpl({this.currentPageIndex = 0});

  @override
  @JsonKey()
  final int currentPageIndex;

  @override
  String toString() {
    return 'BottomNavigationState(currentPageIndex: $currentPageIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BottomNavigationStateImpl &&
            (identical(other.currentPageIndex, currentPageIndex) ||
                other.currentPageIndex == currentPageIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentPageIndex);

  /// Create a copy of BottomNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BottomNavigationStateImplCopyWith<_$BottomNavigationStateImpl>
      get copyWith => __$$BottomNavigationStateImplCopyWithImpl<
          _$BottomNavigationStateImpl>(this, _$identity);
}

abstract class _BottomNavigationState implements BottomNavigationState {
  const factory _BottomNavigationState({final int currentPageIndex}) =
      _$BottomNavigationStateImpl;

  @override
  int get currentPageIndex;

  /// Create a copy of BottomNavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BottomNavigationStateImplCopyWith<_$BottomNavigationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
