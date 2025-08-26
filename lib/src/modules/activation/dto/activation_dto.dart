import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/modules/activation/entity/activation_entity.dart';
import 'package:keyra/src/shared/dto/base_dto.dart';
import 'package:keyra/src/shared/dto/i_base_dto.dart';
import 'package:vaden/vaden.dart';

@DTO()
@AutoMap(target: ActivationEntity)
class ActivationDto implements IBaseDto {
  @override
  @UseParse(BaseDtoParse)
  BaseUserDto base;
  final String key;
  final String deviceId;
  final String ipAddress;
  final String operatingSystem;

  ActivationDto({
    required this.base,
    required this.key,
    required this.deviceId,
    required this.ipAddress,
    required this.operatingSystem,
  });
}