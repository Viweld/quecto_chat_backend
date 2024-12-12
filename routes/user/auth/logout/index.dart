import 'dart:async';
import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/core/helpers/response_helper.dart';
import 'package:quecto_chat_backend/domain/use_cases/user/auth/full_logout/user_full_logout.dart';

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
  // preparing dependencies
  final userLogout = context.read<UserFullLogout>();
  final userId = context.read<String>();

  await userLogout.call(userId);
  return ResponseHelper.successEmpty();
}
