import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/storage/prefs.dart';
import 'package:ufenergy/app/modules/login/login_module.dart';

class ClientHttp extends DioForNative {
  static const int CONNECT_TIMEOUT = 10 * 1000;
  static const int SEND_TIMEOUT = 10 * 1000;
  static const int RECEIVE_TIMEOUT = 30 * 1000;
  static const String AUTHORIZATION = "Authorization";
  static const String BEARER = "Bearer";

  ClientHttp() {
    options.baseUrl = "http://192.168.1.9:9000/api/v1/";
    options.connectTimeout = CONNECT_TIMEOUT;
    options.sendTimeout = SEND_TIMEOUT;
    options.receiveTimeout = RECEIVE_TIMEOUT;

    interceptors.add(InterceptorsWrapper(onRequest: requestInterceptor, onError: errorInterceptor));
  }

  Future<void> requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await Prefs().get<String>(Prefs.JWT_TOKEN);
    if (token != null) {
      super.options.headers[AUTHORIZATION] = "$BEARER $token";
    }
    return handler.next(options);
  }

  void errorInterceptor(DioError e, ErrorInterceptorHandler handler) {
    if (e.response?.statusCode == 401) {
      Modular.to.navigate(LoginModule.routeName);
    }
    return handler.next(e);
  }

}
