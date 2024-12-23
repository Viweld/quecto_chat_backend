abstract interface class EnvParameters {
  // DATABASE CONFIGURATIONS:
  // ---------------------------------------------------------------------------
  String get dbHost;

  String get dbName;

  String get dbUser;

  String get dbPassword;

  String get dbSslCertFilePath;

  // MAIL SENDER CONFIGURATIONS:
  // ---------------------------------------------------------------------------
  String get sendGridApiKey;

  String get sendGridUrl;

  // JWT SERVICE CONFIGURATIONS:
  // ---------------------------------------------------------------------------
  String get jwtSecretKey;

  Duration get jwtAccessTokenDuration;

  Duration get jwtRefreshTokenDuration;
}
