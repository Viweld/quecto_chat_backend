import 'dart:async';
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
import 'package:quecto_chat_backend/domain/interfaces/token_service.dart';

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
  final data = jsonDecode(requestBody) as Map;

  final refreshToken = data['refresh'];
  final jwtService = context.read<TokenService>();

  try {
    final userId = jwtService.validateToken(refreshToken);
    final newAccessToken = jwtService.generateAccessToken(userId);

    return ResponseHelper.success(body: {'access': newAccessToken});
  } on Object {
    return ResponseHelper.unAuthorized(detail: 'Invalid refresh token');
  }
}
