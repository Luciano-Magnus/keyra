import 'package:keyra/src/modules/user/repositories/i_user_repository.dart';
import 'package:keyra/src/modules/user/repositories/user_repository.dart';
import 'package:keyra/src/shared/database/database.dart';
import 'package:keyra/src/shared/database/migrations/i_migration.dart';
import 'package:postgres/postgres.dart';

class InitialMigration implements IMigration {
  @override
  Future<void> run(
      Future<Result> _executeQuery({required String query, Map<String, dynamic>? parameters, TxSession? txn}),
      TxSession? session,
      Database database,
      ) async {
    //Verifica se já tem a migration inicial
    final result = await _executeQuery(query: "SELECT COUNT(*) AS total FROM migration;", txn: session);

    if (result.firstOrNull?.toColumnMap()['total'] > 0) {
      return;
    }

    final IUserRepository _userRepository = UserRepository(database);

    //region create tables
    await _executeQuery(
      query: _userRepository.createTable(),
      txn: session,
    );

    await _executeQuery(
      query: '''
      CREATE UNIQUE INDEX idx_unique_api_token_active_users
      ON users (api_token)
      WHERE deleted_at IS NULL;
      ''',
      txn: session,
    );
    //endregion

    //region create indexes
    for (final index in _userRepository.indexs) {
      await _executeQuery(query: index, txn: session);
    }
    //endregion

    await _executeQuery(query: "INSERT INTO migration (nome, versao) VALUES ('initial', '1.0');", txn: session);
  }
}