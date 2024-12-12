import 'package:dart_frog/dart_frog.dart';

import '../../data/data_base/postgres_data_base.dart';
import '../../data/repositories/token_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/jwt_service.dart';
import '../../data/services/send_grid_mail_sender_service.dart';
import '../../domain/use_cases/user/auth/full_logout/user_full_logout.dart';
import '../../domain/use_cases/user/auth/login/user_login.dart';
import '../../domain/use_cases/user/auth/registration/user_registration.dart';
import '../../domain/use_cases/user/auth/registration_validate/user_registration_validate.dart';
import '../../domain/use_cases/user/auth/resend_validation_code/user_resend_validation_code.dart';
import '../../domain/use_cases/user/auth/token_refresh/user_token_refresh.dart';
import '../interfaces/data_base.dart';
import '../interfaces/env_parameters.dart';
import '../interfaces/mail_sender_service.dart';
import '../interfaces/token_manager_facade.dart';
import '../interfaces/user_repository.dart';
import '../service_facades/token_manager_facade_impl.dart';
import 'dot_env_parameters.dart';

final class DepProvider {
  DepProvider();

  // Permanent dependencies:
  late EnvParameters _envParameters;
  late TokenManagerFacade _tokenManagerFacade;
  late MailSenderService _mailSenderService;
  late DataBase _dataBase;

  // Lazy-load dependencies:
  UserRepository? _userRepository;

  // MAIN METHODS:
  // ---------------------------------------------------------------------------
  /// Initializing persistent and asynchronously initialized dependencies
  Future<void> initialize() async {
    _envParameters = DotEnvParameters();
    _mailSenderService = SendGridMailSenderService(_envParameters);
    _dataBase = await _prepareDataBase(_envParameters);
    _tokenManagerFacade = TokenManagerFacadeImpl(
      tokenService: JwtService(_envParameters),
      tokenRepository: TokenRepositoryImpl(_dataBase),
    );
  }

  /// provide dependencies
  Handler injectDependencies(Handler handler) {
    return handler
        .use(_prepareUserLogoutUseCase())
        .use(_prepareUserTokenRefreshUseCase())
        .use(_prepareUserResendValidationCodeUseCase())
        .use(_prepareUserRegistrationValidateUseCase())
        .use(_prepareUserLoginUseCase())
        .use(_prepareUserRegistrationUseCase())
        .use(_provideUserRepository())
        .use(_provideDataBase())
        .use(_provideMailSenderService())
        .use(_provideTokenService())
        .use(_provideDotEnv());
  }

  // HELPER METHODS:
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
    return provider<TokenManagerFacade>((_) => _tokenManagerFacade);
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

      return UserLogin(userRepository, _tokenManagerFacade);
    });
  }

  /// Factory provide UserRegistrationValidate
  Middleware _prepareUserRegistrationValidateUseCase() {
    return provider<UserRegistrationValidate>((context) {
      final userRepository = context.read<UserRepository>();

      return UserRegistrationValidate(userRepository, _tokenManagerFacade);
    });
  }

  /// Factory provide UserResendValidationCode
  Middleware _prepareUserResendValidationCodeUseCase() {
    return provider<UserResendValidationCode>((context) {
      final userRepository = context.read<UserRepository>();

      return UserResendValidationCode(userRepository, _mailSenderService);
    });
  }

  /// Factory provide UserTokenRefresh
  Middleware _prepareUserTokenRefreshUseCase() {
    return provider<UserTokenRefresh>((_) {
      return UserTokenRefresh(_tokenManagerFacade);
    });
  }

  /// Factory provide UserLogout
  Middleware _prepareUserLogoutUseCase() {
    return provider<UserFullLogout>((_) {
      return UserFullLogout(_tokenManagerFacade);
    });
  }
}
