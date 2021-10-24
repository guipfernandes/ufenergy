
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ufenergy/app/core/api/client_http.dart';
import 'package:ufenergy/app/core/storage/prefs.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/modules/login/data/models/credentials_model.dart';
import 'package:ufenergy/app/modules/login/data/models/user_model.dart';

import 'user_datasource.dart';

part 'user_datasource_impl.g.dart';

class UserDatasourceImpl implements IUserDatasource {
  final ClientHttp dio;
  final Prefs prefs;

  UserDatasourceImpl(this.dio, this.prefs);

  @override
  Future<void> login(CredentialsModel credentials) async {
    try {
      final result = await RestClient(this.dio).login(credentials);
      if (result.response.statusCode == 200) {
        await prefs.set(Prefs.JWT_TOKEN, result.data.token);
        await prefs.set(Prefs.USER, result.data.user.toJson());
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

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("/login")
  Future<HttpResponse<LoginDTO>> login(@Body() CredentialsModel crendetials);
}

class LoginDTO {
  String token;
  UserModel user;

  LoginDTO({required this.token, required this.user});

  factory LoginDTO.fromJson(Map<String, dynamic> json) => LoginDTO(
      token: json['token'],
      user: UserModel.fromJson(json['usuario']));
}
