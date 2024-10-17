import '../entities/user.dart';

/// Интерфейс сервиса работы с токенами
abstract interface class UserRepository {
  /// Ищет пользователя по его email
  Future<User?> findUserByEmail(String email);
}
