import 'package:postgres/postgres.dart';

extension PostgresExtension on Connection {
  Future<List<Map<String, Object?>>> query({
    required String tableKey,
    List<String>? columns,
    String? where,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final query = StringBuffer()..write('SELECT ');
    if (columns != null && columns.isNotEmpty) {
      _writeColumns(query, columns);
    } else {
      query.write('* ');
    }
    query
      ..write('FROM ')
      ..write(tableKey);
    _writeClause(query, ' WHERE ', where);
    _writeClause(query, ' ORDER BY ', orderBy);
    if (limit != null || offset != null) {
      _writeClause(query, ' LIMIT ', (limit ?? -1).toString());
    }
    if (offset != null) {
      _writeClause(query, ' OFFSET ', offset.toString());
    }

    // Выполнение запроса
    final result = await execute(query.toString());

    // Преобразование результата в список карт
    return result.map((row) => row.toColumnMap()).toList();
  }

  Future<void> insert({
    required String tableName,
    required Map<String, Object?> data,
  }) async {
    try {
      // Начало транзакции
      await runTx((session) async {
        // Выполнение SQL-запроса с параметрами внутри транзакции
        await session.execute(
          'INSERT INTO public."$tableName"(${data.keys.join(', ')}) '
          'VALUES (${data.keys.map((k) => '@$k').join(', ')})',
          parameters: data,
        );
      });

      print('Пользователь успешно сохранен в транзакции!');
    } catch (e) {
      print('Ошибка при сохранении пользователя в транзакции: $e');
    }
  }
}

void _writeClause(StringBuffer stringBuffer, String name, String? clause) {
  if (clause != null) {
    stringBuffer
      ..write(name)
      ..write(clause);
  }
}

void _writeColumns(StringBuffer stringBuffer, List<String> columns) {
  final n = columns.length;

  for (var i = 0; i < n; i++) {
    final column = columns[i];
    if (i > 0) stringBuffer.write(', ');
    stringBuffer.write(column);
  }
  stringBuffer.write(' ');
}
