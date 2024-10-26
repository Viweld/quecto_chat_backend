/// Interface for mail sending service
abstract interface class MailSenderService {
  /// Send an email with verification code
  Future<void> sendEmail(String to, String subject, String body);
}
