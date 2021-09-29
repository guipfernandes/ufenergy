import 'package:ufenergy/app/modules/energy_measurements/data/models/energy_measurement_model.dart';

abstract class IEnergyMeasurementDatasource {
  Future<List<EnergyMeasurementModel>> getEnergyMeasurements();
}
