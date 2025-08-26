import 'package:keyra/auto_mapper.dart';
import 'package:keyra/src/shared/database/database.dart';
import 'package:vaden/vaden.dart';

@Component()
class AppInit implements ApplicationRunner {
  final Database database;

  AppInit(this.database);

  @override
  Future<void> run(VadenApplication app) async {
    print('Initializing application...');

    GeneratedMappings.register();

    print('Registering database...');
    await database.create();
  }
}
