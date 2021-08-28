import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/modules/energy_meters/data/datasources/energy_meter_datasource.dart';
import 'package:ufenergy/app/modules/energy_meters/data/repositories/energy_meter_repository_impl.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/repositories/energy_meter_repository.dart';

import '../../../../../mocks/fake_energy_meter_factory.dart';

class EnergyMeterDatasourceMock extends Mock implements IEnergyMeterDatasource {}

void main() {
  late IEnergyMeterRepository repository;
  late IEnergyMeterDatasource datasource;

  setUp(() {
    datasource = EnergyMeterDatasourceMock();
    repository = EnergyMeterRepositoryImpl(datasource);
  });

  test('should return energy meter model when calls datasource', () async {
    final tEnergyMeters = FakeEnergyMeterFactory.makeModels();
    when(() => datasource.getEnergyMeters()).thenAnswer((_) async => tEnergyMeters);

    final result = await repository.getEnergyMeters();

    expect(result, Right(tEnergyMeters));
    verify(() => datasource.getEnergyMeters()).called(1);
  });

  test('should throw a ServerException when the call is unsuccessful', () async {
    when(() => datasource.getEnergyMeters()).thenThrow(ServerException());

    final result = await repository.getEnergyMeters();

    expect(result, Left(ServerFailure()));
    verify(() => datasource.getEnergyMeters()).called(1);
  });

}
