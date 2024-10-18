import 'dart:async';
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
import 'package:quecto_chat_backend/domain/interfaces/user_repository.dart';
import 'package:quecto_chat_backend/domain/use_cases/user/authenticate_user.dart';
import 'package:quecto_chat_backend/services/jwt_service.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.post:
      return _post(context);
    default:
      return ResponseHelper.methodNotAllowed();
  }
}

/// POST:
FutureOr<Response> _post(RequestContext context) async {
  final requestBody = await context.request.body();
  final data = jsonDecode(requestBody);

  final email = data['email'];
  final password = data['password'];

  final userRepository = context.read<UserRepository>();
  final jwtService = JwtService();
  final authenticateUser = AuthenticateUser(userRepository, jwtService);

  try {
    final tokens = await authenticateUser(email, password);
    return ResponseHelper.success(body: tokens);
  } catch (e) {
    return ResponseHelper.unAuthorized(detail: 'error: $e');
  }
}
