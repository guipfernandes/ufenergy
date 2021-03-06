import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/repositories/energy_measurement_repository.dart';

class GetEnergyMeasurementsUsecase implements Usecase<List<EnergyMeasurementEntity>, EnergyMeasurementsParams> {
  final IEnergyMeasurementRepository repository;

  GetEnergyMeasurementsUsecase(this.repository);

  @override
  Future<Either<Failure, List<EnergyMeasurementEntity>>> call(EnergyMeasurementsParams params) async {
    return repository.getEnergyMeasurements(params.energyMeterIds, params.startDate, params.endDate);
  }

}

class EnergyMeasurementsParams extends Equatable {
  final List<int> energyMeterIds;
  final DateTime startDate;
  final DateTime endDate;

  EnergyMeasurementsParams({
    required this.energyMeterIds,
    required this.startDate,
    required this.endDate
  });

  @override
  List<Object> get props => [energyMeterIds, startDate, endDate];
}