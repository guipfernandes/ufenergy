import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/core/utils/string_utils.dart';
import 'package:ufenergy/app/core/widgets/save_button.dart';
import 'package:ufenergy/app/core/widgets/text_field_widget.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/controller/energy_meters_controller.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/pages/maps_page.dart';

class LocalizationDialog extends StatefulWidget {
  final EnergyMeterEntity energyMeter;

  const LocalizationDialog({Key? key, required this.energyMeter}) : super(key: key);

  @override
  _LocalizationDialogState createState() => _LocalizationDialogState();
}

class _LocalizationDialogState extends State<LocalizationDialog> {
  final controller = Modular.get<EnergyMetersController>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _latitudeFocus = FocusNode();
  final FocusNode _longitudeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    final energyMeter = widget.energyMeter;
    controller.latitudeController.text = energyMeter.latitude != null ? "${energyMeter.latitude}" : "";
    controller.longituteController.text = energyMeter.longitude != null ? "${energyMeter.longitude}" : "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 12.0),
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
          Center(child: Text(widget.energyMeter.name)),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),
                latitudeField(),
                SizedBox(height: 10.0),
                longitudeField(),
                SizedBox(height: 5.0),
                selectOnMapButton(),
              ],
            ),
          ),
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
      validate: true
    );
  }

  Widget longitudeField() {
    return TextFieldWidget(
      label: "Longitude",
      textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
      currentFocus: _longitudeFocus,
      controller: controller.longituteController,
      validate: true
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
      onPressed: onSelectOnMap,
    );
  }

  Future<void> onSelectOnMap() async {
    LatLng? energyMeterPosition;
    if (!isEmpty(controller.latitudeController.text) && !isEmpty(controller.longituteController.text)) {
      energyMeterPosition = LatLng(double.parse(controller.latitudeController.text), double.parse(controller.longituteController.text));
    }
    var selectedPosition = await Modular.to.pushNamed(Modular.to.modulePath + MapsPage.routeName,
        arguments: MapsPageArgs(selectMode: true, energyMeterPosition: energyMeterPosition));

    if (selectedPosition != null) {
      controller.latitudeController.text = "${(selectedPosition as LatLng).latitude}";
      controller.longituteController.text = "${selectedPosition.longitude}";
    }
  }

  Widget buildDialogBottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Observer(
        builder: (_) {
          return SaveButton(
            loading: controller.updateLocalizationState is LoadingState,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                controller.updateEnergyMeterLocalization(widget.energyMeter);
              }
            },
          );
        }
      ),
    );
  }


}
