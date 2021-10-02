// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_measurement_datasource_impl.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.1.9:9000/api/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<EnergyMeasurementModel>>> getEnergyMeasurements(
      energyMeterName, measurementStartDate, measurementEndDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'nomeMedidor': energyMeterName,
      r'dataMedicaoInicio': measurementStartDate,
      r'dataMedicaoFim': measurementEndDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<HttpResponse<List<EnergyMeasurementModel>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/medicao-hora',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            EnergyMeasurementModel.fromJson(i as Map<String, dynamic>))
        .toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

class _RestClientLogin implements RestClientLogin {
  _RestClientLogin(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.1.9:9000/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginDTO> login(crendetials) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(crendetials.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginDTO>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginDTO.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}