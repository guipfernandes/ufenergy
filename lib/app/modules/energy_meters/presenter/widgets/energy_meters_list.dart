import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/core/utils/date_utils.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/pages/maps_page.dart';

import 'localization_dialog.dart';

class EnergyMeterList extends StatelessWidget {
  final List<EnergyMeterEntity> energyMeters;

  const EnergyMeterList({Key? key, required this.energyMeters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: energyMeters.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: buildEnergyMeterItem
    );
  }

  Widget buildEnergyMeterItem(context, index) {
    final energyMeter = energyMeters[index];
    return ListTile(
      title: buildEnergyMeterItemTitle(context, energyMeter),
      leading: energyMeter.type == "Geração"
          ? Image.asset(AssetIcons.solar_energy, height: 60)
          : Image.asset(AssetIcons.electric_meter, height: 60),
      subtitle: buildEnergyMeterItemBody(context , energyMeter),
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) {
          return LocalizationDialog(energyMeter: energyMeter,);
        });
      },
    );
  }

  Widget buildEnergyMeterItemTitle(BuildContext context, EnergyMeterEntity energyMeter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(energyMeter.name),
        ),
        if (energyMeter.latitude != null && energyMeter.longitude != null) IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Image.asset(AssetIcons.map_marked, height: 18, color: Theme.of(context).colorScheme.secondaryVariant,),
          onPressed: () {
            Modular.to.pushNamed(Modular.to.modulePath + MapsPage.routeName, arguments: MapsPageArgs(energyMeter: energyMeter));
          },
        )
      ],
    );
  }

  Widget buildEnergyMeterItemBody(BuildContext context, EnergyMeterEntity energyMeter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${energyMeter.type ?? "Consumo"} ${energyMeter.model != null ? "- ${energyMeter.model}" : ""}",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText2,
            children: <TextSpan>[
              new TextSpan(text: 'Latitude: ', style: Theme.of(context).textTheme.bodyText1),
              new TextSpan(text: '${energyMeter.latitude ?? ""}'),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText2,
            children: <TextSpan>[
              new TextSpan(text: 'Latitude: ', style: Theme.of(context).textTheme.bodyText1),
              new TextSpan(text: '${energyMeter.longitude ?? ""}'),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText2,
            children: <TextSpan>[
              new TextSpan(text: 'Última Leitura: ', style: Theme.of(context).textTheme.bodyText1),
              new TextSpan(text: '${energyMeter.ultimaLeitura != null ? formatDateTimeToString(energyMeter.ultimaLeitura!) : ""}'),
            ],
          ),
        ),
      ],
    );
  }
}
