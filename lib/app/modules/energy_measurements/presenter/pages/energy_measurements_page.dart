import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/utils/date_utils.dart';
import 'package:ufenergy/app/core/widgets/app_bar_widget.dart';
import 'package:ufenergy/app/core/widgets/drawer_widget.dart';
import 'package:ufenergy/app/core/widgets/loading_widget.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/controller/energy_measurements_controller.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/widgets/measurements_line_chart.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/widgets/measurements_line_chart_filter.dart';

class EnergyMeasurementsPage extends StatefulWidget {
  const EnergyMeasurementsPage({Key? key}) : super(key: key);

  @override
  _EnergyMeasurementsPageState createState() => _EnergyMeasurementsPageState();
}

class _EnergyMeasurementsPageState extends ModularState<EnergyMeasurementsPage, EnergyMeasurementsController> {

  @override
  void initState() {
    super.initState();
    controller.getEnergyMeters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Medições"),
      drawer: DrawerWidget(),
      body: Container(
        child: Observer(
          builder: (_) {
            return controller.listEnergyMetersState.when(
                initial: () => Container(),
                loading: () => LoadingWidget(),
                success: buildSuccessState,
                error: (failure) => Center(
                  child: MeasurementsLineChartFilter()
                )
            );
          },
        ),
      ),
    );
  }

  Widget buildSuccessState(List<String>? energyMeters) {
        DateTime now = DateTime.now();
        controller.energyMeterValue = energyMeters![0];
        controller.dateStartController.text = formatDateTime(now.subtract(Duration(days: 10)), DATE_TIME_FORMAT_TEXT_FIELD);
        controller.dateEndController.text = formatDateTime(now, DATE_TIME_FORMAT_TEXT_FIELD);
        controller.getEnergyMeasurements();

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MeasurementsLineChartFilter(energyMeters: energyMeters),
            SizedBox(height: 10,),
            Expanded(
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
            )
          ],
        );
      }
}
