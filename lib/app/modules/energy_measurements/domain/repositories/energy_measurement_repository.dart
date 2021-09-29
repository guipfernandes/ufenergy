import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';

abstract class IEnergyMeasurementRepository {
  Future<Either<Failure, List<EnergyMeasurementEntity>>> getEnergyMeasurements();
}
