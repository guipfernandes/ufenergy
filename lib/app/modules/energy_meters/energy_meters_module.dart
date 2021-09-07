import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/modules/energy_meters/data/datasources/energy_meter_datasource_impl.dart';
import 'package:ufenergy/app/modules/energy_meters/data/repositories/energy_meter_repository_impl.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/usecases/get_energy_meters_usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/controller/energy_meters_controller.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/pages/energy_meters_page.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/pages/maps_page.dart';

class EnergyMetersModule extends Module {
  static const String routeName = '/energy-meters';

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EnergyMetersController(i())),
    Bind.lazySingleton((i) => GetEnergyMetersUsecase(i())),
    Bind.lazySingleton((i) => EnergyMeterRepositoryImpl(i())),
    Bind.lazySingleton((i) => EnergyMeterDatasourceImpl(i())),
    Bind.lazySingleton((i) => Dio()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => EnergyMetersPage()),
    ChildRoute('/maps', child: (_, args) => MapsPage(energyMeter: args.data,)),
  ];
}
