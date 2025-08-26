import 'package:keyra/src/modules/license/dto/license_dto.dart';
import 'package:keyra/src/modules/license/entity/license_entity.dart';
import 'package:keyra/src/modules/license/services/i_licence_service.dart';
import 'package:keyra/src/shared/controllers/base_controller.dart';
import 'package:vaden/vaden.dart';

@Controller('/api/v1/license')
@Api(tag: 'License', description: 'Controller for managing license data.')
class LicenseController extends BaseController<LicenseDto, LicenseEntity, ILicenseService> {
  LicenseController(super.service);

  @Get('/product/<id>')
   @ApiOperation(
    summary: 'Get all licenses by product ID',
    description: 'Retrieves a list of licenses associated with the specified product ID.',
  )
  Future<List<LicenseDto>> getAllByIdProduct(@Param() String id) async {
    final licenses = await service.getAllByIdProduct(id);

    return dtoListFromEntityList(licenses);
  }
}
