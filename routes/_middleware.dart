import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/data/repositories/user_repository_impl.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
import 'package:quecto_chat_backend/domain/interfaces/user_repository.dart';
import 'package:quecto_chat_backend/services/jwt_service.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(_verifyTokenHandler)
      .use(_dependencyInjection);
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// ПРОВЕРКА ТОКЕНА:
/// Список публичных эндпоинтов:
const _publicEndpoints = [
  'user/auth/login',
  'user/auth/token/refresh',
];

/// Список приватных эндпоинтов:
const _privateEndpoints = [];

/// Проверяет наличие и валидность токенов в запросах
Handler _verifyTokenHandler(Handler handler) {
  return (context) async {
    // 1. Проверяем эндпоинт:
    final url = context.request.url.toString();
    // 1.1. Если запрос - публичный, выполняем его:
    final isFreeAccess = _publicEndpoints.contains(url);
    if (isFreeAccess) return _continueProcessing(handler, context);
    // 1.2. Если запрос - приватный, то отвечам 404
    final isPrivateAccess = _privateEndpoints.contains(url);
    if (!isPrivateAccess) return ResponseHelper.notFound();

    // 2. Проверяем наличие токена в хэдерах:
    final authHeader = context.request.headers['Authorization'];
    final token = _getTokenFromAuthHeader(authHeader);
    if (token == null) {
      return ResponseHelper.unAuthorized(detail: 'No token provided');
    }

    // 3. Проверяем вадидность токена:
    try {
      final jwtService = JwtService();
      final userId = jwtService.validateToken(token);
      final updatedContext = context.provide<String>(() => userId);
      return await _continueProcessing(handler, updatedContext);
    } catch (e) {
      // Если токен невалиден или возникла ошибка валидации
      return ResponseHelper.unAuthorized(detail: 'Invalid or expired token');
    }
  };
}

/// Возвращает токен из хэдера, либо null если это не удается сделать или данный хэдер пуст
String? _getTokenFromAuthHeader(String? authHeader) {
  if (authHeader == null) return null;
  if (authHeader.contains('Bearer ')) return null;
  final token = authHeader.substring(7);
  if (token.isEmpty) return null;
  return token;
}

/// Продолжает выполнение поступившего запроса
Future<Response> _continueProcessing(
  Handler handler,
  RequestContext context,
) async {
  try {
    return await handler(context);
  } catch (error) {
    return ResponseHelper.badRequest(
      detail: 'Bad Request ($error)',
    );
  }
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// ПРОБРОС ЗАВИСИМОСТЕЙ:
// Взаимосвязанные зависимости должны быть расположены снизу вверх.
// Если B зависит от A, тогда:
//   handler
//     .use(B())
//     .use(A());
Handler _dependencyInjection(Handler handler) {
  return handler.use(userRepositoryProvider());
}

// -----------------------------------------------------------------------------
final UserRepository _userRepository = UserRepositoryImpl();

/// Провайдер для UserRepository
Middleware userRepositoryProvider() {
  return provider<UserRepository>((_) => _userRepository);
}
// -----------------------------------------------------------------------------
