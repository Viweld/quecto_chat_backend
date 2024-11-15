import 'package:intl/intl.dart';

class Localization {
  /// `Hello`
  String get greeting {
    return Intl.message(
      'Hello',
      name: 'greeting',
      desc: 'Greeting message',
      args: [],
    );
  }

  /// `Goodbye`
  String get farewell {
    return Intl.message(
      'Goodbye',
      name: 'farewell',
      desc: '',
      args: [],
    );
  }

  /// `Buy for {cost} per {monthCount, plural, one{{monthCount} month} many{{monthCount} months} other{{monthCount} months}}`
  String tariffsBuyButton(Object cost, num monthCount) {
    return Intl.message(
      'Buy for $cost per ${Intl.plural(monthCount, one: '$monthCount month', many: '$monthCount months', other: '$monthCount months')}',
      name: 'tariffsBuyButton',
      desc: 'cost and month count',
      args: [cost, monthCount],
    );
  }
}
