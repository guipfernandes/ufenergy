import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/core/utils/date_utils.dart';
import 'package:ufenergy/app/core/utils/string_utils.dart';
import 'package:ufenergy/app/core/widgets/toast_widget.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/usecases/get_energy_measurements_usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/usecases/get_energy_meters_usecase.dart';

part 'energy_measurements_controller.g.dart';

class EnergyMeasurementsController = EnergyMeasurementsControllerBase with _$EnergyMeasurementsController;

const DATE_TIME_FORMAT_TEXT_FIELD = "dd/MM/yyyy HH:mm";

abstract class EnergyMeasurementsControllerBase with Store {
  final GetEnergyMeasurementsUsecase getEnergyMeasurementsUsecase;
  final GetEnergyMetersUsecase getEnergyMetersUsecase;

  EnergyMeasurementsControllerBase(this.getEnergyMeasurementsUsecase, this.getEnergyMetersUsecase) : super();

  getEnergyMeasurements() async {
    if (!validateSearch()) return;
    setListEnergyMeasurementsState(LoadingState());
    final result = await getEnergyMeasurementsUsecase(
        EnergyMeasurementsParams(
            energyMeter: energyMeterValue,
            startDate: dateStartFilter,
            endDate: dateEndFilter
        )
    );
    return result.fold((error) => setListEnergyMeasurementsState(ErrorState(error)),
        (result) => setListEnergyMeasurementsState(SuccessState<List<EnergyMeasurementEntity>>(result)));
  }

  bool validateSearch() {
    if (isEmpty(energyMeterValue) || isEmpty(dateStartController.text) || isEmpty(dateEndController.text)) {
      showToast("Preencha todos os campos!");
      return false;
    }
    return true;
  }

  Future<List<String>?> getEnergyMeters() async {
    setListEnergyMetersState(LoadingState());
    final result = await getEnergyMetersUsecase(NoParams());
    List<String> energyMeters = [];
    result.fold((error) => setListEnergyMetersState(ErrorState(error)), (result) {
      energyMeters = result.map((e) => e.name).toSet().toList();
      setListEnergyMetersState(SuccessState<List<String>>(energyMeters));
    });
    return energyMeters;
  }

  @observable
  ControlState<List<EnergyMeasurementEntity>> listEnergyMeasurementsState = InitialState();
  @action
  setListEnergyMeasurementsState(ControlState<List<EnergyMeasurementEntity>> value) => listEnergyMeasurementsState = value;

  @observable
  ControlState<List<String>> listEnergyMetersState = InitialState();
  @action
  setListEnergyMetersState(ControlState<List<String>> value) => listEnergyMetersState = value;

  @observable
  String energyMeterValue = '';

  final dateStartController = TextEditingController();
  final dateEndController = TextEditingController();

  DateTime get dateStartFilter => parseDateTime(dateStartController.text, DATE_TIME_FORMAT_TEXT_FIELD);
  DateTime get dateEndFilter => parseDateTime(dateEndController.text, DATE_TIME_FORMAT_TEXT_FIELD);

}
