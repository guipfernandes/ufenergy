import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ufenergy/app/core/storage/prefs.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/modules/login/data/models/login_model.dart';

import 'user_datasource.dart';

part 'user_datasource_impl.g.dart';

class UserDatasourceImpl implements IUserDatasource {
  final Dio dio;
  final Prefs prefs;

  UserDatasourceImpl(this.dio, this.prefs);

  @override
  Future<void> login(UserModel user) async {
    try {
      final result = await RestClient(this.dio).login(Credentials(login: user.login, password: user.password));
      if (result.response.statusCode == 200) {
        await prefs.set(Prefs.JWT_TOKEN, result.data.token);
      } else {
        throw ServerException();
      }
    } on DioError catch(e) {
      print(e);
      if (e.response?.statusCode == 401) {
        throw ServerException("Usuário ou senha inválidos");
      }
      throw ServerException();
    } catch(e) {
      print(e);
      throw ServerException();
    }
  }

}

@RestApi(baseUrl: "http://192.168.1.9:9000/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("/login")
  Future<HttpResponse<LoginDTO>> login(@Body() Credentials crendetials);
}

class LoginDTO {
  String? token;

  LoginDTO({this.token});

  factory LoginDTO.fromJson(Map<String, dynamic> json) => LoginDTO(
      token: json['token']);
}

class Credentials {
  final String login;
  final String password;

  const Credentials({required this.login, required this.password});

  Map<String, dynamic> toJson() => {
    'login': login,
    'senha': password
  };

}
