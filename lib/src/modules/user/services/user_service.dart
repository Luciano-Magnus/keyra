import 'package:keyra/src/modules/user/entity/user_entity.dart';
import 'package:keyra/src/modules/user/repositories/i_user_repository.dart';
import 'package:keyra/src/modules/user/services/i_user_service.dart';
import 'package:keyra/src/shared/services/base_service.dart';
import 'package:keyra/src/shared/utils/token/token_utils.dart';
import 'package:vaden_core/vaden_core.dart';

@Service()
class UserService extends BaseService<UserEntity, IUserRepository> implements IUserService {
  UserService(super.repository);

  @override
  Future<UserEntity> saveOrUpdate(UserEntity entity) async {
    final userExists = await repository.getById(entity.base.id);

    UserEntity entityClone = entity.copyWith();

    String? adminToken;
    String? apiToken;

    if (userExists == null) {
      adminToken = TokenUtils.hashToken(TokenUtils.generateToken());
      apiToken = TokenUtils.hashToken(TokenUtils.generateToken());

      entityClone = entityClone.copyWith(
        adminToken: adminToken,
        apiToken: apiToken,
      );
    } else {
      entityClone = entityClone.copyWith(adminToken: userExists.adminToken, apiToken: userExists.apiToken);
    }

    final response = await super.saveOrUpdate(entityClone);

    return response.copyWith(
      adminToken: adminToken ?? '',
      apiToken: apiToken ?? '',
    );;
  }

  @override
  Future<UserEntity?> login(String token) async {
    final user = await repository.getByAdminToken(token);

    return user;
  }

}
