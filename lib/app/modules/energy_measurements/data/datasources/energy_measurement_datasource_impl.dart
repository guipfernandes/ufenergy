import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ufenergy/app/core/api/client_http.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/modules/energy_measurements/data/models/energy_measurement_model.dart';

import 'energy_measurement_datasource.dart';

part 'energy_measurement_datasource_impl.g.dart';

class EnergyMeasurementDatasourceImpl implements IEnergyMeasurementDatasource {
  final ClientHttp dio;

  EnergyMeasurementDatasourceImpl(this.dio);

  @override
  Future<List<EnergyMeasurementModel>> getEnergyMeasurements(List<int> energyMeterIds, DateTime startDate, DateTime endDate) async {
    try {
      final result = await RestClient(this.dio)
          .getEnergyMeasurements(energyMeterIds, startDate.toUtc().toIso8601String(), endDate.toUtc().toIso8601String());
      if (result.response.statusCode == 200) {
        return result.data;
      } else {
        throw ServerException();
      }
    } on DioError catch(e) {
      print(e);
      throw ServerException(e.message);
    } catch(e) {
      print(e);
      throw ServerException();
    }
  }

}

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) => _RestClient(dio, baseUrl: dio.options.baseUrl + '/api/v1');

  @GET("/medicao-hora")
  Future<HttpResponse<List<EnergyMeasurementModel>>> getEnergyMeasurements(
      @Query("idMedidores") List<int> energyMeterIds,
      @Query("dataMedicaoInicio") String measurementStartDate,
      @Query("dataMedicaoFim") String measurementEndDate
  );

}
