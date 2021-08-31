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
      final payload = await RestClientLogin(this.dio).login(Credentials(login: "guilherme", senha: "123456"));
      this.dio.options.headers["Authorization"] = "Bearer ${payload.token}"; // TODO: Criar interceptor quando criar tela de login

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
}

@RestApi(baseUrl: "http://192.168.1.9:9000/api/v1/") // TODO: abstrair baseUrl de acordo com o ambiente Dev ou Prod
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/medidor")
  Future<HttpResponse<List<EnergyMeterModel>>> getEnergyMeters();
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
