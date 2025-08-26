import 'package:keyra/src/modules/user/dto/login_dto.dart';
import 'package:keyra/src/modules/user/dto/user_create_dto.dart';
import 'package:keyra/src/modules/user/dto/user_dto.dart';
import 'package:keyra/src/modules/user/entity/user_entity.dart';
import 'package:keyra/src/modules/user/services/i_user_service.dart';
import 'package:keyra/src/shared/controllers/base_controller.dart';
import 'package:keyra/src/shared/entity/base_entity.dart';
import 'package:keyra/src/shared/exceptions/not_found/not_found_exception.dart';
import 'package:vaden/vaden.dart';

@Controller('/api/v1/user')
@Api(tag: 'User', description: 'Controller for managing user data.')
class UserController extends BaseController<UserDto, UserEntity, IUserService> {
  UserController(super.service);

  @Post('/login')
  @ApiOperation(
    summary: 'Login user',
    description: 'Logs in a user with the provided admin token.',
  )

  Future<UserDto> login(@Body() LoginDto dto) async {
    final user = await service.login(dto.token);

    if (user == null) {
      throw NotFoundException('User not found with the provided admin token.');
    }

    return dtoFromEntity(user);
  }

  @Post('/create')
  @ApiOperation(
    summary: 'Create user',
    description: 'Creates a new user with the provided admin token.',
  )
  Future<UserDto> create(@Body() UserCreateDto dto) async {
    final user = await service.saveOrUpdate(
      UserEntity(
          base: BaseUserEntity.newEntity(),
          name: dto.name,
          email: dto.email,
          adminToken: '',
          apiToken: '',
      ),
    );

    return dtoFromEntity(user);
  }
}
