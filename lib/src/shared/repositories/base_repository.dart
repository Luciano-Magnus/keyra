import 'package:keyra/src/shared/entity/base_entity.dart';
import 'package:keyra/src/shared/entity/i_base_entity.dart';

abstract class BaseRepository<E extends IBaseEntity> {
  static const CREATE_AT_COLUMN_NAME = 'created_at';

  // ignore: constant_identifier_names
  static const DELETED_AT_COLUMN_NAME = 'deleted_at';

  // ignore: constant_identifier_names
  static const UPDATED_AT_COLUMN_NAME = 'updated_at';

  static const USER_ID_COLUMN_NAME = 'id_user';

  // ignore: constant_identifier_names
  static const DEFAULT_SEPARATOR = '~!@#%^&*()?';

  String get getTableName;

  String get getIdColumnName {
   final id = "id_$getTableName";

   //Remove plural 's' if exists
    if (id.endsWith('s')) {
      return id.substring(0, id.length - 1);
    }

    return id;
  }

  BaseUserEntity baseFromMap(Map<String, dynamic> map) {
    return BaseUserEntity(
      id: map[getIdColumnName],
      createAt: map[CREATE_AT_COLUMN_NAME],
      updateAt: map[UPDATED_AT_COLUMN_NAME],
      deletedAt: map[DELETED_AT_COLUMN_NAME],
      userId: map[USER_ID_COLUMN_NAME],
    );
  }

  Map<String, dynamic> baseToMap(E entity) {
    return {
      getIdColumnName: entity.base.id,
      CREATE_AT_COLUMN_NAME: entity.base.createAt,
      UPDATED_AT_COLUMN_NAME: entity.base.updateAt,
      DELETED_AT_COLUMN_NAME: entity.base.deletedAt,
      if (entity.base.userId != null)
        USER_ID_COLUMN_NAME: entity.base.userId,
    };
  }

  String createForeignKeyWithRestrict(String tableName, String columnName) {
    return '''
      CONSTRAINT FK_$columnName FOREIGN KEY ($columnName) REFERENCES $tableName($columnName)
      ON DELETE RESTRICT
    ''';
  }

  String createForeignKeyWithCascade(String tableName, String columnName) {
    return '''
      FOREIGN KEY ($columnName) REFERENCES $tableName($columnName)
      ON DELETE CASCADE
    ''';
  }

  String createIndex(String tableName, String columnName) {
    return '''
      CREATE INDEX idx_${tableName}_$columnName ON $tableName ($columnName);
    ''';
  }
}