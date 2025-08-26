import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/modules/license/entity/license_entity.dart';
import 'package:keyra/src/shared/dto/base_dto.dart';
import 'package:keyra/src/shared/dto/i_base_dto.dart';
import 'package:keyra/src/shared/utils/token/token_utils.dart';
import 'package:vaden/vaden.dart';

@DTO()
@AutoMap(target: LicenseEntity)
class LicenseDto implements IBaseDto {
  @override
  @UseParse(BaseDtoParse)
  BaseUserDto base;

  String? key;
  final int maxActivations;
  final int currentActivations;
  final DateTime? expirationDate;
  final StatusLicenseEnum status;
  final String productId;
  String? userId;

  LicenseDto({
    required this.base,
    required this.key,
    required this.maxActivations,
    required this.currentActivations,
    required this.expirationDate,
    required this.status,
    required this.productId,
    required this.userId,
  }) {
    key ??= TokenUtils.hashToken(TokenUtils.generateToken());
  }
}

enum StatusLicenseEnum {
  active,
  inactive,
  expired,
  pending,
  revoked;

  static StatusLicenseEnum fromString(String value) {
    return StatusLicenseEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => StatusLicenseEnum.inactive,
    );
  }
}