import 'dart:async';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/domain/helpers/decode_helper.dart';
import 'package:quecto_chat_backend/domain/helpers/response_helper.dart';
import 'package:quecto_chat_backend/domain/interfaces/env_parameters.dart';
import 'package:quecto_chat_backend/domain/interfaces/user_repository.dart';
import 'package:quecto_chat_backend/domain/use_cases/user/user_registration.dart';
import 'package:quecto_chat_backend/presentation/models/inputs/user_registration_input_dto.dart';
import 'package:quecto_chat_backend/services/send_grid_mail_sender_service.dart';

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
    final registerData = UserRegistrationInputDto.fromJson(requestBody);

    // preparing dependencies
    final userRepository = context.read<UserRepository>();
    final envParameters = context.read<EnvParameters>();
    final mailSenderService = SendGridMailSenderService(envParameters);
    final userRegister = UserRegistration(userRepository, mailSenderService);

    // execute registration
    await userRegister(registerData);
    return ResponseHelper.successEmpty();

    // TODO(Vadim): #unimplemented - error handling needs to be finished
    // } on MissingRequestBody {
    //   return ResponseHelper.badRequest(detail: 'Missing request body');
    // } on InvalidRequestBodyValues catch (e) {
    //   return ResponseHelper.badRequest(
    //       detail:
    //           'Invalid request body values ${e.keys.map((k) => '"$k"').toList().join(', ')}');
    // } on UnableToDecodeRequestBody catch (e) {
    //   return ResponseHelper.badRequest(
    //       detail:
    //           'Unable to decode request body ${e.details == null ? '.' : ': ${e.details}'}');
    // } on UnsupportedDataTypeInRequestBody catch (e) {
    //   return ResponseHelper.badRequest(
    //       detail:
    //           'Unsupported data type in request body ${e.details == null ? '.' : ': ${e.details}'}');
  } on Object catch (e) {
    return ResponseHelper.internalServerError(detail: '$e');
  }
}
