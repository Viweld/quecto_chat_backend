import 'package:collection/collection.dart';

import '../../domain/entities/user.dart';
import '../../domain/interfaces/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl() {
    print('СОЗДАЛСЯ РЕПОЗИТОРИЙ ПОЛЬЗОВАТЕЛЯ');
  }

  final users = <User>[
    User('1', 'john@example.com', 'password123'),
  ];

  @override
  Future<User?> findUserByEmail(String email) async {
    return users.firstWhereOrNull((user) => user.email == email);
  }
}