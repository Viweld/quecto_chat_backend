import '../entities/paginated.dart';
import '../entities/user/user.dart';
import '../entities/user/user_sort_type.dart';

/// Interface for user repository
abstract interface class UserRepository {
  /// Save a user
  Future<void> addUser(User user);

  /// Update user data
  Future<void> updateUser(User user);

  /// Get user data by ID
  Future<User> getUser(int userId);

  /// Get a list of users
  Future<Paginated<User>> getUsers({
    String? search,
    UserSortType? orderBy,
    int? limit,
    int? offset,
  });
}
