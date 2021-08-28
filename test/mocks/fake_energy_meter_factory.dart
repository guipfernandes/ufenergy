import 'package:faker/faker.dart';
import 'package:ufenergy/app/modules/energy_meters/data/models/energy_meter_model.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

class FakeEnergyMeterFactory {
  static EnergyMeterEntity makeEntity() => EnergyMeterEntity(
      id: faker.randomGenerator.integer(10000000),
      name: faker.lorem.sentence(),
      model: faker.lorem.word(),
      type: faker.lorem.word(),
      address: faker.lorem.sentence(),
      latitude: faker.randomGenerator.decimal(),
      longitude: faker.randomGenerator.decimal(),
      ultimaLeitura: DateTime.now(),
      ultimaSincronizacao: DateTime.now());

  static List<EnergyMeterEntity> makeEntities({int max = 5}) => faker.randomGenerator.amount((i) => makeEntity(), max);

  static EnergyMeterModel makeModel() => EnergyMeterModel(
      id: faker.randomGenerator.integer(10000000),
      name: faker.lorem.sentence(),
      model: faker.lorem.word(),
      type: faker.lorem.word(),
      address: faker.lorem.sentence(),
      latitude: faker.randomGenerator.decimal(),
      longitude: faker.randomGenerator.decimal(),
      ultimaLeitura: DateTime.now(),
      ultimaSincronizacao: DateTime.now());

  static List<EnergyMeterModel> makeModels({int max = 5}) => faker.randomGenerator.amount((i) => makeModel(), max);

  static String makeJsonModel() => """{
    "id": "${faker.randomGenerator.integer(10000000)}",
    "name": "${faker.lorem.sentence()}",
    "model": "${faker.lorem.word()}",
    "type": "${faker.lorem.word()}",
    "address": "${faker.lorem.sentence()}",
    "latitude": ${faker.randomGenerator.decimal()},
    "longitude": ${faker.randomGenerator.decimal()},
    "ultimaLeitura": ${DateTime.now()},
    "ultimaSincronizacao": ${DateTime.now()}
  }""".replaceAll(new RegExp(r"(\r\n|\n|\r|\s+)"), "");

  static String makeJsonModels({int max = 5}) => faker.randomGenerator.amount((i) => makeJsonModel(), max).toString();
}
