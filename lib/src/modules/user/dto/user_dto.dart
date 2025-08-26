import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/modules/user/entity/user_entity.dart';
import 'package:keyra/src/shared/dto/base_dto.dart';
import 'package:keyra/src/shared/dto/i_base_dto.dart';
import 'package:vaden/vaden.dart';

@DTO()
@AutoMap(target: UserEntity)
class UserDto with Validator<UserDto> implements IBaseDto {
  @override
  @UseParse(BaseDtoParse)
  BaseUserDto base;
  String name;
  String email;
  String adminToken;
  String apiToken;

  UserDto({
    required this.base,
    required this.name,
    required this.email,
    required this.adminToken,
    required this.apiToken,
  });

  @override
  LucidValidator<UserDto> validate(ValidatorBuilder<UserDto> builder) {
    return builder
      ..ruleFor((dto) => dto.name, key: 'name').notEmpty()
      ..ruleFor((dto) => dto.email, key: 'email').validEmailOrNull()
      ..ruleFor((dto) => dto.email, key: 'email').validEmail();
  }
}