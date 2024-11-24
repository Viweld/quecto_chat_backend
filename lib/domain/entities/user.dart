import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    /// Unique user identifier. Empty by default.
    @Default('') String id,

    /// User's full name.
    required String fullName,

    /// User creation date and time.
    required DateTime createdAt,

    /// User's email.
    required String email,

    /// User's password.
    required String password,

    /// Temporarily verification code
    String? verificationCode,

    /// Temporarily verification code sending timestamp
    int? verificationCodeSentAt,

    /// User's account verification state
    required bool isVerified,
  }) = _User;
}
