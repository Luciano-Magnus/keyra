import 'package:auto_mapper/auto_mapper.dart';
import 'package:keyra/src/shared/dto/i_base_dto.dart';
import 'package:keyra/src/shared/entity/i_base_entity.dart';

class MainController<D extends IBaseDto, E extends IBaseEntity> {
  D dtoFromEntity(E entity) {
    return AutoMapper.convert(entity);
  }

  E entityFromDto(D dto) {
    return AutoMapper.convert(dto);
  }

  List<D> dtoListFromEntityList(List<E> entityList) {
    return entityList.map((e) => dtoFromEntity(e)).toList();
  }

  List<E> entityListFromDtoList(List<D> modelList) {
    return modelList.map((e) => entityFromDto(e)).toList();
  }
}
