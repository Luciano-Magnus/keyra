import 'package:keyra/src/modules/user/entity/user_entity.dart';
import 'package:keyra/src/modules/user/repositories/i_user_repository.dart';
import 'package:keyra/src/shared/repositories/base_repository.dart';
import 'package:keyra/src/shared/repositories/single_repository.dart';
import 'package:vaden/vaden.dart';

@Repository()
class UserRepository extends SingleRepository<UserEntity> implements IUserRepository {
  UserRepository(super.database);

  @override
  String get getTableName => 'users';

  @override
  String createTable() => '''
      CREATE TABLE $getTableName (
        $getIdColumnName UUID NOT NULL PRIMARY KEY,
        ${BaseRepository.CREATE_AT_COLUMN_NAME} TIMESTAMP NOT NULL,
        ${BaseRepository.UPDATED_AT_COLUMN_NAME} TIMESTAMP,
        ${BaseRepository.DELETED_AT_COLUMN_NAME} TIMESTAMP,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        admin_token TEXT NOT NULL,
        api_token TEXT NOT NULL
      );
  ''';

  @override
  List<String> get indexs => [
    createIndex(getTableName, BaseRepository.CREATE_AT_COLUMN_NAME),
    createIndex(getTableName, 'name'),
    createIndex(getTableName, 'email'),
    createIndex(getTableName, 'admin_token'),
    createIndex(getTableName, 'api_token'),
  ];

  @override
  UserEntity fromMap(Map<String, dynamic> map) {
    return UserEntity(
      base: baseFromMap(map),
      name: map['name'],
      email: map['email'],
      adminToken: map['admin_token'],
      apiToken: map['api_token'],
    );
  }

  @override
  Map<String, dynamic> toMap(UserEntity entity) {
    return {
      ...baseToMap(entity),
      'name': entity.name,
      'email': entity.email,
      'admin_token': entity.adminToken,
      'api_token': entity.apiToken,
    };
  }

  @override
  Future<UserEntity?> getByAdminToken(String token) async {
    final result = await getAll(
      where: 'WHERE admin_token = @token',
      parameters: {
        'token': token,
      },
      limit: 1,
    );

    return result.firstOrNull;
  }

  @override
  Future<UserEntity?> getByApiToken(String token) async {
    final result = await getAll(
      where: 'WHERE api_token = @token',
      parameters: {
        'token': token,
      },
      limit: 1,
    );

    return result.firstOrNull;
  }

}