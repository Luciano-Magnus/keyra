import 'package:keyra/src/shared/controllers/i_base_controller.dart';
import 'package:keyra/src/shared/controllers/main_controller.dart';
import 'package:keyra/src/shared/dto/i_base_dto.dart';
import 'package:keyra/src/shared/entity/i_base_entity.dart';
import 'package:keyra/src/shared/exceptions/unauthorized/unauthorized_exception.dart';
import 'package:keyra/src/shared/extensions/request_extension.dart';
import 'package:keyra/src/shared/services/i_base_service.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_core/vaden_core.dart';


abstract class BaseController<D extends IBaseDto, E extends IBaseEntity, S extends IBaseService<E>> extends MainController<D, E> implements IBaseController<D> {
  final S service;

  BaseController(this.service);

  @ApiResponse(200, description: 'Success', content: ApiContent(type: 'application/json'))
  @ApiResponse(500, description: 'Internal Server Error', content: ApiContent(type: 'application/json'))
  @ApiResponse(400, description: 'Bad Request', content: ApiContent(type: 'application/json'))
  @ApiResponse(401, description: 'Unauthorized', content: ApiContent(type: 'application/json'))
  @ApiResponse(403, description: 'Forbidden', content: ApiContent(type: 'application/json'))
  @ApiResponse(404, description: 'Not Found', content: ApiContent(type: 'application/json'))
  @ApiResponse(405, description: 'Method Not Allowed', content: ApiContent(type: 'application/json'))
  @ApiSecurity(['apiKey'])
  @Post('/')
  @override
  Future<D> save(@Body() D dto, Request request) async {
    _setUserId(dto, request);

    final response = await service.saveOrUpdate(entityFromDto(dto));

    return dtoFromEntity(response);
  }

  @ApiResponse(200, description: 'Success', content: ApiContent(type: 'application/json'))
  @ApiResponse(500, description: 'Internal Server Error', content: ApiContent(type: 'application/json'))
  @ApiResponse(400, description: 'Bad Request', content: ApiContent(type: 'application/json'))
  @ApiResponse(401, description: 'Unauthorized', content: ApiContent(type: 'application/json'))
  @ApiResponse(403, description: 'Forbidden', content: ApiContent(type: 'application/json'))
  @ApiResponse(404, description: 'Not Found', content: ApiContent(type: 'application/json'))
  @ApiResponse(405, description: 'Method Not Allowed', content: ApiContent(type: 'application/json'))
  @ApiSecurity(['apiKey'])
  @Put('/')
  @override
  Future<D> update(@Body() D dto, Request request) async {
    _setUserId(dto, request);

    final response = await service.saveOrUpdate(entityFromDto(dto));

    return dtoFromEntity(response);
  }

  @ApiResponse(200, description: 'Success', content: ApiContent(type: 'application/json'))
  @ApiResponse(500, description: 'Internal Server Error', content: ApiContent(type: 'application/json'))
  @ApiResponse(400, description: 'Bad Request', content: ApiContent(type: 'application/json'))
  @ApiResponse(401, description: 'Unauthorized', content: ApiContent(type: 'application/json'))
  @ApiResponse(403, description: 'Forbidden', content: ApiContent(type: 'application/json'))
  @ApiResponse(404, description: 'Not Found', content: ApiContent(type: 'application/json'))
  @ApiResponse(405, description: 'Method Not Allowed', content: ApiContent(type: 'application/json'))
  @ApiSecurity(['apiKey'])
  @Get('/')
  @override
  Future<List<D>> getAll(@Query() @ApiQuery(description: 'Filter by limit', required: false) int? limit, @Query() @ApiQuery(description: 'Filter by offset', required: false) int? offset, Request request) async {
    final userId = request.userId;

    if (userId == null) {
      throw UnauthorizedException();
    }

    final response = await service.getByIdUser(userId);

    return dtoListFromEntityList(response);
  }

  @ApiResponse(200, description: 'Success', content: ApiContent(type: 'application/json'))
  @ApiResponse(500, description: 'Internal Server Error', content: ApiContent(type: 'application/json'))
  @ApiResponse(400, description: 'Bad Request', content: ApiContent(type: 'application/json'))
  @ApiResponse(401, description: 'Unauthorized', content: ApiContent(type: 'application/json'))
  @ApiResponse(403, description: 'Forbidden', content: ApiContent(type: 'application/json'))
  @ApiResponse(404, description: 'Not Found', content: ApiContent(type: 'application/json'))
  @ApiResponse(405, description: 'Method Not Allowed', content: ApiContent(type: 'application/json'))
  @ApiSecurity(['apiKey'])
  @Get('/<id>')
  @override
  Future<D> getById(@Param() String id, Request request) async {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @ApiResponse(200, description: 'Success', content: ApiContent(type: 'application/json'))
  @ApiResponse(500, description: 'Internal Server Error', content: ApiContent(type: 'application/json'))
  @ApiResponse(400, description: 'Bad Request', content: ApiContent(type: 'application/json'))
  @ApiResponse(401, description: 'Unauthorized', content: ApiContent(type: 'application/json'))
  @ApiResponse(403, description: 'Forbidden', content: ApiContent(type: 'application/json'))
  @ApiResponse(404, description: 'Not Found', content: ApiContent(type: 'application/json'))
  @ApiResponse(405, description: 'Method Not Allowed', content: ApiContent(type: 'application/json'))
  @ApiSecurity(['apiKey'])
  @Delete('/')
  @override
  Future<void> delete(@Body()D dto, Request request) async {
    _setUserId(dto, request);

     await service.delete(entityFromDto(dto));
  }

  void _setUserId(D dto, Request request) {
    final userId = request.userId;

    if (userId == null) {
      throw UnauthorizedException();
    }

    dto.base.userId = userId;
  }

}