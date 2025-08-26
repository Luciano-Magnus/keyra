import 'package:keyra/src/modules/activation/dto/activation_dto.dart';
import 'package:keyra/src/modules/activation/entity/activation_entity.dart';
import 'package:keyra/src/modules/activation/services/i_activation_service.dart';
import 'package:keyra/src/modules/license/services/i_licence_service.dart';
import 'package:keyra/src/shared/controllers/main_controller.dart';
import 'package:keyra/src/shared/dto/available/available_dto.dart';
import 'package:keyra/src/shared/exceptions/unauthorized/unauthorized_exception.dart';
import 'package:keyra/src/shared/extensions/request_extension.dart';
import 'package:vaden/vaden.dart';

@Controller('/api/v1/activation')
@Api(tag: 'Activation', description: 'Controller for managing activation data.')
class ActivationController extends MainController<ActivationDto, ActivationEntity> {
  final IActivationService service;
  final ILicenseService licenseService;

  ActivationController(this.service, this.licenseService);

  @Post()
  @ApiSecurity(['apiKey'])
  Future<ActivationDto> activation(@Body() ActivationDto dto, Request request) async {
    final idUser = request.userId;

    if (idUser == null) {
      throw UnauthorizedException();
    }

    dto.base.userId = idUser;

    final entity = await service.activate(entityFromDto(dto));

    return dtoFromEntity(entity);
  }

  @Get('/license/<licenseId>')
  @ApiSecurity(['apiKey'])
  Future<List<ActivationDto>> getByIdLicense(@Param() String licenseId) async {
    final entities = await service.getByIdLicense(licenseId);

    return dtoListFromEntityList(entities);
  }

  @Get('/available/<key>')
  @ApiSecurity(['apiKey'])
  Future<AvailableDto> isAvailable(@Param() String key, Request request) async {
    final idUser = request.userId;

    if (idUser == null) {
      throw UnauthorizedException();
    }

    final available = await service.available(key, idUser);

    return AvailableDto(available: available);
  }
}
