import 'package:keyra/src/modules/license/entity/license_entity.dart';
import 'package:keyra/src/modules/license/repositories/i_license_repository.dart';
import 'package:keyra/src/modules/license/services/i_licence_service.dart';
import 'package:keyra/src/shared/services/base_service.dart';
import 'package:vaden/vaden.dart';

@Service()
class LicenseService extends BaseService<LicenseEntity, ILicenseRepository> implements ILicenseService {
  LicenseService(super.repository);

  @override
  Future<List<LicenseEntity>> getAllByIdProduct(String idProduct) {
    return repository.getAll(where: 'id_product = @idProduct', parameters: {'idProduct': idProduct});
  }

  @override
  Future<List<LicenseEntity>> getAllByKey(String key, String idUser) {
    return repository.getAll(where: 'key = @key AND id_user = @idUser', parameters: {'key': key, 'idUser': idUser});
  }
}
