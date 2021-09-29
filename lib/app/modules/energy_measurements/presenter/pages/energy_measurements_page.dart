import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/widgets/app_bar_widget.dart';
import 'package:ufenergy/app/core/widgets/drawer_widget.dart';
import 'package:ufenergy/app/core/widgets/loading_widget.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/controller/energy_measurements_controller.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/widgets/measurements_line_chart.dart';

class EnergyMeasurementsPage extends StatefulWidget {
  const EnergyMeasurementsPage({Key? key}) : super(key: key);

  @override
  _EnergyMeasurementsPageState createState() => _EnergyMeasurementsPageState();
}

class _EnergyMeasurementsPageState extends ModularState<EnergyMeasurementsPage, EnergyMeasurementsController> {

  @override
  void initState() {
    super.initState();
    controller.getEnergyMeasurements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Medições"),
      drawer: DrawerWidget(),
      body: Container(
        child: Observer(
          builder: (_) {
            return controller.listEnergyMeasurementsState.when(
                initial: () => Container(),
                loading: () => LoadingWidget(),
                success: (energyMeasurements) => MeasurementLineChart(energyMeasurements: energyMeasurements!),
                error: (failure) => Center(
                  child: Text("Não foi possível consultar as medições.", style: TextStyle(fontSize: 16.0),)
                )
            );
          },
        ),
      ),
    );
  }
}
