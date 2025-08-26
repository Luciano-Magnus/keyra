import 'package:keyra/src/modules/activation/entity/activation_entity.dart';
import 'package:keyra/src/shared/repositories/i_repository.dart';

abstract class IActivationRepository implements IRepository<ActivationEntity> {
  Future<List<ActivationEntity>> getByIdLicense(String licenseId);
}
