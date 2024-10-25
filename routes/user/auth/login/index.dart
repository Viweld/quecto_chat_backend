import 'dart:async';
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/exceptions/app_exceptions.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
import 'package:quecto_chat_backend/domain/interfaces/user_repository.dart';
import 'package:quecto_chat_backend/domain/use_cases/user/authenticate_user.dart';
import 'package:quecto_chat_backend/presentation/models/requests/user_login_credentials_dto.dart';
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
  try {
    // get credentials from request body
    final requestBodyRaw = await context.request.body();
    final requestBody = _decodeRequestBody(requestBodyRaw);
    final credentials = UserLoginCredentialsDto.fromJson(requestBody);

    // preparing dependencies
    final userRepository = context.read<UserRepository>();
    final jwtService = JwtService();
    final authenticateUser = AuthenticateUser(userRepository, jwtService);

    // execute login
    final tokens = await authenticateUser(credentials);
    return ResponseHelper.success(body: tokens);
  } on WrongEmailOrPassword {
    return ResponseHelper.unAuthorized(detail: 'Wrong email or password');
  } on MissingRequestBody {
    return ResponseHelper.badRequest(detail: 'Missing request body');
  } on InvalidRequestBodyValues catch (e) {
    return ResponseHelper.badRequest(
        detail:
            'Invalid request body values ${e.keys.map((k) => '"$k"').toList().join(', ')}');
  } on UnableToDecodeRequestBody catch (e) {
    return ResponseHelper.badRequest(
        detail:
            'Unable to decode request body ${e.details == null ? '.' : ': ${e.details}'}');
  } on UnsupportedDataTypeInRequestBody catch (e) {
    return ResponseHelper.badRequest(
        detail:
            'Unsupported data type in request body ${e.details == null ? '.' : ': ${e.details}'}');
  } on Object catch (e) {
    return ResponseHelper.internalServerError(detail: '$e');
  }
}

// TODO(Vadim): need to refactor:
Map<String, Object?> _decodeRequestBody(String requestBody) {
  if (requestBody.isEmpty) throw const MissingRequestBody();
  try {
    final data = jsonDecode(requestBody);
    if (data is! Map<String, Object?>) throw const UnableToDecodeRequestBody();
    return data;
  } on FormatException catch (e) {
    throw UnableToDecodeRequestBody(
      '${e.message} in "${e.source}"'
      '${e.offset == null ? '' : 'at index position ${e.offset}'}',
    );
  } on Object {
    throw const UnableToDecodeRequestBody();
  }
}
