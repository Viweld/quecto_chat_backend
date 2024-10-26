import '../entities/paginated.dart';
import '../entities/user/user.dart';
import '../entities/user/user_sort_type.dart';

/// Interface for user repository
abstract interface class UserRepository {
  /// Save a user
  Future<void> addUser({
    required String fullName,
    required DateTime createdAt,
    required String email,
    required String password,
  });

  /// Update user data
  Future<void> updateUser(User user);

  /// Get user data by ID
  Future<User> getUserById(String userId);

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
