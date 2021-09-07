import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/core/widgets/text_field_widget.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/controller/energy_meters_controller.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/pages/maps_page.dart';

class LocalizationDialog extends StatefulWidget {
  final EnergyMeterEntity? energyMeter;

  const LocalizationDialog({Key? key, this.energyMeter}) : super(key: key);

  @override
  _LocalizationDialogState createState() => _LocalizationDialogState();
}

class _LocalizationDialogState extends ModularState<LocalizationDialog, EnergyMetersController> {
  final FocusNode _latitudeFocus = FocusNode();
  final FocusNode _longitudeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.energyMeter != null) {
      final energyMeter = widget.energyMeter!;
      controller.latitudeController.text = energyMeter.latitude != null ? "${energyMeter.latitude}" : "";
      controller.longituteController.text = energyMeter.longitude != null ? "${energyMeter.longitude}" : "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 320,
        child: Column(
            children: [
              buildDialogTitle(),
              buildDialogBody(),
              buildDialogBottom()
            ]
        ),
      ),
    );
  }

  Widget buildDialogTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
      child: Center(
        child: Text(
          "Localização",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  Widget buildDialogBody() {
    return Flexible(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 4.0),
        child: ListBody(children: [
          latitudeField(),
          SizedBox(height: 10.0),
          longitudeField(),
          SizedBox(height: 5.0),
          selectOnMapButton(),
        ]),
      ),
    );
  }

  Widget latitudeField() {
    return TextFieldWidget(
      label: "Latitude",
      textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
      textInputAction: TextInputAction.next,
      currentFocus: _latitudeFocus,
      nextFocus: _longitudeFocus,
      controller: controller.latitudeController,
    );
  }

  Widget longitudeField() {
    return TextFieldWidget(
      label: "Longitude",
      textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
      currentFocus: _longitudeFocus,
      controller: controller.longituteController,
    );
  }

  Widget selectOnMapButton() {
    return TextButton.icon(
      label: Text(
        "Selecionar no mapa",
        style: TextStyle(color: Colors.black45),
      ),
      icon: Image.asset(
        AssetIcons.map_marked,
        width: 18,
        color: Theme.of(context).colorScheme.secondaryVariant,
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey.shade100,
        shape: ContinuousRectangleBorder(),
      ),
      onPressed: () {
        Modular.to.pushNamed(Modular.to.modulePath + MapsPage.routeName);
      },
    );
  }

  Widget buildDialogBottom() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ElevatedButton.icon(
        label: Text("Salvar"),
        icon: Icon(Icons.check),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)), fixedSize: Size(130, 50)),
        onPressed: () {},
      ),
    );
  }


}
