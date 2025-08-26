import 'package:keyra/src/shared/database/database.dart';
import 'package:postgres/postgres.dart';

abstract class IMigration {
  Future<void> run(
      Future<Result> _executeQuery({required String query, Map<String, dynamic>? parameters, TxSession? txn}),
      TxSession? session,
      Database database,
      );
}