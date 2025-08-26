import 'package:keyra/src/shared/entity/i_base_entity.dart';
import 'package:postgres/postgres.dart';

abstract class IBaseService<E extends IBaseEntity> {
  Future<List<E>> getAll();

  Future<List<E>> getByIdUser(String idUser);

  Future<E?> getFirst();

  Future<E> saveOrUpdate(E entity);

  Future<E> saveOrUpdateInTransaction(E entity, TxSession transaction);

  Future<void> delete(E entity);

  Future<E?> getById(String id);

  Future<void> updatePatch(List<E> operations);
}
