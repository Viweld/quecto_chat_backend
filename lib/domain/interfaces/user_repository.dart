import '../entities/paginated.dart';
import '../entities/user.dart';
import '../entities/user_sort_type.dart';

/// Interface for user repository
abstract interface class UserRepository {
  /// Add a new user record
  Future<void> addUser(User user);

  /// Update user data
  Future<void> updateUser(User user);

  /// Get user data by E-mail
  Future<User?> getUserByEmail(String email);

  /// Get a list of users
  Future<Paginated<User>> getUsers({
    String? search,
    UserSortType? orderBy,
    int? limit,
    int? offset,
  });
}
