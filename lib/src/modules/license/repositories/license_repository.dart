import 'package:keyra/src/modules/license/dto/license_dto.dart';
import 'package:keyra/src/modules/license/entity/license_entity.dart';
import 'package:keyra/src/modules/license/repositories/i_license_repository.dart';
import 'package:keyra/src/shared/repositories/base_repository.dart';
import 'package:keyra/src/shared/repositories/single_repository.dart';
import 'package:vaden/vaden.dart';

@Repository()
class LicenseRepository extends SingleRepository<LicenseEntity> implements ILicenseRepository {
  LicenseRepository(super.database);

  @override
  String get getTableName => 'licenses';

  @override
  String createTable() {
    return '''
      CREATE TABLE $getTableName (
        $getIdColumnName UUID NOT NULL PRIMARY KEY,
        ${BaseRepository.CREATE_AT_COLUMN_NAME} TIMESTAMP NOT NULL,
        ${BaseRepository.UPDATED_AT_COLUMN_NAME} TIMESTAMP,
        ${BaseRepository.DELETED_AT_COLUMN_NAME} TIMESTAMP,
        ${BaseRepository.USER_ID_COLUMN_NAME} UUID NOT NULL,
        key TEXT NOT NULL,
        max_activations INTEGER NOT NULL,
        current_activations INTEGER NOT NULL,
        expiration_date TIMESTAMP,
        status TEXT NOT NULL,
        id_product UUID NOT NULL,
        ${createForeignKeyWithRestrict('products', 'id_product')},
        ${createForeignKeyWithRestrict('users', 'id_user')}
      );
    ''';
  }

  @override
  LicenseEntity fromMap(Map<String, dynamic> map) =>
      LicenseEntity(
      base: baseFromMap(map),
      key: map['key'],
      currentActivations: map['current_activations'],
      maxActivations: map['max_activations'],
      expirationDate: map['expiration_date'],
      status: StatusLicenseEnum.fromString(map['status']),
      productId: map['id_product'],
    );

  @override
  Map<String, dynamic> toMap(LicenseEntity entity ) =>  {
    ...baseToMap(entity),
    'key': entity.key,
    'current_activations': entity.currentActivations,
    'max_activations': entity.maxActivations,
    'expiration_date': entity.expirationDate?.toIso8601String(),
    'status': entity.status.name,
    'id_product': entity.productId,
  };

  @override
  List<String> get indexs => [
    createIndex(getTableName, BaseRepository.CREATE_AT_COLUMN_NAME),
    createIndex(getTableName, BaseRepository.DELETED_AT_COLUMN_NAME),
    createIndex(getTableName, 'key'),
    createIndex(getTableName, 'status'),
    createIndex(getTableName, 'expiration_date'),
    createIndex(getTableName, 'current_activations'),
    createIndex(getTableName, 'max_activations'),
  ];
}
