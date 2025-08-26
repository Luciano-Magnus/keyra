import 'package:keyra/config/di/dependency_injection.dart';
import 'package:keyra/vaden_application.dart';

Future<void> main(List<String> args) async {
  final vaden = VadenApp();
  await vaden.setup();
  DI.init(vaden.injector);

  final server = await vaden.run(args);


  print('Server listening on port ${server.port}');
  print('Open your browser at http://localhost:${server.port}/docs');
}

