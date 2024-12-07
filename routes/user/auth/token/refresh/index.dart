import 'dart:async';
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/exceptions/app_exceptions.dart';
import 'package:quecto_chat_backend/domain/extensions/context_extensions.dart';
import 'package:quecto_chat_backend/domain/helpers/decode_helper.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
import 'package:quecto_chat_backend/presentation/models/inputs/user_token_refresh_input_dto.dart';

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
    // get data from request body
    final requestBodyRaw = await context.request.body();
    final requestBody = DecodeHelper.decodeBody(requestBodyRaw);
    final refreshData = UserTokenRefreshInputDto.fromJson(requestBody);

    // preparing dependencies
    final userTokenRefresh = context.read<UserTokenRefresh>();

    // 200
    // 400
    // 401
    // 405

    final userId = jwtService.validateToken(refreshToken);
    final newAccessToken = jwtService.generateAccessToken(userId);
  } on MissingRequestBody {
    return ResponseHelper.badRequest(
        detail: context.texts.requestErrorMissingBody);
  } on UnableToDecodeRequestBody catch (e) {
    return ResponseHelper.badRequest(
        detail: context.texts.requestErrorUnableToDecode +
            (e.details == null ? '' : ': ${e.details}'));

    return ResponseHelper.success(body: {'access': newAccessToken});
  } on InvalidRequestBodyValues catch (e) {
    final invalidFields = e.invalidFields.serialize(context);
    return ResponseHelper.badRequest(detail: jsonEncode(invalidFields));
  } on Object {
    return ResponseHelper.unAuthorized(detail: 'Invalid refresh token');
  }
}
