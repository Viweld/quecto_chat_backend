import 'package:collection/collection.dart';

import '../../domain/entities/paginated.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/entities/user/user_sort_type.dart';
import '../../domain/interfaces/data_base.dart';
import '../../domain/interfaces/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.dataBase});

  final DataBase dataBase;

  @override
  Future<void> addUser(User user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(int userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  // ---------------------------------------------------------------------------
  @override
  Future<Paginated<User>> getUsers({
    String? search,
    UserSortType? orderBy,
    int? limit,
    int? offset,
  }) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
