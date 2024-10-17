final class User {
  const User({
    required this.id,
    required this.fullName,
    required this.createdAt,
    required this.email,
    required this.password,
  });

  final String id;
  final String fullName;
  final DateTime createdAt;
  final String email;
  final String password;
}
