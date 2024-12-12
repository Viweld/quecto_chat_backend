// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../user_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserSession {
  /// Unique session identifier. Empty by default.
  String get id => throw _privateConstructorUsedError;

  /// User ID (session owner)
  String get userId => throw _privateConstructorUsedError;

  /// Refresh-token
  String get refreshToken => throw _privateConstructorUsedError;

  /// expiration time in seconds since epoch
  int get expirationTime => throw _privateConstructorUsedError;

  /// Session name (optional)
  String? get sessionName => throw _privateConstructorUsedError;

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSessionCopyWith<UserSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSessionCopyWith<$Res> {
  factory $UserSessionCopyWith(
          UserSession value, $Res Function(UserSession) then) =
      _$UserSessionCopyWithImpl<$Res, UserSession>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String refreshToken,
      int expirationTime,
      String? sessionName});
}

/// @nodoc
class _$UserSessionCopyWithImpl<$Res, $Val extends UserSession>
    implements $UserSessionCopyWith<$Res> {
  _$UserSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? refreshToken = null,
    Object? expirationTime = null,
    Object? sessionName = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expirationTime: null == expirationTime
          ? _value.expirationTime
          : expirationTime // ignore: cast_nullable_to_non_nullable
              as int,
      sessionName: freezed == sessionName
          ? _value.sessionName
          : sessionName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSessionImplCopyWith<$Res>
    implements $UserSessionCopyWith<$Res> {
  factory _$$UserSessionImplCopyWith(
          _$UserSessionImpl value, $Res Function(_$UserSessionImpl) then) =
      __$$UserSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String refreshToken,
      int expirationTime,
      String? sessionName});
}

/// @nodoc
class __$$UserSessionImplCopyWithImpl<$Res>
    extends _$UserSessionCopyWithImpl<$Res, _$UserSessionImpl>
    implements _$$UserSessionImplCopyWith<$Res> {
  __$$UserSessionImplCopyWithImpl(
      _$UserSessionImpl _value, $Res Function(_$UserSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? refreshToken = null,
    Object? expirationTime = null,
    Object? sessionName = freezed,
  }) {
    return _then(_$UserSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expirationTime: null == expirationTime
          ? _value.expirationTime
          : expirationTime // ignore: cast_nullable_to_non_nullable
              as int,
      sessionName: freezed == sessionName
          ? _value.sessionName
          : sessionName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UserSessionImpl implements _UserSession {
  const _$UserSessionImpl(
      {this.id = '',
      required this.userId,
      required this.refreshToken,
      required this.expirationTime,
      this.sessionName});

  /// Unique session identifier. Empty by default.
  @override
  @JsonKey()
  final String id;

  /// User ID (session owner)
  @override
  final String userId;

  /// Refresh-token
  @override
  final String refreshToken;

  /// expiration time in seconds since epoch
  @override
  final int expirationTime;

  /// Session name (optional)
  @override
  final String? sessionName;

  @override
  String toString() {
    return 'UserSession(id: $id, userId: $userId, refreshToken: $refreshToken, expirationTime: $expirationTime, sessionName: $sessionName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expirationTime, expirationTime) ||
                other.expirationTime == expirationTime) &&
            (identical(other.sessionName, sessionName) ||
                other.sessionName == sessionName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, refreshToken, expirationTime, sessionName);

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSessionImplCopyWith<_$UserSessionImpl> get copyWith =>
      __$$UserSessionImplCopyWithImpl<_$UserSessionImpl>(this, _$identity);
}

abstract class _UserSession implements UserSession {
  const factory _UserSession(
      {final String id,
      required final String userId,
      required final String refreshToken,
      required final int expirationTime,
      final String? sessionName}) = _$UserSessionImpl;

  /// Unique session identifier. Empty by default.
  @override
  String get id;

  /// User ID (session owner)
  @override
  String get userId;

  /// Refresh-token
  @override
  String get refreshToken;

  /// expiration time in seconds since epoch
  @override
  int get expirationTime;

  /// Session name (optional)
  @override
  String? get sessionName;

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSessionImplCopyWith<_$UserSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
