import 'dart:io';

import 'package:postgres/postgres.dart';

import '../../domain/entities/paginated.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/entities/user/user_sort_type.dart';
import '../../domain/exceptions/app_exceptions.dart';
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
  /// initializing the connection to the database and creating/migrating tables
  @override
  Future<void> initialize() async {
    // creating SecurityContext
    final securityContext = SecurityContext.defaultContext
      ..setTrustedCertificates(_env.dbSslCertFilePath);

    _connection = await Connection.open(
      Endpoint(
        // endpoint of the database
        host: _env.dbHost,
        // database name
        database: _env.dbName,
        // username
        username: _env.dbUsername,
        // password
        password: _env.dbPassword,
        // Specify this if you are not using Unix socket.
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
  Future<void> addUser({
    required String fullName,
    required DateTime createdAt,
    required String email,
    required String password,
    required String verificationCode,
  }) async {
    // Check for existence of user with same email
    final existingUser = await _connection.execute(
      'SELECT id FROM public."${_Keys._tUsers}" '
      'WHERE email = $email',
    );

    if (existingUser.isNotEmpty) throw const EmailAlreadyUsed();

    await _connection.insert(
      tableName: _Keys._tUsers,
      data: _Mapper._mapUser(
        fullName: fullName,
        createdAt: createdAt,
        email: email,
        password: password,
        verificationCode: verificationCode,
        verificationCodeSentAt: DateTime.now().millisecondsSinceEpoch,
        isVerified: false,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  @override
  Future<User> getUserById(String userId) {
    // TODO(Vadim): #unimplemented getUserById
    throw UnimplementedError();
  }

  // ---------------------------------------------------------------------------
  @override
  Future<User?> getUserByEmail(String email) async {
    final result = await _connection.query(
      tableKey: _Keys._tUsers,
      where: 'email = $email',
    );

    return result.isEmpty ? null : _Mapper._parseUser(result.first);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<void> updateUser(User user) {
    // TODO(Vadim): #unimplemented updateUser
    throw UnimplementedError();
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
