import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';

class EnergyMeasurementModel extends EnergyMeasurementEntity {
  EnergyMeasurementModel({
    required energyMeterId,
    required energyMeterName,
    required date,
    activePower,
    reactivePower
  }) : super(
      energyMeterId: energyMeterId,
      energyMeterName: energyMeterName,
      date: date,
      activePower: activePower,
      reactivePower: reactivePower);

  factory EnergyMeasurementModel.fromJson(Map<String, dynamic> json) => EnergyMeasurementModel(
      energyMeterId: json['id_medidor'],
      energyMeterName: json['nome_medidor'],
      date: DateTime.parse(json['data_medicao']),
      activePower: json['potencia_ativa'] is int ? json['potencia_ativa'].toDouble() : json['potencia_ativa'],
      reactivePower: json['potencia_reativa'] is int ? json['potencia_reativa'].toDouble() : json['potencia_reativa']);

  Map<String, dynamic> toJson() => {
    'id_medidor': energyMeterId,
    'nome_medidor': energyMeterName,
    'data_medicao': date,
    'potencia_ativa': activePower,
    'potencia_reativa': reactivePower
  };

}