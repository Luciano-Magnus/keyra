
import 'package:keyra/src/modules/activation/entity/activation_entity.dart';
import 'package:keyra/src/modules/activation/repositories/i_activation_repository.dart';
import 'package:keyra/src/shared/repositories/base_repository.dart';
import 'package:keyra/src/shared/repositories/single_repository.dart';
import 'package:vaden/vaden.dart';

@Repository()
class ActivationRepository extends SingleRepository<ActivationEntity> implements IActivationRepository {
  ActivationRepository(super.database);

  @override
  String get getTableName => 'activations';

  @override
  String createTable() {
    return '''
      CREATE TABLE IF NOT EXISTS $getTableName (
        $getIdColumnName UUID NOT NULL PRIMARY KEY,
        ${BaseRepository.CREATE_AT_COLUMN_NAME} TIMESTAMP NOT NULL,
        ${BaseRepository.UPDATED_AT_COLUMN_NAME} TIMESTAMP,
        ${BaseRepository.DELETED_AT_COLUMN_NAME} TIMESTAMP,
        ${BaseRepository.USER_ID_COLUMN_NAME} UUID NOT NULL,
        id_license UUID NOT NULL,
        key TEXT NOT NULL,
        device_id TEXT NOT NULL,
        ip_address TEXT NOT NULL,
        operating_system TEXT NOT NULL,
        ${createForeignKeyWithRestrict('licenses', 'id_license')},
        ${createForeignKeyWithRestrict('users', 'id_user')}
      );
    ''';
  }

  @override
  Future<List<ActivationEntity>> getByIdLicense(String licenseId) async {
    return await getAll(where: 'id_license = @idLicense', parameters: {
      'idLicense': licenseId,
    });
  }

  @override
  ActivationEntity fromMap(Map<String, dynamic> map) => ActivationEntity(
    base: baseFromMap(map),
    licenseId: map['id_license'],
    key: map['key'],
    deviceId: map['device_id'],
    ipAddress: map['ip_address'],
    operatingSystem: map['operating_system'],
  );

  @override
  Map<String, dynamic> toMap(ActivationEntity entity) => {
    ...baseToMap(entity),
    'id_license': entity.licenseId,
    'key': entity.key,
    'device_id': entity.deviceId,
    'ip_address': entity.ipAddress,
    'operating_system': entity.operatingSystem,
  };

  @override
  List<String> get indexs => [
    createIndex(getTableName, BaseRepository.CREATE_AT_COLUMN_NAME),
    createIndex(getTableName, BaseRepository.DELETED_AT_COLUMN_NAME),
  ];

}