final class User {
  const User({
    required this.id,
    required this.fullName,
    required this.createdAt,
    required this.email,
    required this.password,
    required this.verificationCode,
    required this.verificationCodeSentAt,
    required this.isVerified,
  });

  /// Unique user identifier.
  final String id;

  /// User's full name.
  final String fullName;

  /// User creation date and time.
  final DateTime createdAt;

  /// User's email.
  final String email;

  /// User's password.
  final String password;

  /// Temporarily verification code
  final String? verificationCode;

  /// Temporarily verification code sending timestamp
  final int? verificationCodeSentAt;

  /// User's account verification state
  final bool isVerified;
}
