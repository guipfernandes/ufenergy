import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ufenergy/app/core/utils/date_utils.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

class EnergyMeterList extends StatelessWidget {
  final List<EnergyMeterEntity> energyMeters;

  const EnergyMeterList({Key? key, required this.energyMeters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: energyMeters.length,
        itemBuilder: (context, index) {
          final energyMeter = energyMeters[index];
          return ListTile(
            title: Text(energyMeter.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Latitude: ${energyMeter.latitude ?? ""}"),
                Text("Longitude: ${energyMeter.longitude ?? ""}"),
                Text("Última Leitura: ${energyMeter.ultimaLeitura != null ? formatDateTimeToString(energyMeter.ultimaLeitura!) : ""}")
              ],
            ),
          );
        }
    );
  }
}
