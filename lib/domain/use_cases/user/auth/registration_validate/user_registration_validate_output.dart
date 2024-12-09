base class UserRegistrationValidateOutput {
  const UserRegistrationValidateOutput({
    required this.access,
    required this.refresh,
  });

  /// access-token
  final String access;

  /// refresh-token
  final String refresh;
}
