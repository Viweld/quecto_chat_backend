import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

class ResponseHelper {
  const ResponseHelper._();

  /// Успешное выполнение запроса с возвратом ответных данных
  static Future<Response> success({
    required dynamic body,
  }) async {
    return Response.json(
      statusCode: HttpStatus.ok,
      body: body,
    );
  }

  /// Успешное выполнение запроса без ответных данных:
  static Future<Response> successEmpty({String? detail}) async {
    return detail == null
        ? Response.json(statusCode: HttpStatus.ok)
        : Response.json(
            statusCode: HttpStatus.ok,
            body: {'detail': detail},
          );
  }

  /// Не поддерживаемый метод для данного запроса:
  static Future<Response> methodNotAllowed() async {
    return Response.json(statusCode: HttpStatus.methodNotAllowed);
  }

  /// Отсутствует авторизация:
  static Future<Response> unAuthorized({String? detail}) async {
    return detail == null
        ? Response.json(statusCode: HttpStatus.unauthorized)
        : Response.json(
            statusCode: HttpStatus.unauthorized,
            body: {'detail': detail},
          );
  }

  /// Неправильный запрос:
  static Future<Response> badRequest({String? detail}) async {
    return detail == null
        ? Response.json(statusCode: HttpStatus.badRequest)
        : Response.json(
            statusCode: HttpStatus.badRequest,
            body: {'detail': detail},
          );
  }

  /// Ответ с произвольным статусом и текстом ошибки без ответных данных:
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

  /// Эндпоинт отсутствует:
  static Future<Response> notFound() async {
    return Response.json(statusCode: HttpStatus.notFound);
  }
}
