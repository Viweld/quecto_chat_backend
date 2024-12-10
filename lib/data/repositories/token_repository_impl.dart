import 'dart:collection';

import '../../core/interfaces/data_base.dart';
import '../../core/interfaces/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl({required DataBase database}) : _database = database;

  final DataBase _database;

  /// Blacklist для access-токенов
  /// Ключ: timestamp, Значение: access-токен
  final SplayTreeMap<int, String> _accessTokenBlacklist = SplayTreeMap();

  /// Текущее время в миллисекундах
  int _currentTimestamp() => DateTime.now().millisecondsSinceEpoch;

  /// Удаляет токены с истёкшим сроком из blacklist
  void _cleanupExpiredTokens() {
    final now = _currentTimestamp();
    final expiredKeys = _accessTokenBlacklist.keys
        .takeWhile((timestamp) => timestamp < now)
        .toList();
    for (final key in expiredKeys) {
      _accessTokenBlacklist.remove(key);
    }
  }

  @override
  void addAccessTokenToBlacklist(String token) {
    // remove expired tokens
    _cleanupExpiredTokens();
    // add token to blacklist
    _accessTokenBlacklist[_currentTimestamp()] = token;
  }

  @override
  bool isAccessTokenInBlacklist(String token) =>
      _accessTokenBlacklist.containsValue(token);

  @override
  Future<void> addRefreshTokenToWhitelist(String token) =>
      _database.addRefreshTokenToWhitelist(token);

  @override
  Future<void> removeRefreshTokenFromWhitelist(String token) =>
      _database.removeRefreshTokenFromWhitelist(token);

  @override
  Future<bool> isRefreshTokenInWhitelist(String token) =>
      _database.isRefreshTokenInWhitelist(token);
}
