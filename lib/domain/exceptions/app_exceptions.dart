sealed class CoreExceptions implements Exception {}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
sealed class RequestBodyExceptions implements CoreExceptions {}

/// Missing request body
final class MissingRequestBody implements RequestBodyExceptions {
  const MissingRequestBody();
}

/// Unable to decode request body (with details)
final class UnableToDecodeRequestBody implements RequestBodyExceptions {
  const UnableToDecodeRequestBody([this.details]);

  final String? details;
}

/// Unsupported data type in request body (with details)
final class UnsupportedDataTypeInRequestBody implements RequestBodyExceptions {
  const UnsupportedDataTypeInRequestBody([this.details]);

  final String? details;
}

/// Invalid request body values
final class InvalidRequestBodyValues implements RequestBodyExceptions {
  const InvalidRequestBodyValues(this.keys);

  final List<String> keys;
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
sealed class UserExceptions implements CoreExceptions {}

/// Email already used
final class EmailAlreadyUsed implements UserExceptions {
  const EmailAlreadyUsed();
}

/// Wrong email or password
final class WrongEmailOrPassword implements UserExceptions {
  const WrongEmailOrPassword();
}
