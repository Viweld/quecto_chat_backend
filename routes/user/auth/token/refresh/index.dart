import 'dart:async';
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/exceptions/app_exceptions.dart';
import 'package:quecto_chat_backend/core/extensions/context_extensions.dart';
import 'package:quecto_chat_backend/core/helpers/decode_helper.dart';
import 'package:quecto_chat_backend/core/helpers/response_helper.dart';
import 'package:quecto_chat_backend/core/helpers/serialization_helper.dart';
import 'package:quecto_chat_backend/domain/use_cases/user/token_refresh/user_token_refresh.dart';
import 'package:quecto_chat_backend/presentation/models/inputs/user_token_refresh_input_dto.dart';
import 'package:quecto_chat_backend/presentation/models/outputs/user_token_refresh_output_dto.dart';

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

    // execute token refresh use-case
    final tokens =
        await userTokenRefresh.call(refreshData) as UserTokenRefreshOutputDto;

    return ResponseHelper.success(body: tokens.toJson());
  } on MissingRequestBody {
    return ResponseHelper.badRequest(
        detail: context.texts.requestErrorMissingBody);
  } on UnableToDecodeRequestBody catch (e) {
    return ResponseHelper.badRequest(
        detail: context.texts.requestErrorUnableToDecode +
            (e.details == null ? '' : ': ${e.details}'));
  } on InvalidRequestBodyValues catch (e) {
    final invalidFields = e.invalidFields.serialize(context);
    return ResponseHelper.badRequest(detail: jsonEncode(invalidFields));
  } on TokenExceptions {
    return ResponseHelper.unAuthorized(
      detail: 'Invalid refresh token',
    );
  } on Object catch (e) {
    return ResponseHelper.internalServerError(detail: '$e');
  }
}
