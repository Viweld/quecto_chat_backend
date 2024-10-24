final class User {
  const User({
    required this.id,
    required this.fullName,
    required this.createdAt,
    required this.email,
    required this.password,
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
}
