import 'package:keyra/src/shared/entity/i_base_entity.dart';
import 'package:postgres/postgres.dart';

abstract class IRepository<E extends IBaseEntity> {
  String createTable();

  Future<E> saveOrUpdate(E entity);

  Future<E> saveOrUpdateInTransaction(E entity, TxSession transaction);

  Future<List<E>> getAll({bool deleted = false, String? where, Map<String, dynamic>? parameters, int? limit, int? offset, String? orderBy});

  Future<E?> getById(String id, {bool deleted = false});

  Future<E?> getFirst();

  Future<void> delete(E entity);

  List<String> get indexs => [];
}
