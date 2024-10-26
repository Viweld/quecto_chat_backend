import 'dart:convert';

import '../exceptions/app_exceptions.dart';

class DecodeHelper {
  const DecodeHelper._();

  /// For decode request body, represented as String
  static Map<String, Object?> decodeBody(String requestBody) {
    if (requestBody.isEmpty) throw const MissingRequestBody();
    try {
      final data = jsonDecode(requestBody);
      if (data is! Map<String, Object?>) {
        throw const UnableToDecodeRequestBody();
      }
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
}
