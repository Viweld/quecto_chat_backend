abstract interface class EnvParameters {
  // DATABASE CONFIGURATIONS:
  // ---------------------------------------------------------------------------
  String get dbHost;

  String get dbName;

  String get dbUsername;

  String get dbPassword;

  String get dbSslCertFilePath;

  // MAIL SENDER CONFIGURATIONS:
  // ---------------------------------------------------------------------------
  String get sendGridApiKey;

  String get sendGridUrl;
}
