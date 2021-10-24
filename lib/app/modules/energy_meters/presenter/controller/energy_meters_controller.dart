import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/core/widgets/toast_widget.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/usecases/update_energy_meter_localization_usecase.dart';

import '../../domain/usecases/get_energy_meters_usecase.dart';

part 'energy_meters_controller.g.dart';

class EnergyMetersController = EnergyMetersControllerBase with _$EnergyMetersController;

abstract class EnergyMetersControllerBase with Store {
  final GetEnergyMetersUsecase getEnergyMetersUsecase;
  final UpdateEnergyMeterLocalizationUsecase updateEnergyMeterLocalizationUsecase;

  EnergyMetersControllerBase(this.getEnergyMetersUsecase, this.updateEnergyMeterLocalizationUsecase) : super() {
    getEnergyMeters();
  }

  getEnergyMeters() async {
    setListEnergyMetersState(LoadingState());
    final result = await getEnergyMetersUsecase(NoParams());
    return result.fold(
        (error) => setListEnergyMetersState(ErrorState(error)),
        (result) => setListEnergyMetersState(SuccessState<List<EnergyMeterEntity>>(result)));
  }

  updateEnergyMeterLocalization(EnergyMeterEntity energyMeter) async {
    setUpdateLocalizationState(LoadingState());
    EnergyMeterEntity energyMeterUpdated = EnergyMeterEntity(
        id: energyMeter.id,
        name: energyMeter.name,
        latitude: double.parse(latitudeController.text.replaceAll(",", ".")),
        longitude: double.parse(longituteController.text.replaceAll(",", "."))
    );
    final result = await updateEnergyMeterLocalizationUsecase(energyMeterUpdated);
    return result.fold((error) {
      setUpdateLocalizationState(ErrorState(error));
      showToast("Não foi possível salvar os dados");
    }, (result) {
      setUpdateLocalizationState(SuccessState(null));
      showToast("Localização salva com sucesso!");
      Modular.to.pop();
      getEnergyMeters();
    });
  }

  @observable
  ControlState<List<EnergyMeterEntity>> listEnergyMetersState = InitialState();
  @action
  setListEnergyMetersState(ControlState<List<EnergyMeterEntity>> value) => listEnergyMetersState = value;

  @observable
  ControlState<void> updateLocalizationState = InitialState();
  @action
  setUpdateLocalizationState(ControlState<void> value) => updateLocalizationState = value;

  final latitudeController = TextEditingController();
  final longituteController = TextEditingController();

}
