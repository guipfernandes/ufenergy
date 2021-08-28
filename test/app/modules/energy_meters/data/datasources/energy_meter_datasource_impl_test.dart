import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/modules/energy_meters/data/datasources/energy_meter_datasource.dart';
import 'package:ufenergy/app/modules/energy_meters/data/datasources/energy_meter_datasource_impl.dart';
import 'package:ufenergy/app/modules/energy_meters/data/models/energy_meter_model.dart';

import '../../../../../mocks/fake_energy_meter_factory.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class RequestOptionsFake extends Fake implements RequestOptions {}

const dioHttpHeadersForResponseBody = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

void main() {
  late IEnergyMeterDatasource datasource;
  late Dio dio;
  late DioAdapterMock dioAdapterMock;

  setUp(() {
    dio = Dio();
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    datasource = EnergyMeterDatasourceImpl(dio);

    registerFallbackValue<RequestOptions>(RequestOptionsFake());
  });

  const energyMetersPath = 'https://example.com';

  test('should return a List<EnergyMeterModel> when the call is successful', () async {
    final tEnergyMetersJson = FakeEnergyMeterFactory.makeJsonModels();
    final httpResponse = ResponseBody.fromString(tEnergyMetersJson, 200, headers: dioHttpHeadersForResponseBody);
    when(() => dioAdapterMock.fetch(any(), any(), any())).thenAnswer((_) async => httpResponse);

    final result = await datasource.getEnergyMeters();

    final energyMetersJson = json.decode(tEnergyMetersJson.toString()) as List;
    expect(result, energyMetersJson.map((item) => EnergyMeterModel.fromJson(item)).toList());
  });

  test('should throw a ServerException when the call is unccessful', () async {
    final httpResponse = ResponseBody.fromString("something went wrong", 400);
    when(() => dioAdapterMock.fetch(any(), any(), any())).thenAnswer((_) async => httpResponse);

    final result = datasource.getEnergyMeters();

    expect(() => result, throwsA(isA<ServerException>()));
  });
}
