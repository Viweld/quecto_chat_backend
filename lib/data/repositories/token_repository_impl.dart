import '../../core/interfaces/data_base.dart';
import '../../core/interfaces/token_repository.dart';
import '../../domain/value_objects/token/token.dart';

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl(this._database);

  final DataBase _database;

  @override
  Future<void> addRefreshTokenToWhitelist(Token token) =>
      _database.addRefreshTokenToWhitelist(token);

  @override
  Future<bool> isRefreshTokenInWhitelist(Token token) =>
      _database.isRefreshTokenInWhitelist(token);

  @override
  Future<void> clearUserWhitelist(String userId) =>
      _database.clearUserWhitelist(userId);
}
