import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/controller/energy_meters_controller.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/widgets/maps_widget.dart';

class MapsPage extends StatefulWidget {
  static const String routeName = '/maps';

  final EnergyMeterEntity? energyMeter;

  const MapsPage({Key? key, this.energyMeter}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends ModularState<MapsPage, EnergyMetersController> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => controller.getEnergyMeters());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        body: Container(
          child: Observer(
            builder: (_) {
              return controller.state.when(
                  initial: () => Container(),
                  loading: () => Center(child: CircularProgressIndicator()),
                  success: (energyMeters) => MapsWidget(energyMeters: energyMeters, selectedEnergyMeter: widget.energyMeter,),
                  error: (failure) => MapsWidget()
              );
            },
          ),
        ),
      ),
    );
  }

}
