import '../entities/paginated.dart';
import '../entities/user/user.dart';
import '../entities/user/user_sort_type.dart';

/// Interface for database
abstract interface class DataBase {
  /// Initialize the database
  Future<void> initialize();

  /// Save a user to the database
  Future<void> addUser(User user);

  /// Update user data in the database
  Future<void> updateUser(User user);

  /// Get user data from the database
  Future<User> getUser(int userId);

  /// Get a list of all users from the database
  Future<Paginated<User>> getUsers({
    String? search,
    UserSortType? orderBy,
    int? limit,
    int? offset,
  });
}
