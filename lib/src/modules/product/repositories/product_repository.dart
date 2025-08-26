import 'package:keyra/src/modules/product/entity/product_entity.dart';
import 'package:keyra/src/modules/product/repositories/i_product_repository.dart';
import 'package:keyra/src/shared/repositories/base_repository.dart';
import 'package:keyra/src/shared/repositories/single_repository.dart';
import 'package:vaden/vaden.dart';

@Repository()
@Scope(BindType.instance)
class ProductRepository extends SingleRepository<ProductEntity> implements IProductRepository {
  ProductRepository(super.database);

  @override
  String get getTableName => 'products';

  @override
  String createTable() {
    return '''
      CREATE TABLE $getTableName (
        $getIdColumnName UUID NOT NULL PRIMARY KEY,
        ${BaseRepository.CREATE_AT_COLUMN_NAME} TIMESTAMP NOT NULL,
        ${BaseRepository.UPDATED_AT_COLUMN_NAME} TIMESTAMP,
        ${BaseRepository.DELETED_AT_COLUMN_NAME} TIMESTAMP,
        ${BaseRepository.USER_ID_COLUMN_NAME} UUID NOT NULL,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        ${createForeignKeyWithRestrict('users', 'id_user')}
      );
    ''';
  }

  @override
  ProductEntity fromMap(Map<String, dynamic> map) =>
    ProductEntity(
      base: baseFromMap(map),
      name: map['name'],
      description: map['description'],
    );

  @override
  Map<String, dynamic> toMap(ProductEntity entity ) =>  {
    ...baseToMap(entity),
    'name': entity.name,
    'description': entity.description,
  };

  @override
  List<String> get indexs => [
    createIndex(getTableName, BaseRepository.CREATE_AT_COLUMN_NAME),
    createIndex(getTableName, 'name'),
  ];
}
