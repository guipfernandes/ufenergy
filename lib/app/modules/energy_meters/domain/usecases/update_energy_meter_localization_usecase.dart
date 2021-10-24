import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/repositories/energy_meter_repository.dart';

class UpdateEnergyMeterLocalizationUsecase implements Usecase<void, EnergyMeterEntity> {
  final IEnergyMeterRepository repository;

  UpdateEnergyMeterLocalizationUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(EnergyMeterEntity energyMeter) async {
    return repository.updateMeterLocalization(energyMeter);
  }

}