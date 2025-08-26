import 'package:keyra/src/modules/product/entity/product_entity.dart';
import 'package:keyra/src/modules/product/repositories/i_product_repository.dart';
import 'package:keyra/src/modules/product/services/i_product_service.dart';
import 'package:keyra/src/shared/services/base_service.dart';
import 'package:keyra/src/shared/services/i_base_service.dart';
import 'package:vaden/vaden.dart';

@Service()
class ProductService extends BaseService<ProductEntity, IProductRepository> implements IProductService {
  ProductService(super.repository);
}