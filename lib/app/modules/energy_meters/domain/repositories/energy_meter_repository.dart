import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

abstract class IEnergyMeterRepository {
  Future<Either<Failure, List<EnergyMeterEntity>>> getEnergyMeters();
}
