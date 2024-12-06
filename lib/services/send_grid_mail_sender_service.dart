import 'dart:convert';
import 'dart:developer' as debug;
import 'package:http/http.dart' as http;

import '../domain/interfaces/env_parameters.dart';
import '../domain/interfaces/mail_sender_service.dart';

/// Implementation of MailSenderService
class SendGridMailSenderService implements MailSenderService {
  SendGridMailSenderService(EnvParameters env) : _env = env;

  final EnvParameters _env;

  // ---------------------------------------------------------------------------
  @override
  Future<void> sendEmail(String to, String subject, String body) async {
    final response = await http.post(
      Uri.parse(_env.sendGridUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_env.sendGridApiKey}',
      },
      body: jsonEncode({
        'personalizations': [
          {
            'to': [
              {'email': to}
            ],
            'subject': subject,
          }
        ],
        'from': {'email': 'your_email@example.com'},
        'content': [
          {
            'type': 'text/plain',
            'value': body,
          }
        ],
      }),
    );

    // TODO(Vadim): #unimplemented - make result
    if (response.statusCode == 202) {
      debug.log('Email sent successfully!');
    } else {
      debug.log('Failed to send email: ${response.body}');
    }
  }
}
