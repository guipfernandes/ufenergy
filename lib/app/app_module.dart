import 'package:flutter_modular/flutter_modular.dart';

import 'modules/energy_meters/energy_meters_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(EnergyMetersModule.routeName, module: EnergyMetersModule()),
  ];
}
