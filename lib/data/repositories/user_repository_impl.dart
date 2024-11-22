import '../../domain/entities/paginated.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/entities/user/user_sort_type.dart';
import '../../domain/interfaces/data_base.dart';
import '../../domain/interfaces/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.dataBase});

  final DataBase dataBase;

  // ---------------------------------------------------------------------------
  @override
  Future<void> addUser({
    required String fullName,
    required DateTime createdAt,
    required String email,
    required String password,
    required String verificationCode,
  }) =>
      dataBase.addUser(
        fullName: fullName,
        createdAt: createdAt,
        email: email,
        password: password,
        verificationCode: verificationCode,
      );

  // ---------------------------------------------------------------------------
  @override
  Future<User> getUserById(String userId) => dataBase.getUserById(userId);

  // ---------------------------------------------------------------------------
  @override
  Future<User?> getUserByEmail(String email) => dataBase.getUserByEmail(email);

  // ---------------------------------------------------------------------------
  @override
  Future<void> updateUser(User user) => dataBase.updateUser(user);

  // ---------------------------------------------------------------------------
  @override
  Future<Paginated<User>> getUsers({
    String? search,
    UserSortType? orderBy,
    int? limit,
    int? offset,
  }) =>
      dataBase.getUsers(
        search: search,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
}
