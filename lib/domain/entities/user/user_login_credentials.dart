base class UserLoginCredentials {
  const UserLoginCredentials({
    required this.email,
    required this.password,
  });

  /// User e-mail
  final String email;

  /// Account password
  final String password;
}
