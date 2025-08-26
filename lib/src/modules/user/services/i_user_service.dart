import 'package:keyra/src/modules/user/entity/user_entity.dart';
import 'package:keyra/src/shared/services/i_base_service.dart';

abstract class IUserService implements IBaseService<UserEntity> {
  Future<UserEntity?> login(String token);
}