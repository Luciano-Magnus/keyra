import 'package:keyra/src/modules/product/dto/product_dto.dart';
import 'package:keyra/src/modules/product/entity/product_entity.dart';
import 'package:keyra/src/modules/product/services/i_product_service.dart';
import 'package:keyra/src/shared/controllers/base_controller.dart';
import 'package:keyra/src/shared/extensions/request_extension.dart';
import 'package:vaden/vaden.dart';

@Controller('/api/v1/product')
@Api(tag: 'product', description: 'Controller for managing product data.')
class ProductController extends BaseController<ProductDto, ProductEntity, IProductService> {
  ProductController(super.service);
}
