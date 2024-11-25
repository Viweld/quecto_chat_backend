import '../models/inputs/common/input_fields/base_input_field.dart';

sealed class CoreExceptions implements Exception {}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// The most common exceptions when processing incoming requests:
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

/// Invalid request body values
final class InvalidRequestBodyValues implements RequestBodyExceptions {
  const InvalidRequestBodyValues(this.invalidFields);

  final List<BaseInputField<Object, Object>> invalidFields;
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// The most common exceptions when processing user use-cases:
sealed class UserExceptions implements CoreExceptions {}

/// Email already used
final class EmailAlreadyUsed implements UserExceptions {
  const EmailAlreadyUsed();
}

/// Wrong email or password
final class WrongEmailOrPassword implements UserExceptions {
  const WrongEmailOrPassword();
}

/// Email is not registered in the application
final class UnknownUserEmail implements UserExceptions {
  const UnknownUserEmail();
}

/// User already verified
final class AlreadyVerified implements UserExceptions {
  const AlreadyVerified();
}

/// Wrong verification code
final class WrongVerificationCode implements UserExceptions {
  const WrongVerificationCode();
}
