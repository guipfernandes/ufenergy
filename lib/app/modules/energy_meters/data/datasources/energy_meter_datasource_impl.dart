import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ufenergy/app/core/api/client_http.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/modules/energy_meters/data/models/energy_meter_localization_model.dart';
import 'package:ufenergy/app/modules/energy_meters/data/models/energy_meter_model.dart';

import 'energy_meter_datasource.dart';

part 'energy_meter_datasource_impl.g.dart';

class EnergyMeterDatasourceImpl implements IEnergyMeterDatasource {
  final ClientHttp dio;

  EnergyMeterDatasourceImpl(this.dio);

  @override
  Future<List<EnergyMeterModel>> getEnergyMeters() async {
    try {
      final result = await RestClient(this.dio).getEnergyMeters();
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

  @override
  Future<void> updateMeterLocalization(EnergyMeterLocalizationModel energyMeterLocalization) async {
    try {
      final result = await RestClient(this.dio).updateMeterLocalization(energyMeterLocalization);
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
  factory RestClient(Dio dio) = _RestClient;

  @GET("/medidor")
  Future<HttpResponse<List<EnergyMeterModel>>> getEnergyMeters();

  @PUT("medidor/localizacao")
  Future<HttpResponse<void>> updateMeterLocalization(@Body() EnergyMeterLocalizationModel energyMeterLocalization);
}
