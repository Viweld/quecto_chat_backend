import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:quecto_chat_backend/data/data_base/postgres_data_base.dart';
import 'package:quecto_chat_backend/domain/interfaces/data_base.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  final dataBase = await _prepareDataBase();
  handler.use(provider<DataBase>((_) => dataBase));

  return serve(handler, ip, port);
}

/// Готовит базу двнных
Future<DataBase> _prepareDataBase() async {
  final dataBase = PostgresDataBase();
  await dataBase.initialize();
  return dataBase;
}
