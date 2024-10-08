import 'dart:async';
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
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

  final refreshToken = data['refresh'];
  final jwtService = JwtService();

  try {
    final userId = jwtService.validateToken(refreshToken);
    final newAccessToken = jwtService.generateAccessToken(userId);

    return ResponseHelper.success(body: {'access': newAccessToken});
  } catch (e) {
    return ResponseHelper.unAuthorized(detail: 'Invalid refresh token');
  }
}
