//Classe singleton que gerencia as injeções de dependência que tem a instacia do injector com um getter para acessar o injector, no construtor recebe de fora a instancia do injector

import 'package:vaden/vaden.dart';

class DI {
  static late final _injector;

  static Injector get injector => _injector;

  static void init(Injector injector) {
    _injector = injector;
  }
}
