import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/repositories/energy_measurement_repository.dart';

class GetEnergyMeasurementsUsecase implements Usecase<List<EnergyMeasurementEntity>, NoParams> {
  final IEnergyMeasurementRepository repository;

  GetEnergyMeasurementsUsecase(this.repository);

  @override
  Future<Either<Failure, List<EnergyMeasurementEntity>>> call(NoParams params) async {
    return repository.getEnergyMeasurements();
  }

}