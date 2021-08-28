import 'package:mobx/mobx.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';

import '../../domain/usecases/get_energy_meters_usecase.dart';

part 'energy_meters_controller.g.dart';

class EnergyMetersController = EnergyMetersControllerBase with _$EnergyMetersController;

abstract class EnergyMetersControllerBase with Store {
  final GetEnergyMetersUsecase usecase;

  EnergyMetersControllerBase(this.usecase) : super();

  getEnergyMeters() async {
    var result = await usecase(NoParams());
    state = LoadingState();
    return result.fold((error) => setState(ErrorState(error)), (result) => setState(SuccessState<List<EnergyMeterEntity>>(result)));
  }

  @observable
  ControlState<List<EnergyMeterEntity>> state = InitialState();

  @action
  setState(ControlState<List<EnergyMeterEntity>> value) => state = value;
}

