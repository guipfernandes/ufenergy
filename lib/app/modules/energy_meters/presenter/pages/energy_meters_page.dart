import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/controller/energy_meters_controller.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/widgets/energy_meters_list.dart';

class EnergyMetersPage extends StatefulWidget {
  const EnergyMetersPage({Key? key}) : super(key: key);

  @override
  _EnergyMetersPageState createState() => _EnergyMetersPageState();
}

class _EnergyMetersPageState extends ModularState<EnergyMetersPage, EnergyMetersController> {

  @override
  void initState() {
    super.initState();
    controller.getEnergyMeters();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Medidores"),),
        body: Container(
          child: Observer(
            builder: (_) {
              return controller.state.when(
                  initial: () => Container(),
                  loading: () => Center(child: CircularProgressIndicator()),
                  success: (energyMeters) => EnergyMeterList(energyMeters: energyMeters),
                  error: (failure) => Center(child: Text("Não foi possível consultar os medidores."),)
              );
            },
          ),
        ),
      ),
    );
  }
}
