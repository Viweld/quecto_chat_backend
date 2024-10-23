import 'dart:io';

import 'package:postgres/postgres.dart';

import '../../domain/entities/paginated.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/entities/user/user_sort_type.dart';
import '../../domain/extensions/postgres_extension.dart';
import '../../domain/interfaces/data_base.dart';
import '../../domain/interfaces/env_parameters.dart';

part 'mapper.dart';

part 'keys.dart';

part 'migration.dart';

final class PostgresDataBase implements DataBase {
  PostgresDataBase(EnvParameters env) : _env = env;

  final EnvParameters _env;

  late Connection _connection;

  // ---------------------------------------------------------------------------
  /// инициализация соединения с БД и создание/миграция таблиц
  @override
  Future<void> initialize() async {
    // Создание SecurityContext
    final securityContext = SecurityContext.defaultContext
      ..setTrustedCertificates(_env.dbSslCertFilePath);

    _connection = await Connection.open(
      Endpoint(
        // endpoint базы данных
        host: _env.dbHost,
        // Имя базы данных
        database: _env.dbName,
        // Имя пользователя
        username: _env.dbUsername,
        // Пароль
        password: _env.dbPassword,
        // Укажите это, если не используете Unix socket
        isUnixSocket: false,
      ),
      settings: ConnectionSettings(
        sslMode: SslMode.verifyFull,
        onOpen: _Migration._onConnectionCreate,
        securityContext: securityContext,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> addUser(User user) async {
    // Проверка на существование пользователя с таким же email
    final existingUser = await _connection.execute(
      'SELECT id FROM public."${_Keys._tUsers}" '
      'WHERE email = ${user.email}',
    );

    if (existingUser.isNotEmpty) {
      throw Exception('Пользователь с таким email уже существует');
    }

    await _connection.insert(
      tableName: _Keys._tUsers,
      data: _Mapper._mapUser(user),
    );
  }

  // ---------------------------------------------------------------------------
  @override
  Future<Paginated<User>> getUsers({
    String? search,
    UserSortType? orderBy,
    int? limit,
    int? offset,
  }) async {
    final orderQuerySample = _getOrderQuerySample(orderBy);
    final searchQuerySample = _getSearchByUsersNameQuerySample(search);

    try {
      // Выполнение запроса с пагинацией, сортировкой и фильтрацией по имени
      final result = await _connection.query(
        tableKey: _Keys._tUsers,
        where: searchQuerySample,
        orderBy: orderQuerySample,
        limit: limit,
        offset: offset,
      );

      return Paginated<User>(
        result: result.map(_Mapper._parseUser),
        limit: limit,
        offset: offset,
      );
    } on Object catch (e) {
      print('Ошибка при выполнении запроса: $e');
      throw Exception('Ошибка при получении списка пользователей');
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Future<User> getUser(int userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  // ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ:
  // ---------------------------------------------------------------------------
  /// Возвращает фрагмент запроса, отвечающий за сортировку извлекаемых данных
  String? _getOrderQuerySample(UserSortType? orderBy) => switch (orderBy) {
        // Сортировка по имени пользователя в алфавитном порядке (A -> Z).
        UserSortType.fullNameAsc => '${_Keys._fUser$fullName} ASC',

        // Сортировка по имени пользователя в обратном алфавитном порядке (Z -> A).
        UserSortType.fullNameDesc => '${_Keys._fUser$fullName} DESC',

        // Сортировка по дате создания в порядке возрастания (старые записи сначала).
        UserSortType.createdAtAsc => '${_Keys._fUser$createdAt} ASC',

        // Сортировка по дате создания в порядке убывания (новые записи сначала).
        UserSortType.createdAtDesc => '${_Keys._fUser$createdAt} DESC',
        _ => null,
      };

  // ---------------------------------------------------------------------------
  /// Возвращает фрагмент запроса, отвечающий за поиск по fullName
  String? _getSearchByUsersNameQuerySample(String? search) =>
      (search == null || search.isEmpty)
          ? null
          : '${_Keys._fUser$fullName} ILIKE $search';
}
