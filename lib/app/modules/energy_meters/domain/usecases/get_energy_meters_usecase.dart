import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/repositories/energy_meter_repository.dart';

class GetEnergyMetersUsecase implements Usecase<List<EnergyMeterEntity>, NoParams> {
  final IEnergyMeterRepository repository;

  GetEnergyMetersUsecase(this.repository);

  @override
  Future<Either<Failure, List<EnergyMeterEntity>>> call(NoParams params) async {
    return repository.getEnergyMeters();
  }

}