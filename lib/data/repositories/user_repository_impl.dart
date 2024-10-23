import 'package:collection/collection.dart';

import '../../domain/entities/user/user.dart';
import '../../domain/interfaces/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl() {
    print('СОЗДАЛСЯ РЕПОЗИТОРИЙ ПОЛЬЗОВАТЕЛЯ');

    users = <User>[
      User(
        id: '1',
        email: 'john@example.com',
        password: 'password123',
        fullName: 'we',
        createdAt: DateTime.now(),
      ),
    ];
  }

  late List<User> users;

  @override
  Future<User?> findUserByEmail(String email) async {
    return users.firstWhereOrNull((user) => user.email == email);
  }
}
