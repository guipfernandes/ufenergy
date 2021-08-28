import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/modules/energy_meters/data/datasources/energy_meter_datasource.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/repositories/energy_meter_repository.dart';


class EnergyMeterRepositoryImpl implements IEnergyMeterRepository {
  final IEnergyMeterDatasource datasource;

  EnergyMeterRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<EnergyMeterEntity>>> getEnergyMeters() async {
    try {
      return Right(await datasource.getEnergyMeters());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
