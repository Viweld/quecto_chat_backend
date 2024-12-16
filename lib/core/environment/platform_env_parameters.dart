import 'dart:io';

import '../interfaces/env_parameters.dart';

final class PlatformEnvParameters implements EnvParameters {
  PlatformEnvParameters();

  final Map<String, String> _env = Platform.environment;

  // ---------------------------------------------------------------------------
  @override
  String get dbHost => _env['DB_HOST'] ?? '';

  @override
  String get dbName => _env['DB_NAME'] ?? '';

  @override
  String get dbUser => _env['DB_USER'] ?? '';

  @override
  String get dbPassword => _env['DB_PASSWORD'] ?? '';

  @override
  String get dbSslCertFilePath => _env['AWS_DB_SSL_CERTIFICATE_PATH'] ?? '';

  // ---------------------------------------------------------------------------
  @override
  String get sendGridApiKey => _env['SEND_GRID_API_KEY'] ?? '';

  @override
  String get sendGridUrl => _env['SEND_GRID_URL'] ?? '';

  // ---------------------------------------------------------------------------
  @override
  String get jwtSecretKey => _env['JWT_SECRET_KEY'] ?? '';

  @override
  Duration get jwtAccessTokenDuration =>
      Duration(minutes: int.parse(_env['JWT_ACCESS_TOKEN_DURATION'] ?? '15'));

  @override
  Duration get jwtRefreshTokenDuration => Duration(
      minutes: int.parse(_env['JWT_REFRESH_TOKEN_DURATION'] ?? '10080'));
}
