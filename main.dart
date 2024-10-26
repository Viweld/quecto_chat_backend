import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/data/data_base/postgres_data_base.dart';
import 'package:quecto_chat_backend/domain/interfaces/data_base.dart';
import 'package:quecto_chat_backend/domain/interfaces/env_parameters.dart';
import 'package:quecto_chat_backend/parameters/env_parameters_impl.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  // environment properties preparation
  final envParameters = EnvParametersImpl();
  handler.use(provider<EnvParameters>((_) => envParameters));

  // database preparation
  final dataBase = await _prepareDataBase(envParameters);
  handler.use(provider<DataBase>((_) => dataBase));

  return serve(handler, ip, port);
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Prepare of database
Future<DataBase> _prepareDataBase(EnvParameters envParameters) async {
  final dataBase = PostgresDataBase(envParameters);
  await dataBase.initialize();
  return dataBase;
}
