import 'dart:async';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/exceptions/app_exceptions.dart';
import 'package:quecto_chat_backend/domain/helpers/decode_helper.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
import 'package:quecto_chat_backend/domain/use_cases/user/user_login.dart';
import 'package:quecto_chat_backend/presentation/models/inputs/user_login_input_dto.dart';
import 'package:quecto_chat_backend/presentation/models/outputs/user_login_output_dto.dart';

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
    final requestBody = DecodeHelper.decodeBody(requestBodyRaw);
    final credentials = UserLoginInputDto.fromJson(requestBody);

    // preparing dependencies
    final userLogin = context.read<UserLogin>();

    // execute login
    final tokens = await userLogin(credentials) as UserLoginOutputDto;
    return ResponseHelper.success(body: tokens.toJson());
  } on MissingRequestBody {
    return ResponseHelper.badRequest(detail: 'Missing request body');
  } on UnableToDecodeRequestBody catch (e) {
    return ResponseHelper.badRequest(
        detail:
            'Unable to decode request body ${e.details == null ? '.' : ': ${e.details}'}');
  } on InvalidRequestBodyValues catch (e) {
    // TODO(Vadim): Create response text use e.invalidFields
    final invalidFields = 'Some errors';
    return ResponseHelper.badRequest(detail: invalidFields);
  } on WrongEmailOrPassword {
    return ResponseHelper.unAuthorized(detail: 'Wrong email or password');
  } on Object catch (e) {
    return ResponseHelper.internalServerError(detail: '$e');
  }
}
