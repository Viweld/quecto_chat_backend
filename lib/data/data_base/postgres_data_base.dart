import 'dart:io';

import 'package:postgres/postgres.dart';

import '../../domain/entities/user.dart';
import '../../domain/interfaces/data_base.dart';

part 'mapper.dart';

part 'keys.dart';

part 'migration.dart';

final class PostgresDataBase implements DataBase {
  PostgresDataBase();

  static const _dbHost =
      'qdbinstanceid.cniiu0gsasdv.eu-north-1.rds.amazonaws.com';
  static const _dbName = 'qdbname';
  static const _dbUsername = 'qdbusername';
  static const _dbPassword = 'xHB6pPc4NYn6Jzf';
  static const _sslCertFilePath = 'assets/certificates/eu-north-1-bundle.pem';

  late Connection _connection;

  @override
  Future<void> initialize() async {
    // Создание SecurityContext
    final securityContext = SecurityContext.defaultContext
      ..setTrustedCertificates(_sslCertFilePath);

    _connection = await Connection.open(
      Endpoint(
        host: _dbHost,
        // endpoint базы данных
        database: _dbName,
        // Имя базы данных
        username: _dbUsername,
        // Имя пользователя
        password: _dbPassword,
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
