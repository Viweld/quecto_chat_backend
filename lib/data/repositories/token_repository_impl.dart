import 'dart:collection';

import '../../core/interfaces/data_base.dart';
import '../../core/interfaces/token_repository.dart';
import '../../domain/value_objects/token/token.dart';

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl(this._database);

  final DataBase _database;

  // Blacklist for access tokens, sorted by token expiration time
  final SplayTreeMap<int, List<Token>> _accessTokenBlacklist = SplayTreeMap();

  @override
  void addAccessTokenToBlacklist(Token token) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Removing expired tokens from the beginning of the tree
    while (_accessTokenBlacklist.isNotEmpty &&
        _accessTokenBlacklist.firstKey()! <= now) {
      _accessTokenBlacklist.remove(_accessTokenBlacklist.firstKey());
    }

    // Adding a token to the blacklist
    final expirationTime = token.expirationTime;
    if (_accessTokenBlacklist.containsKey(expirationTime)) {
      _accessTokenBlacklist[expirationTime]!.add(token);
    } else {
      _accessTokenBlacklist[expirationTime] = [token];
    }
  }

  @override
  bool isAccessTokenInBlacklist(Token token) => _accessTokenBlacklist.values
      .any((tokens) => tokens.any((t) => t.value == token.value));

  @override
  Future<void> addRefreshTokenToWhitelist(Token token) =>
      _database.addRefreshTokenToWhitelist(token);

  @override
  Future<void> removeRefreshTokenFromWhitelist(Token token) =>
      _database.removeRefreshTokenFromWhitelist(token);

  @override
  Future<bool> isRefreshTokenInWhitelist(Token token) =>
      _database.isRefreshTokenInWhitelist(token);
}
