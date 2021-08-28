import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

class EnergyMeterModel extends EnergyMeterEntity {
  EnergyMeterModel({
    required id,
    required name,
    required model,
    required type,
    required address,
    required latitude,
    required longitude,
    required ultimaLeitura,
    required ultimaSincronizacao
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
      model: json['model'],
      type: json['type'],
      address: json['address'],
      latitude: json['Latitude'] is int ? json['Latitude'].toDouble() : json['Latitude'],
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