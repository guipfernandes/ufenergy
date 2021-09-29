import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/usecases/get_energy_meters_usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/usecases/update_energy_meter_localization_usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/controller/energy_meters_controller.dart';

import '../../../../../mocks/fake_energy_meter_factory.dart';

class GetEnergyMetersUsecaseMock extends Mock implements GetEnergyMetersUsecase {}
class UpdateEnergyMeterLocalizationUsecaseMock extends Mock implements UpdateEnergyMeterLocalizationUsecase {}

void main() {
  late EnergyMetersController controller;
  late GetEnergyMetersUsecase getEnergyMetersUsecase;
  late UpdateEnergyMeterLocalizationUsecase updateEnergyMeterLocalizationUsecase;

  setUp(() {
    getEnergyMetersUsecase = GetEnergyMetersUsecaseMock();
    updateEnergyMeterLocalizationUsecase = UpdateEnergyMeterLocalizationUsecaseMock();
    controller = EnergyMetersController(getEnergyMetersUsecase, updateEnergyMeterLocalizationUsecase);
    registerFallbackValue<NoParams>(NoParams());
  });

  test('should return a Energy Meters list from the usecase', () async {
    final tEnergyMeters = FakeEnergyMeterFactory.makeEntities();
    when(() => getEnergyMetersUsecase(any())).thenAnswer((_) async => Right(tEnergyMeters));

    final result = await controller.getEnergyMeters();

    expect(result, SuccessState<List<EnergyMeterEntity>>(tEnergyMeters));
    verify(() => getEnergyMetersUsecase(NoParams())).called(1);
  });


  test('should return a Failure from the usecase when there is an error', () async {
    final tFailure = ServerFailure();
    when(() => getEnergyMetersUsecase(any())).thenAnswer((_) async => Left(tFailure));

    final result = await controller.getEnergyMeters();

    expect(result, ErrorState(tFailure));
    verify(() => getEnergyMetersUsecase(NoParams())).called(1);
  });
}