import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:intl/intl.dart';
import 'package:quecto_chat_backend/core/extensions/context_extensions.dart';
import 'package:quecto_chat_backend/core/helpers/response_helper.dart';
import 'package:quecto_chat_backend/core/interfaces/token_manager_facade.dart';
import 'package:quecto_chat_backend/domain/exceptions/app_exceptions.dart';
import 'package:quecto_chat_backend/l10n/generated/l10n.dart';
import 'package:quecto_chat_backend/l10n/generated/messages_all_locales.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(_verifyTokenHandler)
      .use(_setRequestLanguage);
}

/// Set request language and provide Localization
Handler _setRequestLanguage(Handler handler) {
  return (context) async {
    final acceptLanguage = context.request.headers['accept-language'] ?? 'en';
    // Specifies the required locale, defaulting to 'en'
    final locale = acceptLanguage.startsWith('ru') ? 'ru' : 'en';

    Intl.defaultLocale = locale;
    await initializeMessages(locale);

    return handler(context.provide<Localization>(Localization.new));
  };
}

// ACCESS TOKEN VERIFICATION:
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// List of public endpoints:
const _publicEndpoints = [
  'user/auth/login',
  'user/auth/token/refresh',
  'user/auth/registration',
  'user/auth/registration/validate',
  'user/auth/registration/resend-code',
];

/// List of private endpoints:
const _privateEndpoints = [
  'user/auth/logout',
];

/// Checks for token presence and validity in requests
Handler _verifyTokenHandler(Handler handler) {
  return (context) async {
    // 1. Checking the endpoint:
    final url = context.request.url.toString();
    // 1.1. If the request is public, process it:
    final isFreeAccess = _publicEndpoints.contains(url);
    if (isFreeAccess) return _continueProcessing(handler, context);
    // 1.2. If the request isn't private, respond with 404
    final isPrivateAccess = _privateEndpoints.contains(url);
    if (!isPrivateAccess) return ResponseHelper.notFound();

    // 2. Check for a token in headers:
    final authHeader = context.request.headers['Authorization'];
    final tokenValue = _getTokenFromAuthHeader(authHeader);
    if (tokenValue == null) {
      return ResponseHelper.unAuthorized(
          detail: context.texts.authErrorTokenMissing);
    }

    // 3. Check for token validity:
    try {
      final tokenManagerFacade = context.read<TokenManagerFacade>();
      final userId = tokenManagerFacade.validateAccessToken(tokenValue);
      final updatedContext = context.provide<String>(() => userId);
      return await _continueProcessing(handler, updatedContext);
    } on AccessTokenIsBlacklisted {
      return ResponseHelper.unAuthorized(detail: 'Access token is blacklisted');
    } on Object {
      // If the token is invalid or an error occurred during validation
      return ResponseHelper.unAuthorized(detail: 'Invalid or expired token');
    }
  };
}

/// Returns the token from the header, or null if it can't be retrieved or the header is empty
String? _getTokenFromAuthHeader(String? authHeader) {
  if (authHeader == null) return null;
  if (!authHeader.contains('Bearer ')) return null;
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
    return ResponseHelper.internalServerError(detail: '$e');
  }
}
