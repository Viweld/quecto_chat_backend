import 'package:dotenv/dotenv.dart';

import '../domain/interfaces/env_parameters.dart';

final class DotEnvParameters implements EnvParameters {
  DotEnvParameters() {
    _env = DotEnv()..load();
  }

  late final DotEnv _env;

  // ---------------------------------------------------------------------------
  @override
  String get dbHost => _env['AWS_DB_ENDPOINT'] ?? '';

  @override
  String get dbName => _env['AWS_DB_NAME'] ?? '';

  @override
  String get dbUsername => _env['AWS_DB_USERNAME'] ?? '';

  @override
  String get dbPassword => _env['AWS_DB_PASSWORD'] ?? '';

  @override
  String get dbSslCertFilePath => _env['AWS_DB_SSL_CERTIFICATE_PATH'] ?? '';

  // ---------------------------------------------------------------------------
  @override
  String get sendGridApiKey => _env['SEND_GRID_API_KEY'] ?? '';

  @override
  String get sendGridUrl => _env['SEND_GRID_URL'] ?? '';
}