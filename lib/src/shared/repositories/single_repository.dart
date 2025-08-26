import 'package:keyra/src/shared/database/database.dart';
import 'package:keyra/src/shared/entity/i_base_entity.dart';
import 'package:keyra/src/shared/repositories/base_repository.dart';
import 'package:keyra/src/shared/repositories/i_repository.dart';
import 'package:postgres/postgres.dart';

abstract class SingleRepository<E extends IBaseEntity> extends BaseRepository<E> implements IRepository<E> {
  final Database _database;

  SingleRepository(this._database);

  E fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap(E entity);

  @override
  Future<E> saveOrUpdate(E entity) async {
    final map = toMap(entity);

    await _database.upsert(tableName: getTableName, values: map);

    return entity;
  }

  @override
  Future<E> saveOrUpdateInTransaction(E entity, TxSession transaction) async {
    final map = toMap(entity);

    await _database.upsert(tableName: getTableName, values: map, txn: transaction);

    return entity;
  }

  @override
  Future<List<E>> getAll({bool deleted = false, String? where, Map<String, dynamic>? parameters, int? limit, int? offset, String? orderBy}) async {
    return getFull(deleted: deleted, where: where ?? '', parameters: parameters, orderBy: orderBy, limit: limit, offset: offset);
  }

  @override
  Future<E?> getById(String id, {bool deleted = false}) async {
    return (await getFull(id: id, deleted: deleted, limit: 1)).firstOrNull;
  }

  @override
  Future<E?> getFirst() async => await getAll(limit: 1).then((value) => value.firstOrNull);


  Future<List<E>> getFull({
    String? id,
    String where = '',
    Map<String, dynamic>? parameters,
    int? limit,
    int? offset,
    String? orderBy,
    bool deleted = false,
    TxSession? txn,
  }) async {
    if (id != null) {
      where = '$getIdColumnName = @$getIdColumnName';
      parameters = {getIdColumnName: id};
    }

    final result = await _database.select(
      tableName: getTableName,
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      parameters: parameters,
      txn: txn,
    );

    return result.map((e) => fromMap(e)).toList();
  }

  @override
  Future<void> delete(E entity) async {
    await _database.delete(tableName: getTableName, id: entity.base!.id);
  }
}
