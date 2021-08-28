import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/modules/energy_meters/data/models/energy_meter_model.dart';

import 'energy_meter_datasource.dart';

part 'energy_meter_datasource_impl.g.dart';

class EnergyMeterDatasourceImpl implements IEnergyMeterDatasource {
  final Dio dio;

  EnergyMeterDatasourceImpl(this.dio);

  @override
  Future<List<EnergyMeterModel>> getEnergyMeters() async {
    try {
      this.dio.options.headers = <String, String>{ // TODO: Criar interceptor quando criar tela de login
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imd1aWxoZXJtZXBpbnRvMjVAZGlzY2VudGUudWZnLmJyIiwiZXhwIjoxNjMwMTkzOTc1LCJpZFVzdWFyaW8iOnsiU3RyaW5nIjoiNjFmZGY2YjEtMWYxMC0xNzZhLWJhNDUtZmEzZWNiMWU3Mjc3IiwiVmFsaWQiOnRydWV9fQ.rHIu7cC8JmhlqM27dDPpyGA6iwmFL-cH24IGr6Pwe8M"
      };
      final result = await RestClient(this.dio).getEnergyMeters();
      if (result.response.statusCode == 200) {
        return result.data;
      } else {
        throw ServerException();
      }
    } on DioError catch(e) {
      throw ServerException(e.message);
    } catch(e) {
      print(e);
      throw ServerException();
    }
  }
}

@RestApi(baseUrl: "http://192.168.1.9:9000/api/v1/") // TODO: abstrair baseUrl de acordo com o ambiente Dev ou Prod
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/medidor")
  Future<HttpResponse<List<EnergyMeterModel>>> getEnergyMeters();
}
