import 'package:auto_mapper/auto_mapper_annotation.dart';
import 'package:keyra/src/modules/product/dto/product_dto.dart';
import 'package:keyra/src/shared/entity/base_entity.dart';
import 'package:keyra/src/shared/entity/i_base_entity.dart';

@AutoMap(target: ProductDto)
class ProductEntity implements IBaseEntity {
  @override
  BaseUserEntity base;
  final String name;
  final String description;

  ProductEntity({
    required this.base,
    required this.name,
    required this.description,
  });

}