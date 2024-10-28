import 'package:dart_frog/dart_frog.dart';

import '../../data/data_base/postgres_data_base.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../parameters/dot_env_parameters.dart';
import '../../services/jwt_service.dart';
import '../../services/send_grid_mail_sender_service.dart';
import '../interfaces/data_base.dart';
import '../interfaces/env_parameters.dart';
import '../interfaces/mail_sender_service.dart';
import '../interfaces/token_service.dart';
import '../interfaces/user_repository.dart';
import '../use_cases/user/user_login.dart';
import '../use_cases/user/user_registration.dart';

final class DepProvider {
  DepProvider();

  // Permanent dependencies:
  late EnvParameters _envParameters;
  late TokenService _tokenService;
  late MailSenderService _mailSenderService;
  late DataBase _dataBase;

  // Lazy-load dependencies:
  UserRepository? _userRepository;

  // MAIN METHODS:
  // ---------------------------------------------------------------------------
  /// Initializing persistent and asynchronously initialized dependencies
  Future<void> initialize() async {
    _envParameters = DotEnvParameters();
    _tokenService = JwtService();
    _mailSenderService = SendGridMailSenderService(_envParameters);
    _dataBase = await _prepareDataBase(_envParameters);
  }

  /// provide dependencies
  Handler injectDependencies(Handler handler) {
    return handler
        .use(_prepareUserLoginUseCase())
        .use(_prepareUserRegistrationUseCase())
        .use(_provideUserRepository())
        .use(_provideDataBase())
        .use(_provideMailSenderService())
        .use(_provideTokenService())
        .use(_provideDotEnv());
  }

  // HANDLER METHODS:
  // ---------------------------------------------------------------------------
  /// Prepare of DataBase
  Future<DataBase> _prepareDataBase(EnvParameters dotEnv) async {
    final dataBase = PostgresDataBase(dotEnv);
    await dataBase.initialize();
    return dataBase;
  }

  // PROVIDE METHODS:
  // ---------------------------------------------------------------------------
  /// Provide of EnvParameters
  Middleware _provideDotEnv() {
    return provider<EnvParameters>((_) => _envParameters);
  }

  /// Provide of TokenService
  Middleware _provideTokenService() {
    return provider<TokenService>((_) => _tokenService);
  }

  /// Provide of MailSenderService
  Middleware _provideMailSenderService() {
    return provider<MailSenderService>((_) => _mailSenderService);
  }

  /// Provide of the DataBase
  Middleware _provideDataBase() {
    return provider<DataBase>((_) => _dataBase);
  }

  /// Lazy-load provide of the UserRepository
  Middleware _provideUserRepository() {
    return provider<UserRepository>((_) {
      return _userRepository ??= UserRepositoryImpl(dataBase: _dataBase);
    });
  }

  /// Factory provide UserRegistrationUseCase
  Middleware _prepareUserRegistrationUseCase() {
    return provider<UserRegistration>((context) {
      final userRepository = context.read<UserRepository>();

      return UserRegistration(userRepository, _mailSenderService);
    });
  }

  /// Factory provide UserRegistrationUseCase
  Middleware _prepareUserLoginUseCase() {
    return provider<UserLogin>((context) {
      final userRepository = context.read<UserRepository>();

      return UserLogin(userRepository, _tokenService);
    });
  }
}
