import 'package:flutter_modular/flutter_modular.dart';

import 'core/api/client_http.dart';
import 'modules/energy_measurements/energy_measurements_module.dart';
import 'modules/energy_meters/energy_meters_module.dart';
import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ClientHttp()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(LoginModule.routeName, module: LoginModule()),
    ModuleRoute(EnergyMetersModule.routeName, module: EnergyMetersModule()),
    ModuleRoute(EnergyMeasurementsModule.routeName, module: EnergyMeasurementsModule()),
  ];
}
