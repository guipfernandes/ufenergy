import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/modules/energy_measurements/data/datasources/energy_measurement_datasource.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/repositories/energy_measurement_repository.dart';

class EnergyMeasurementRepositoryImpl implements IEnergyMeasurementRepository {
  final IEnergyMeasurementDatasource datasource;

  EnergyMeasurementRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<EnergyMeasurementEntity>>> getEnergyMeasurements(List<int> energyMeterIds, DateTime startDate, DateTime endDate) async {
    try {
      return Right(await datasource.getEnergyMeasurements(energyMeterIds, startDate, endDate));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
