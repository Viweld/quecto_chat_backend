import 'dart:async';
import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/exceptions/app_exceptions.dart';
import 'package:quecto_chat_backend/core/extensions/context_extensions.dart';
import 'package:quecto_chat_backend/core/helpers/decode_helper.dart';
import 'package:quecto_chat_backend/core/helpers/response_helper.dart';
import 'package:quecto_chat_backend/core/helpers/serialization_helper.dart';
import 'package:quecto_chat_backend/domain/use_cases/user/registration_validate/user_registration_validate.dart';
import 'package:quecto_chat_backend/presentation/models/inputs/user_registration_validate_input_dto.dart';
import 'package:quecto_chat_backend/presentation/models/outputs/user_registration_validate_output_dto.dart';

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
    final validationData =
        UserRegistrationValidateInputDto.fromJson(requestBody);

    // preparing dependencies
    final userRegistrationValidate = context.read<UserRegistrationValidate>();

    // execute validation
    final tokens = await userRegistrationValidate(validationData)
        as UserRegistrationValidateOutputDto;
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
  } on UnknownUserEmail {
    return ResponseHelper.notFound(
        detail: context.texts.authErrorUnknownUserEmail);
  } on AlreadyVerified {
    return ResponseHelper.badRequest(
        detail: context.texts.authErrorAlreadyVerified);
  } on WrongVerificationCode {
    return ResponseHelper.badRequest(
        detail: context.texts.authErrorWrongVerificationCode);
  } on Object catch (e) {
    return ResponseHelper.internalServerError(detail: '$e');
  }
}
