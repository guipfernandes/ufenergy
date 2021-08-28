import 'package:ufenergy/app/modules/energy_meters/data/models/energy_meter_model.dart';

abstract class IEnergyMeterDatasource {
  Future<List<EnergyMeterModel>> getEnergyMeters();
}
