import '../../core/interfaces/data_base.dart';
import '../../core/interfaces/user_repository.dart';
import '../../domain/entities/paginated.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_sort_type.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.dataBase});

  final DataBase dataBase;

  // ---------------------------------------------------------------------------
  @override
  Future<void> addUser(User user) => dataBase.addUser(user);

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
