import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/modules/energy_measurements/data/models/energy_measurement_model.dart';

import 'energy_measurement_datasource.dart';

part 'energy_measurement_datasource_impl.g.dart';

class EnergyMeasurementDatasourceImpl implements IEnergyMeasurementDatasource {
  final Dio dio;

  EnergyMeasurementDatasourceImpl(this.dio);

  @override
  Future<List<EnergyMeasurementModel>> getEnergyMeasurements() async {
    try {
      this.dio.options.connectTimeout = 10 * 1000;
      this.dio.options.sendTimeout = 10 * 1000;
      this.dio.options.receiveTimeout = 30 * 1000;
      final payload = await RestClientLogin(this.dio).login(Credentials(login: "guilherme", senha: "123456"));
      this.dio.options.headers["Authorization"] = "Bearer ${payload.token}"; // TODO: Criar interceptor quando criar tela de login


      final result = await RestClient(this.dio).getEnergyMeasurements("AGRONOMIA", DateTime.parse("2021-08-22T01:00:00").toIso8601String(), DateTime.parse("2021-08-24T11:00:00").toIso8601String());
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

@RestApi(baseUrl: "http://192.168.1.9:9000/api/v1/") // TODO: abstrair baseUrl de acordo com o ambiente Dev ou Prod
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/medicao-hora")
  Future<HttpResponse<List<EnergyMeasurementModel>>> getEnergyMeasurements(
      @Query("nomeMedidor") String energyMeterName,
      @Query("dataMedicaoInicio") String measurementStartDate,
      @Query("dataMedicaoFim") String measurementEndDate
  );

}

// TODO: ================ Temporário ======================
@RestApi(baseUrl: "http://192.168.1.9:9000/")
abstract class RestClientLogin {
  factory RestClientLogin(Dio dio) = _RestClientLogin;

  @POST("/login")
  Future<LoginDTO> login(@Body() Credentials crendetials);
}

class LoginDTO {
  String? token;

  LoginDTO({this.token});

  factory LoginDTO.fromJson(Map<String, dynamic> json) => LoginDTO(
      token: json['token']);
}

class Credentials {
  final String login;
  final String senha;

  const Credentials({required this.login, required this.senha});

  Map<String, dynamic> toJson() => {
    'login': login,
    'senha': senha
  };

}
