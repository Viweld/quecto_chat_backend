import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/core/environment/dep_provider.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  // provide environment:
  final depProvider = DepProvider();
  await depProvider.initialize();
  final injectedHandler = depProvider.injectDependencies(handler);

  return serve(injectedHandler, ip, port);
}
