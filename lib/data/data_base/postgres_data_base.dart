import 'dart:io';

import 'package:postgres/postgres.dart';

import '../../domain/entities/user.dart';
import '../../domain/interfaces/data_base.dart';
import '../../domain/interfaces/env_parameters.dart';

part 'mapper.dart';

part 'keys.dart';

part 'migration.dart';

final class PostgresDataBase implements DataBase {
  PostgresDataBase(EnvParameters env) : _env = env;

  final EnvParameters _env;

  late Connection _connection;

  // инициализация соединения с БД и создание/миграция таблиц
  // ---------------------------------------------------------------------------
  @override
  Future<void> initialize() async {
    // Создание SecurityContext
    final securityContext = SecurityContext.defaultContext
      ..setTrustedCertificates(_env.dbSslCertFilePath);

    _connection = await Connection.open(
      Endpoint(
        host: _env.dbHost,
        // endpoint базы данных
        database: _env.dbName,
        // Имя базы данных
        username: _env.dbUsername,
        // Имя пользователя
        password: _env.dbPassword,
        // Пароль
        isUnixSocket: false, // Укажите это, если не используете Unix socket
      ),
      settings: ConnectionSettings(
        sslMode: SslMode.verifyFull,
        onOpen: _Migration._onConnectionCreate,
        securityContext: securityContext,
      ),
    );
  }

  @override
  Future<void> addUser(User user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(int userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
