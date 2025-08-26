import 'package:keyra/src/modules/license/entity/license_entity.dart';
import 'package:keyra/src/shared/services/i_base_service.dart';

abstract class ILicenseService implements IBaseService<LicenseEntity> {
  Future<List<LicenseEntity>> getAllByIdProduct(String idProduct);
  Future<List<LicenseEntity>> getAllByKey(String key, String idUser);
}