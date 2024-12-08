base class UserTokenRefreshOutput {
  const UserTokenRefreshOutput({
    required this.access,
    required this.refresh,
  });

  /// access-token
  final String access;

  /// refresh-token
  final String refresh;
}
