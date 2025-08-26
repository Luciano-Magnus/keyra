import 'package:keyra/src/shared/database/migrations/core_tables_migration.dart';
import 'package:keyra/src/shared/database/migrations/initial_migration.dart';
import 'package:keyra/src/shared/extensions/nullable_string_extensions.dart';
import 'package:postgres/postgres.dart';
import 'package:vaden/vaden.dart';

@Component()
class Database {
  final Connection _connection;

  Database(this._connection);

  ///region create database

  Future<void> create() async {
    await _connection.runTx((session) async {
      await _executeQuery(
        query: '''
                    CREATE TABLE IF NOT EXISTS migration (
                      id_migration SERIAL PRIMARY KEY,
                      data_hora TIMESTAMP NOT NULL DEFAULT NOW(),
                      nome VARCHAR(100) NOT NULL,
                      versao VARCHAR(20) NOT NULL
                    );
                  ''',
        txn: session,
      );

      await InitialMigration().run(_executeQuery, session, this);
      await CoreTablesMigration().run(_executeQuery, session, this);

      return;
    });
  }

  ///endregion

  ///region Save | Update | Delete
  Future<void> save({required String tableName, required Map<String, dynamic> values, TxSession? txn}) async {
    await _executeQuery(query: 'INSERT INTO $tableName (${values.keys.join(', ')}) VALUES (${values.keys.map((e) => '@$e').join(', ')})', parameters: values, txn: txn);
  }

  Future<void> update({required String tableName, required Map<String, dynamic> values, required String where, TxSession? txn}) async {
    await _executeQuery(query: 'UPDATE $tableName SET ${values.keys.map((e) => '$e = @$e').join(', ')} WHERE $where', parameters: values, txn: txn);
  }

  Future<void> upsert({required String tableName, required Map<String, dynamic> values, TxSession? txn}) async {
    await _executeQuery(
      query: '''
      INSERT INTO $tableName (${values.keys.join(', ')}) 
      VALUES (${values.keys.map((e) => '@$e').join(', ')}) 
      ON CONFLICT (${_idColumnName(tableName)}) 
      DO UPDATE SET ${values.keys.map((e) => '$e = EXCLUDED.$e').join(', ')}
      ''',
      parameters: values,
      txn: txn,
    );
  }

  Future<void> delete({required String tableName, required String id, TxSession? txn}) async {
    final values = <String, dynamic>{};

    values['data_hora_deletado'] = DateTime.now();

    await _executeQuery(query: 'UPDATE $tableName SET ${values.keys.map((e) => '$e = @$e').join(', ')} WHERE ${_idColumnName(tableName)} = @id', parameters: values..addAll({'id': id}), txn: txn);
  }

  Future<T> runInTransaction<T>(Future<T> Function(TxSession txn) operation) async {
    return await _connection.runTx((txn) async {
      return await operation(txn);
    }
    );
  }

  ///endregion

  ///region Select
  Future<List<Map<String, dynamic>>> select({required String tableName, String? where, Map<String, dynamic>? parameters, int? limit, int? offset, String? orderBy, TxSession? txn}) async {
    where = where?.replaceAll('WHERE', '').replaceAll('where', '');
    orderBy = orderBy?.replaceAll('ORDER BY', '').replaceAll('order by', '');

    String limitOffset = '';

    if (limit != null) {
      limitOffset += ' LIMIT $limit';
    }

    if (offset != null) {
      limitOffset += ' OFFSET $offset';
    }

    final result = await _executeQuery(
      query: '''
                  SELECT * 
                  FROM $tableName 
                  ${where?.isNullOrWhiteSpace == false ? 'WHERE $where' : ''} 
                  $limitOffset
                  ${orderBy?.isNullOrWhiteSpace == false ? 'ORDER BY $orderBy' : ''}
      ''',
      parameters: parameters,
      txn: txn,
    );

    return result.map((row) => row.toColumnMap()).toList();
  }

  ///endregion

  ///region executeQuery
  Future<Result> _executeQuery({required String query, Map<String, dynamic>? parameters, TxSession? txn}) async {
    final conn = txn ?? _connection;

    try {
      return await conn.execute(Sql.named(query), parameters: parameters);
    } on ServerException catch (e) {
      throw _handleException(e);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Exception _handleException(ServerException e) {
    if (e.code == '3D000') {
      return Exception('Banco de dados não encontrado.');
    } else if (e.code == '28P01') {
      return Exception('Usuário ou senha inválidos.');
    } else if (e.code == '08006') {
      return Exception('Conexão recusada.');
    } else {
      return e;
    }
  }

  ///endregion

  String _idColumnName(String tableName) {
    String id = 'id_$tableName';

    // Remove plural 's' if exists
    if (id.endsWith('s')) {
      return id.substring(0, id.length - 1);
    }

    return id;
  }
}
