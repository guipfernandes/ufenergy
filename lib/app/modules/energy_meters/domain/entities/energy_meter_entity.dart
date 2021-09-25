import 'package:equatable/equatable.dart';

class EnergyMeterEntity extends Equatable {
  final int id;
  final String name;
  final String? model;
  final String? type;
  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime? ultimaLeitura;
  final DateTime? ultimaSincronizacao;

  EnergyMeterEntity({
    required this.id,
    required this.name,
    this.model,
    this.type,
    this.address,
    this.latitude,
    this.longitude,
    this.ultimaLeitura,
    this.ultimaSincronizacao
  });

  @override
  List<Object?> get props => [
    id,
    name,
    model,
    type,
    address,
    latitude,
    longitude,
    ultimaLeitura,
    ultimaSincronizacao
  ];


}