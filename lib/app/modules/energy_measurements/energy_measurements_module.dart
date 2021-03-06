import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/api/client_http.dart';
import 'package:ufenergy/app/modules/energy_measurements/data/datasources/energy_measurement_datasource_impl.dart';
import 'package:ufenergy/app/modules/energy_measurements/data/repositories/energy_measurement_repository_impl.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/usecases/get_energy_measurements_usecase.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/controller/energy_measurements_controller.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/pages/energy_measurements_page.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/usecases/get_energy_meters_usecase.dart';

class EnergyMeasurementsModule extends Module {
  static const String routeName = '/energy-measurements';

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EnergyMeasurementsController(i(), i())),
    Bind.lazySingleton((i) => GetEnergyMeasurementsUsecase(i())),
    Bind.lazySingleton((i) => GetEnergyMetersUsecase(i())),
    Bind.lazySingleton((i) => EnergyMeasurementRepositoryImpl(i())),
    Bind.lazySingleton((i) => EnergyMeasurementDatasourceImpl(i())),
    Bind.lazySingleton((i) => ClientHttp()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => EnergyMeasurementsPage())
  ];
}
