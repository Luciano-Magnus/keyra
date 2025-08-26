import 'package:keyra/src/modules/activation/entity/activation_entity.dart';
import 'package:keyra/src/shared/services/i_base_service.dart';

abstract class IActivationService implements IBaseService<ActivationEntity> {
  Future<List<ActivationEntity>> getByIdLicense(String licenseId);

  Future<bool> available(String key, String userId);

  Future<ActivationEntity> activate(ActivationEntity dto);
}
