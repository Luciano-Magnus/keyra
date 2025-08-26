import 'package:keyra/src/modules/user/entity/user_entity.dart';
import 'package:keyra/src/shared/repositories/i_repository.dart';

abstract class IUserRepository implements IRepository<UserEntity> {
  Future<UserEntity?> getByAdminToken(String token);
  Future<UserEntity?> getByApiToken(String token);
}
