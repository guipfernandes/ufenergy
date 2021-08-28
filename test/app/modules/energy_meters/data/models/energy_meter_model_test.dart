import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ufenergy/app/modules/energy_meters/data/models/energy_meter_model.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

import '../../../../../mocks/fake_energy_meter_factory.dart';

void main() {
  test('should be a subclass of EnergyMeterEntity', () {
    final tEnergyMeter = FakeEnergyMeterFactory.makeModel();
    expect(tEnergyMeter, isA<EnergyMeterEntity>());
  });

  test('should return a valid model', () {
    final tEnergyMeterMap = json.decode(FakeEnergyMeterFactory.makeJsonModel());
    final tEnergyMeterModel = EnergyMeterModel.fromJson(tEnergyMeterMap);

    final result = EnergyMeterModel.fromJson(tEnergyMeterModel.toJson());

    expect(result, tEnergyMeterModel);
  });

  test('should return a json map containing the proper data', () {
    final tEnergyMeterMap = json.decode(FakeEnergyMeterFactory.makeJsonModel());
    final tEnergyMeterModel = EnergyMeterModel.fromJson(tEnergyMeterMap);

    final result = tEnergyMeterModel.toJson();

    expect(result, tEnergyMeterMap);
  });
}
