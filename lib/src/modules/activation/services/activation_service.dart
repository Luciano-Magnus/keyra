import 'package:keyra/src/modules/activation/entity/activation_entity.dart';
import 'package:keyra/src/modules/activation/repositories/i_activation_repository.dart';
import 'package:keyra/src/modules/activation/services/i_activation_service.dart';
import 'package:keyra/src/modules/license/entity/license_entity.dart';
import 'package:keyra/src/modules/license/services/i_licence_service.dart';
import 'package:keyra/src/shared/database/database.dart';
import 'package:keyra/src/shared/exceptions/custom/custom_exception.dart';
import 'package:keyra/src/shared/exceptions/not_found/not_found_exception.dart';
import 'package:keyra/src/shared/services/base_service.dart';
import 'package:vaden/vaden.dart';

@Service()
class ActivationService extends BaseService<ActivationEntity, IActivationRepository> implements IActivationService {
  final ILicenseService _licenseService;
  final Database _database;

  ActivationService(super.repository, this._licenseService, this._database);

  @override
  Future<List<ActivationEntity>> getByIdLicense(String licenseId) async => await repository.getByIdLicense(licenseId);

  @override
  Future<ActivationEntity> activate(ActivationEntity entity) async {
    final licenses = await _licenseService.getAllByKey(entity.key, entity.base.userId!);

    if (licenses.isEmpty) {
      throw NotFoundException();
    }

    final license = licenses.first;

    license.currentActivations += 1;
    entity.licenseId = license.base.id;

    _validateLicense(license);

    return await _database.runInTransaction<ActivationEntity>((txn) async {
      await _licenseService.saveOrUpdateInTransaction(license, txn);

      return await saveOrUpdateInTransaction(entity, txn);
    });
  }

  @override
  Future<bool> available(String key, String userId) async {
    final licenses = await _licenseService.getAllByKey(key, userId);

    if (licenses.isEmpty) {
      throw NotFoundException();
    }

    final license = licenses.first;

    _validateLicense(license);

    return true;
  }

  void _validateLicense(LicenseEntity license) {
    if (license.expirationDate != null && license.expirationDate!.isBefore(DateTime.now())) {
      throw CustomException('License has expired', code: 410);
    } else if (license.maxActivations == 0) {
      throw CustomException('License has no activations left', code: 409);
    } else if (license.currentActivations > license.maxActivations) {
      throw CustomException('Maximum number of activations reached', code: 409);
    }
  }
}
