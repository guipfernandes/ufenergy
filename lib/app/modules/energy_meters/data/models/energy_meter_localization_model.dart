class EnergyMeterLocalizationModel {
  final int id;
  final double? latitude;
  final double? longitude;

  EnergyMeterLocalizationModel({required this.id, this.latitude, this.longitude});

  factory EnergyMeterLocalizationModel.fromJson(Map<String, dynamic> json) => EnergyMeterLocalizationModel(
      id: json['id'],
      latitude: json['latitude'] is int ? json['latitude'].toDouble() : json['latitude'],
      longitude: json['longitude'] is int ? json['longitude'].toDouble() : json['longitude']);

  Map<String, dynamic> toJson() => {'id': id, 'latitude': latitude, 'longitude': longitude};
}
