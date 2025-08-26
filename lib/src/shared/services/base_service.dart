import 'package:keyra/src/shared/entity/i_base_entity.dart';
import 'package:keyra/src/shared/repositories/i_repository.dart';
import 'package:keyra/src/shared/services/i_base_service.dart';
import 'package:postgres/postgres.dart';

abstract class BaseService<E extends IBaseEntity, Y extends IRepository<E>> implements IBaseService<E> {
  final Y repository;

  BaseService(this.repository);

  @override
  Future<E> saveOrUpdate(E entity) async {
    return await repository.saveOrUpdate(entity);
  }

  @override
  Future<E> saveOrUpdateInTransaction(E entity, TxSession transaction) async {
    return await repository.saveOrUpdateInTransaction(entity, transaction);
  }

  @override
  Future<List<E>> getAll() async {
    return await repository.getAll();
  }

  Future<List<E>> getByIdUser(String idUser) async {
    return await repository.getAll(where: 'id_user = @id_user', parameters: {'id_user': idUser});
  }

  @override
  Future<E?> getById(String id, {bool deleted = false}) async {
    return await repository.getById(id, deleted: deleted);
  }

  @override
  Future<E?> getFirst() async {
    return await repository.getFirst();
  }

  @override
  Future<void> updatePatch(List<E> operations) {
    // TODO: implement updatePatch
    throw UnimplementedError();
  }

  @override
  Future<void> delete(E entity) async {
    await repository.delete(entity);
  }
}