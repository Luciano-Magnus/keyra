
import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/modules/activation/dto/activation_dto.dart';
import 'package:keyra/src/shared/entity/base_entity.dart';
import 'package:keyra/src/shared/entity/i_base_entity.dart';

@AutoMap(target: ActivationDto)
class ActivationEntity implements IBaseEntity {
  @override
  BaseUserEntity base;

  @AutoMapFieldValue(defaultValue: '')
  String licenseId;
  final String key;
  final String deviceId;
  final String ipAddress;
  final String operatingSystem;

  ActivationEntity({
    required this.base,
    required this.licenseId,
    required this.key,
    required this.deviceId,
    required this.ipAddress,
    required this.operatingSystem,
  });

}