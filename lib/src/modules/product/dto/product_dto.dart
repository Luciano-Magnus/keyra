import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/modules/product/entity/product_entity.dart';
import 'package:keyra/src/shared/dto/base_dto.dart';
import 'package:keyra/src/shared/dto/i_base_dto.dart';
import 'package:vaden/vaden.dart';

@DTO()
@AutoMap(target: ProductEntity)
class ProductDto implements IBaseDto {
  @override
  @UseParse(BaseDtoParse)
  BaseUserDto base;
  final String name;
  final String description;

  ProductDto({
    required this.base,
    required this.name,
    required this.description,
  });
}