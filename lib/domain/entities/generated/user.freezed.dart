// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$User {
  /// Unique user identifier. Empty by default.
  String get id => throw _privateConstructorUsedError;

  /// User's full name.
  String get fullName => throw _privateConstructorUsedError;

  /// User creation date and time.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// User's email.
  String get email => throw _privateConstructorUsedError;

  /// User's password.
  String get password => throw _privateConstructorUsedError;

  /// Temporarily verification code
  String? get verificationCode => throw _privateConstructorUsedError;

  /// Temporarily verification code sending timestamp
  int? get verificationCodeSentAt => throw _privateConstructorUsedError;

  /// User's account verification state
  bool get isVerified => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String fullName,
      DateTime createdAt,
      String email,
      String password,
      String? verificationCode,
      int? verificationCodeSentAt,
      bool isVerified});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? createdAt = null,
    Object? email = null,
    Object? password = null,
    Object? verificationCode = freezed,
    Object? verificationCodeSentAt = freezed,
    Object? isVerified = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      verificationCode: freezed == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationCodeSentAt: freezed == verificationCodeSentAt
          ? _value.verificationCodeSentAt
          : verificationCodeSentAt // ignore: cast_nullable_to_non_nullable
              as int?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String fullName,
      DateTime createdAt,
      String email,
      String password,
      String? verificationCode,
      int? verificationCodeSentAt,
      bool isVerified});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? createdAt = null,
    Object? email = null,
    Object? password = null,
    Object? verificationCode = freezed,
    Object? verificationCodeSentAt = freezed,
    Object? isVerified = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      verificationCode: freezed == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationCodeSentAt: freezed == verificationCodeSentAt
          ? _value.verificationCodeSentAt
          : verificationCodeSentAt // ignore: cast_nullable_to_non_nullable
              as int?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UserImpl implements _User {
  const _$UserImpl(
      {this.id = '',
      required this.fullName,
      required this.createdAt,
      required this.email,
      required this.password,
      this.verificationCode,
      this.verificationCodeSentAt,
      required this.isVerified});

  /// Unique user identifier. Empty by default.
  @override
  @JsonKey()
  final String id;

  /// User's full name.
  @override
  final String fullName;

  /// User creation date and time.
  @override
  final DateTime createdAt;

  /// User's email.
  @override
  final String email;

  /// User's password.
  @override
  final String password;

  /// Temporarily verification code
  @override
  final String? verificationCode;

  /// Temporarily verification code sending timestamp
  @override
  final int? verificationCodeSentAt;

  /// User's account verification state
  @override
  final bool isVerified;

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, createdAt: $createdAt, email: $email, password: $password, verificationCode: $verificationCode, verificationCodeSentAt: $verificationCodeSentAt, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.verificationCode, verificationCode) ||
                other.verificationCode == verificationCode) &&
            (identical(other.verificationCodeSentAt, verificationCodeSentAt) ||
                other.verificationCodeSentAt == verificationCodeSentAt) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, fullName, createdAt, email,
      password, verificationCode, verificationCodeSentAt, isVerified);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);
}

abstract class _User implements User {
  const factory _User(
      {final String id,
      required final String fullName,
      required final DateTime createdAt,
      required final String email,
      required final String password,
      final String? verificationCode,
      final int? verificationCodeSentAt,
      required final bool isVerified}) = _$UserImpl;

  /// Unique user identifier. Empty by default.
  @override
  String get id;

  /// User's full name.
  @override
  String get fullName;

  /// User creation date and time.
  @override
  DateTime get createdAt;

  /// User's email.
  @override
  String get email;

  /// User's password.
  @override
  String get password;

  /// Temporarily verification code
  @override
  String? get verificationCode;

  /// Temporarily verification code sending timestamp
  @override
  int? get verificationCodeSentAt;

  /// User's account verification state
  @override
  bool get isVerified;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
