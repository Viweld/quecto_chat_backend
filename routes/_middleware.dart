import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
import 'package:quecto_chat_backend/services/jwt_service.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(_verifyTokenHandler);
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// TOKEN VERIFICATION:
/// List of public endpoints:
const _publicEndpoints = [
  'user/auth/login',
  'user/auth/token/refresh',
];

/// List of private endpoints:
const _privateEndpoints = [];

/// Checks for token presence and validity in requests
Handler _verifyTokenHandler(Handler handler) {
  return (context) async {
    // 1. Checking the endpoint:
    final url = context.request.url.toString();
    // 1.1. If the request is public, process it:
    final isFreeAccess = _publicEndpoints.contains(url);
    if (isFreeAccess) return _continueProcessing(handler, context);
    // 1.2. If the request is private, respond with 404
    final isPrivateAccess = _privateEndpoints.contains(url);
    if (!isPrivateAccess) return ResponseHelper.notFound();

    // 2. Check for a token in headers:
    final authHeader = context.request.headers['Authorization'];
    final token = _getTokenFromAuthHeader(authHeader);
    if (token == null) {
      return ResponseHelper.unAuthorized(detail: 'No token provided');
    }

    // 3. Check for token validity:
    try {
      final jwtService = JwtService();
      final userId = jwtService.validateToken(token);
      final updatedContext = context.provide<String>(() => userId);
      return await _continueProcessing(handler, updatedContext);
    } on Object {
      // If the token is invalid or an error occurred during validation
      return ResponseHelper.unAuthorized(detail: 'Invalid or expired token');
    }
  };
}

/// Returns the token from the header, or null if it can't be retrieved or the header is empty
String? _getTokenFromAuthHeader(String? authHeader) {
  if (authHeader == null) return null;
  if (authHeader.contains('Bearer ')) return null;
  final token = authHeader.substring(7);
  if (token.isEmpty) return null;
  return token;
}

/// Continues the execution of the incoming request
Future<Response> _continueProcessing(
  Handler handler,
  RequestContext context,
) async {
  try {
    return await handler(context);
  } on Object catch (e) {
    return ResponseHelper.badRequest(detail: '$e');
  }
}
