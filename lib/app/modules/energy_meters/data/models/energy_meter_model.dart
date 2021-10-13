import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

class EnergyMeterModel extends EnergyMeterEntity {
  EnergyMeterModel({
    required id,
    required name,
    model,
    type,
    address,
    latitude,
    longitude,
    ultimaLeitura,
    ultimaSincronizacao
  }) : super(
            id: id,
            name: name,
            model: model,
            type: type,
            address: address,
            latitude: latitude,
            longitude: longitude,
            ultimaLeitura: ultimaLeitura,
            ultimaSincronizacao: ultimaSincronizacao);

  factory EnergyMeterModel.fromJson(Map<String, dynamic> json) => EnergyMeterModel(
      id: json['id'],
      name: json['denominacao'],
      model: json['tipo']['nome'],
      type: json['tipo_medicao']['denominacao'],
      address: json['address'],
      latitude: json['latitude'] is int ? json['latitude'].toDouble() : json['latitude'],
      longitude: json['longitude'] is int ? json['longitude'].toDouble() : json['longitude'],
      ultimaLeitura: DateTime.parse(json['data_ultima_leitura']),
      ultimaSincronizacao: DateTime.parse(json['ultima_data_sincronizada']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'model': model,
        'type': type,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'ultimaLeitura': ultimaLeitura,
        'ultimaSincronizacao': ultimaSincronizacao
      };

}