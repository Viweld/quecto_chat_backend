import '../entities/paginated.dart';
import '../entities/user/user.dart';
import '../entities/user/user_sort_type.dart';

abstract interface class DataBase {
  /// Инициализация БД
  Future<void> initialize();

  /// Сохранить пользователя в БД
  Future<void> addUser(User user);

  /// Обновить даные пользователя в БД
  Future<void> updateUser(User user);

  /// Получить данные пользователя из БД
  Future<User> getUser(int userId);

  /// Получить список всех пользователей из БД
  Future<Paginated<User>> getUsers({
    String? search,
    UserSortType? orderBy,
    int? limit,
    int? offset,
  });
}
