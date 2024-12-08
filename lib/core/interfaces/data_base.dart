import '../../domain/entities/paginated.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_sort_type.dart';

/// Interface for database
abstract interface class DataBase {
  /// Initialize the database
  Future<void> initialize();

  /// Save a user to the database
  Future<void> addUser(User user);

  /// Get user data from the database using E-mail
  Future<User?> getUserByEmail(String email);

  /// Update user data in the database
  Future<void> updateUser(User user);

  /// Get a list of all users from the database
  Future<Paginated<User>> getUsers({
    String? search,
    UserSortType? orderBy,
    int? limit,
    int? offset,
  });
}
