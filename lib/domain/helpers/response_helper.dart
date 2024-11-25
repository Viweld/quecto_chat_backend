import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

class ResponseHelper {
  const ResponseHelper._();

  /// Successful execution of the request with return of response data
  static Future<Response> success({
    required dynamic body,
  }) async {
    return Response.json(
      statusCode: HttpStatus.ok,
      body: body,
    );
  }

  /// Successful execution of a request without response data:
  static Future<Response> successEmpty({String? detail}) async {
    return detail == null
        ? Response.json(statusCode: HttpStatus.ok)
        : Response.json(
            statusCode: HttpStatus.ok,
            body: {'detail': detail},
          );
  }

  /// Method not allowed:
  static Future<Response> methodNotAllowed() async {
    return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }

  /// Unauthorized:
  static Future<Response> unAuthorized({String? detail}) async {
    return detail == null
        ? Response.json(statusCode: HttpStatus.unauthorized)
        : Response.json(
            statusCode: HttpStatus.unauthorized,
            body: {'detail': detail},
          );
  }

  /// Bad request:
  static Future<Response> badRequest({String? detail}) async {
    return detail == null
        ? Response.json(statusCode: HttpStatus.badRequest)
        : Response.json(
            statusCode: HttpStatus.badRequest,
            body: {'detail': detail},
          );
  }

  /// Response with arbitrary status and error text without response data:
  static Future<Response> abortWithStatus({
    required int status,
    String? detail,
  }) async {
    return detail == null
        ? Response.json(statusCode: status)
        : Response.json(
            statusCode: status,
            body: {'detail': detail},
          );
  }

  /// Endpoint not found:
  static Future<Response> notFound({String? detail}) async {
    return detail == null
        ? Response.json(statusCode: HttpStatus.notFound)
        : Response.json(
            statusCode: HttpStatus.notFound,
            body: {'detail': detail},
          );
  }

  /// Internal server error:
  static Future<Response> internalServerError({String? detail}) async {
    return detail == null
        ? Response.json(statusCode: HttpStatus.internalServerError)
        : Response.json(
            statusCode: HttpStatus.internalServerError,
            body: {'detail': detail},
          );
  }
}
