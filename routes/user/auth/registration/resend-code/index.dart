import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/core/extensions/context_extensions.dart';
import 'package:quecto_chat_backend/core/helpers/decode_helper.dart';
import 'package:quecto_chat_backend/core/helpers/response_helper.dart';
import 'package:quecto_chat_backend/core/helpers/serialization_helper.dart';
import 'package:quecto_chat_backend/domain/exceptions/app_exceptions.dart';
import 'package:quecto_chat_backend/domain/use_cases/user/resend_validation_code/user_resend_validation_code.dart';
import 'package:quecto_chat_backend/presentation/models/inputs/user_resend_validation_code_input_dto.dart';

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
    final resendValidationCodeData =
        UserResendValidationCodeInputDto.fromJson(requestBody);

    // preparing dependencies
    final resendValidationCode = context.read<UserResendValidationCode>();

    // execute resend validation code
    await resendValidationCode(resendValidationCodeData);
    return ResponseHelper.successEmpty();
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
  } on UnknownUserEmail {
    return ResponseHelper.notFound(
        detail: context.texts.authErrorUnknownUserEmail);
  } on AlreadyVerified {
    return ResponseHelper.badRequest(
        detail: context.texts.authErrorAlreadyVerified);
  } on TooManyAttempts {
    return ResponseHelper.tooManyRequests(
        detail: context.texts.authErrorTooManyAttempts);
  }
}
