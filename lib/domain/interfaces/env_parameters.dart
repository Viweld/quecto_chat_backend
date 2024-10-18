abstract interface class EnvParameters {
  // Конфигурация базы данных:
  // ---------------------------------------------------------------------------
  String get dbHost;

  String get dbName;

  String get dbUsername;

  String get dbPassword;

  String get dbSslCertFilePath;
// ---------------------------------------------------------------------------
}
