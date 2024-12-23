import 'package:postgres/postgres.dart';

extension PostgresExtension on Connection {
  // ---------------------------------------------------------------------------
  /// Most common query to database with postgres package
  Future<List<Map<String, Object?>>> get({
    required String tableName,
    List<String>? columns,
    String? where,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final query = StringBuffer();
    if (columns != null && columns.isNotEmpty) {
      query.write('SELECT ${columns.join(', ')}');
    } else {
      query.write('SELECT *');
    }

    query.write(' FROM public.$tableName');
    if (where != null) query.write(' WHERE $where');
    if (orderBy != null) query.write(' ORDER BY $orderBy');
    if (limit != null) query.write(' LIMIT $limit');
    if (offset != null) query.write(' OFFSET $offset');

    // executes an SQL query
    final result = await execute(query.toString());

    // transform result to list of maps
    return result.map((row) => row.toColumnMap()).toList();
  }

  // ---------------------------------------------------------------------------
  /// Query to insert data into database with postgres package as a transactional process
  Future<void> insert({
    required String tableName,
    required Map<String, Object?> data,
  }) async {
    await runTx((session) async {
      final keys = data.keys.toList();
      final placeholders = keys.map((k) => '@$k').join(', ');
      final columns = keys.join(', ');

      final query = '''
        INSERT INTO public.$tableName ($columns)
        VALUES ($placeholders)
      ''';

      await session.execute(Sql.named(query), parameters: data);
    });
  }

  // ---------------------------------------------------------------------------
  /// Query to update data in database with postgres package as a transactional process
  Future<void> updateById({
    required String tableName,
    required Map<String, Object?> data,
    required String id,
  }) async {
    // open the transaction
    await runTx((session) async {
      final query = '''
        UPDATE public.$tableName
        SET ${data.keys.map((key) => '$key = @$key').join(', ')}
        WHERE id = $id
      ''';

      await session.execute(Sql.named(query), parameters: data);
    });
  }

  // ---------------------------------------------------------------------------
  /// Deletes rows from a specified table in the database where the field value matches a given condition.
  /// - `tableName`: The name of the table from which rows will be deleted.
  /// - `fieldKey`: The column name used to match the rows to delete.
  /// - `matchValue`: The value that must match the specified column for rows to be deleted.
  Future<void> delete({
    required String tableName,
    required String fieldKey,
    required String matchValue,
  }) async {
    // open the transaction
    await runTx((session) async {
      // executes an SQL query
      await session.execute(
        '''
        DELETE FROM public.$tableName
        WHERE $fieldKey = \'$matchValue\'
        ''',
      );
    });
  }
}
