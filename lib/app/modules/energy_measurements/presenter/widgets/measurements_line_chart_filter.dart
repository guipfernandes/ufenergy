import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/utils/date_utils.dart';
import 'package:ufenergy/app/core/widgets/dialogs/date_dialog.dart';
import 'package:ufenergy/app/core/widgets/text_field_widget.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/controller/energy_measurements_controller.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

class MeasurementsLineChartFilter extends StatefulWidget {
  final List<EnergyMeterEntity>? energyMeters;

  const MeasurementsLineChartFilter({Key? key, this.energyMeters}) : super(key: key);

  @override
  _MeasurementsLineChartFilterState createState() => _MeasurementsLineChartFilterState();
}

class _MeasurementsLineChartFilterState extends ModularState<MeasurementsLineChartFilter, EnergyMeasurementsController> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        energyMetersDropdown(),
        dateFields(),
        searchButton()
      ],
    );
  }

  Widget energyMetersDropdown() {
    return Observer(builder: (_) {
      return DropdownButton<int>(
        value: controller.energyMeterValue,
        items: widget.energyMeters?.map((EnergyMeterEntity energyMeter) {
          return DropdownMenuItem<int>(
            value: energyMeter.id,
            child: Text(energyMeter.name),
          );
        }).toList(),
        onChanged: (value) {
          controller.energyMeterValue = value!;
        },
      );
    });
  }

  Widget dateFields() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: dateField(controller.dateStartController, "Inicio", initialDate: controller.dateStartFilter),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: dateField(controller.dateEndController, "Fim", initialDate: controller.dateEndFilter),
          ),
        ),
      ],
    );
  }

  Widget dateField(TextEditingController textController, String label, {DateTime? initialDate}) {
    return TextFieldWidget(
      label: label,
      prefixIcon: Icon(
        Icons.calendar_today,
        color: Colors.grey,
      ),
      contentPadding: EdgeInsets.fromLTRB(4, 24, 4, 16),
      controller: textController,
      enableInteractiveSelection: false,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final date = await showDateDialog(context, initialDate: initialDate ?? DateTime.now());
        if (date != null) {
          final time = await showTimePicker(context: context,initialTime: TimeOfDay.fromDateTime(DateTime.now()));
          textController.text = formatDateTime(dateTimeCombine(date, time), DATE_TIME_FORMAT_TEXT_FIELD);
        }
      },
    );
  }

  Widget searchButton() {
    return ElevatedButton.icon(
        label: Text("Buscar"),
        icon: Icon(Icons.search),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(25))),
            fixedSize: const Size(130, 50)),
        onPressed: () {
          controller.getEnergyMeasurements();
        });
  }

}
