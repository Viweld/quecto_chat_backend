import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/data/data_base/postgres_data_base.dart';
import 'package:quecto_chat_backend/domain/interfaces/data_base.dart';
import 'package:quecto_chat_backend/domain/interfaces/env_parameters.dart';
import 'package:quecto_chat_backend/parameters/env_parameters_impl.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  // готовим параметры окружения
  final envParameters = EnvParametersImpl();
  handler.use(provider<EnvParameters>((_) => envParameters));

  // готовим базу данных
  final dataBase = await _prepareDataBase(envParameters);
  handler.use(provider<DataBase>((_) => dataBase));

  return serve(handler, ip, port);
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Готовит базу данных
Future<DataBase> _prepareDataBase(EnvParameters envParameters) async {
  final dataBase = PostgresDataBase(envParameters);
  await dataBase.initialize();
  return dataBase;
}
