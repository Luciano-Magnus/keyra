import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/modules/license/dto/license_dto.dart';
import 'package:keyra/src/shared/entity/base_entity.dart';
import 'package:keyra/src/shared/entity/i_base_entity.dart';

@AutoMap(target: LicenseDto)
class LicenseEntity implements IBaseEntity {
  @override
  BaseUserEntity base;

  final String? key;
  final int maxActivations;
  int currentActivations;
  final DateTime? expirationDate;
  final StatusLicenseEnum status;
  final String productId;

  LicenseEntity({
    required this.base,
    required this.key,
    required this.maxActivations,
    required this.currentActivations,
    required this.expirationDate,
    required this.status,
    required this.productId,
  });
}
