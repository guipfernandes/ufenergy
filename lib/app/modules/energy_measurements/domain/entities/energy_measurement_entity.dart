import 'package:equatable/equatable.dart';

class EnergyMeasurementEntity extends Equatable {
  final int energyMeterId;
  final String energyMeterName;
  final DateTime date;
  final double activePower;
  final double reactivePower;

  EnergyMeasurementEntity({
    required this.energyMeterId,
    required this.energyMeterName,
    required this.date,
    required this.activePower,
    required this.reactivePower
  });

  @override
  List<Object?> get props => [
    energyMeterId,
    energyMeterName,
    date,
    activePower,
    reactivePower
  ];

}