import 'dart:io';

import 'package:postgres/postgres.dart';

import '../../core/extensions/postgres_extension.dart';
import '../../core/interfaces/data_base.dart';
import '../../core/interfaces/env_parameters.dart';
import '../../domain/entities/paginated.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/entities/user_sort_type.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../../domain/value_objects/token/token.dart';

part 'keys.dart';

part 'mapper.dart';

part 'migration.dart';

final class PostgresDataBase implements DataBase {
  PostgresDataBase(EnvParameters env) : _env = env;

  final EnvParameters _env;

  late Connection _connection;

  // ---------------------------------------------------------------------------
  /// initializing the connection to the database and creating/migrating tables
  @override
  Future<void> initialize() async {
    // creating SecurityContext
    final securityContext = _getSecurityContext(_env.dbSslCertFilePath);

    _connection = await Connection.open(
      Endpoint(
        // endpoint of the database
        host: _env.dbHost,
        // database name
        database: _env.dbName,
        // username
        username: _env.dbUser,
        // password
        password: _env.dbPassword,
        // Specify this if you are not using Unix socket.
        isUnixSocket: false,
      ),
      settings: ConnectionSettings(
        onOpen: _Migration._onConnectionCreate,
        sslMode: securityContext == null ? SslMode.disable : SslMode.verifyFull,
        securityContext: securityContext,
      ),
    );
  }

  /// get security context from cert file
  SecurityContext? _getSecurityContext(String dbSslCertFilePath) {
    if (dbSslCertFilePath.isEmpty) {
      return null;
    } else {
      return SecurityContext.defaultContext
        ..setTrustedCertificates(dbSslCertFilePath);
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> addUser(User user) async {
    // Check for existence of user with same email
    final result = await _connection.get(
      tableName: _Keys._tUsers,
      where: '${_Keys._fUser$email} = \'${user.email}\'',
    );

    if (result.isNotEmpty) throw const EmailAlreadyUsed();

    await _connection.insert(
      tableName: _Keys._tUsers,
      data: _Mapper._mapUser(src: user),
    );
  }

  // ---------------------------------------------------------------------------
  @override
  Future<User?> getUserByEmail(String email) async {
    final result = await _connection.get(
      tableName: _Keys._tUsers,
      where: '${_Keys._fUser$email} = \'$email\'',
    );

    return result.isEmpty ? null : _Mapper._parseUser(result.first);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> updateUser(User user) async {
    await _connection.update(
      tableName: _Keys._tUsers,
      data: _Mapper._mapUser(src: user),
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

    final result = await _connection.get(
      tableName: _Keys._tUsers,
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
  }

  // ---------------------------------------------------------------------------
  @override
  Future<bool> isRefreshTokenInWhitelist(Token token) async {
    final result = await _connection.get(
      tableName: _Keys._tUserSessions,
      where: '${_Keys._fUserSession$refreshToken} = \'${token.value}\'',
    );
    return result.isNotEmpty;
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> addRefreshTokenToWhitelist(Token token) async {
    await _connection.insert(
      tableName: _Keys._tUserSessions,
      data: _Mapper._mapUserSession(
        src: UserSession(
          userId: token.userId,
          refreshToken: token.value,
          expirationTime: token.expirationTime,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> clearUserWhitelist(String userId) async {
    await _connection.delete(
      tableName: _Keys._tUserSessions,
      fieldKey: _Keys._fUserSession$userId,
      matchValue: userId,
    );
  }

  // HELPER METHODS:
  // ---------------------------------------------------------------------------
  /// Returns the query fragment responsible for sorting retrieved data
  String? _getOrderQuerySample(UserSortType? orderBy) => switch (orderBy) {
        // Sorts by username in alphabetical order (A -> Z).
        UserSortType.fullNameAsc => '${_Keys._fUser$fullName} ASC',

        // Sorts by username in reverse alphabetical order (Z -> A).
        UserSortType.fullNameDesc => '${_Keys._fUser$fullName} DESC',

        // Sorts by creation date in ascending order (older records first).
        UserSortType.createdAtAsc => '${_Keys._fUser$createdAt} ASC',

        // Sorts by creation date in descending order (newer records first).
        UserSortType.createdAtDesc => '${_Keys._fUser$createdAt} DESC',
        _ => null,
      };

  // ---------------------------------------------------------------------------
  /// Returns the query fragment responsible for searching by fullName
  String? _getSearchByUsersNameQuerySample(String? search) =>
      (search == null || search.isEmpty)
          ? null
          : '${_Keys._fUser$fullName} ILIKE \'%$search%\'';
}
