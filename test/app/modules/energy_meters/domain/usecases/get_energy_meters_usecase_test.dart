import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/repositories/energy_meter_repository.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/usecases/get_energy_meters_usecase.dart';

import '../../../../../mocks/fake_energy_meter_factory.dart';

class EnergyMeterRepositoryMock extends Mock implements IEnergyMeterRepository {}

void main() {
  late GetEnergyMetersUsecase usecase;
  late IEnergyMeterRepository repository;

  setUp(() {
    repository = EnergyMeterRepositoryMock();
    usecase = GetEnergyMetersUsecase(repository);
  });

  When mockRequest() => when(() => repository.getEnergyMeters());

  final tNoParams = NoParams();

  test('should get energy meters from repository', () async {
    final tEnergyMeters = FakeEnergyMeterFactory.makeEntities();
    mockRequest().thenAnswer((_) async => Right<Failure, List<EnergyMeterEntity>>(tEnergyMeters));

    final result = await usecase(tNoParams);

    expect(result, Right(tEnergyMeters));
    verify(() => repository.getEnergyMeters()).called(1);
  });

  test('should return a ServerFailure when don\'t succeed', () async {
    mockRequest().thenAnswer((_) async => Left<Failure, List<EnergyMeterEntity>>(ServerFailure()));

    final result = await usecase(tNoParams);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getEnergyMeters()).called(1);
  });
}
