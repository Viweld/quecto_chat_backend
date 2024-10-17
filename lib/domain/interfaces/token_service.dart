/// Интерфейс сервиса работы с токенами
abstract interface class TokenService {
  /// Генерация access-токена на основе ID пользователя
  String generateAccessToken(String userId);

  /// Генерация refresh-токена на основе ID пользователя
  String generateRefreshToken(String userId);

  /// Валидация токена. В случае успешной валидации возвращает ID пользователя
  String validateToken(String token);
}
