import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/modules/energy_measurements/data/datasources/energy_measurement_datasource_impl.dart';
import 'package:ufenergy/app/modules/energy_measurements/data/repositories/energy_measurement_repository_impl.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/usecases/get_energy_measurements_usecase.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/controller/energy_measurements_controller.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/pages/energy_measurements_page.dart';

class EnergyMeasurementsModule extends Module {
  static const String routeName = '/energy-measurements';

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EnergyMeasurementsController(i())),
    Bind.lazySingleton((i) => GetEnergyMeasurementsUsecase(i())),
    Bind.lazySingleton((i) => EnergyMeasurementRepositoryImpl(i())),
    Bind.lazySingleton((i) => EnergyMeasurementDatasourceImpl(i())),
    Bind.lazySingleton((i) => Dio()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => EnergyMeasurementsPage())
  ];
}
