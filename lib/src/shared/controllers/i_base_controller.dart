import 'package:keyra/src/shared/dto/i_base_dto.dart';
import 'package:vaden/vaden.dart';

abstract class IBaseController<D extends IBaseDto> {
  Future<List<D>> getAll(int limit, int offset, Request request);

  Future<D?> save(D dto, Request request);

  Future<D> update(D dto, Request request);

  Future<void> delete(D dto, Request request);

  Future<D?> getById(String id, Request request);
}
