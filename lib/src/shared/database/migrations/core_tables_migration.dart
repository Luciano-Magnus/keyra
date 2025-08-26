import 'package:keyra/src/modules/activation/repositories/activation_repository.dart';
import 'package:keyra/src/modules/activation/repositories/i_activation_repository.dart';
import 'package:keyra/src/modules/license/repositories/i_license_repository.dart';
import 'package:keyra/src/modules/license/repositories/license_repository.dart';
import 'package:keyra/src/modules/product/repositories/i_product_repository.dart';
import 'package:keyra/src/modules/product/repositories/product_repository.dart';
import 'package:keyra/src/shared/database/database.dart';
import 'package:keyra/src/shared/database/migrations/i_migration.dart';
import 'package:postgres/postgres.dart';

class CoreTablesMigration implements IMigration {
  @override
  Future<void> run(Future<Result> Function({Map<String, dynamic>? parameters, required String query, TxSession? txn}) _executeQuery, TxSession? session, Database database) async {
    // Check if the migration already exists
    final result = await _executeQuery(query: "SELECT COUNT(*) AS total FROM migration WHERE nome = 'core_tables_migration';", txn: session);

    if (result.firstOrNull?.toColumnMap()['total'] > 0) {
      return; // Migration already exists, no need to run again
    }

    // Create repositories
    final IProductRepository productRepository = ProductRepository(database);
    final ILicenseRepository licenseRepository = LicenseRepository(database);
    final IActivationRepository activationRepository = ActivationRepository(database);

    print("Creating tables...");

    await _executeQuery(
      query: productRepository.createTable(),
      txn: session,
    );

    await _executeQuery(
      query: licenseRepository.createTable(),
      txn: session,
    );

    await _executeQuery(
      query: activationRepository.createTable(),
      txn: session,
    );

    final indexs = [
      ...productRepository.indexs,
      ...licenseRepository.indexs,
      ...activationRepository.indexs,
    ];

    print("Creating indexes...");
    for (final index in indexs) {
      await _executeQuery(query: index, txn: session);
    }


    // Insert the migration record
    await _executeQuery(query: "INSERT INTO migration (nome, versao) VALUES ('core_tables_migration', '1.0');", txn: session);
  }

}