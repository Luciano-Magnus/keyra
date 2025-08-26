import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/modules/user/dto/user_dto.dart';
import 'package:keyra/src/shared/entity/base_entity.dart';
import 'package:keyra/src/shared/entity/i_base_entity.dart';

@AutoMap(target: UserDto)
class UserEntity implements IBaseEntity {
  @override
  BaseUserEntity base;
  String name;
  String email;
  String adminToken;
  String apiToken;

  UserEntity({
    required this.base,
    required this.name,
    required this.email,
    required this.adminToken,
    required this.apiToken,
  });

  UserEntity copyWith({
    BaseUserEntity? base,
    String? name,
    String? email,
    String? adminToken,
    String? apiToken,
  }) {
    return UserEntity(
      base: base ?? this.base,
      name: name ?? this.name,
      email: email ?? this.email,
      adminToken: adminToken ?? '',
      apiToken: apiToken ?? '',
    );
  }
}