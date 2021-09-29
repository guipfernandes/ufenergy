import 'package:mobx/mobx.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/usecases/get_energy_measurements_usecase.dart';

part 'energy_measurements_controller.g.dart';

class EnergyMeasurementsController = EnergyMeasurementsControllerBase with _$EnergyMeasurementsController;

abstract class EnergyMeasurementsControllerBase with Store {
  final GetEnergyMeasurementsUsecase getEnergyMeasurementsUsecase;

  EnergyMeasurementsControllerBase(this.getEnergyMeasurementsUsecase) : super();

  getEnergyMeasurements() async {
    setListEnergyMeasurementsState(LoadingState());
    final result = await getEnergyMeasurementsUsecase(NoParams());
    return result.fold((error) => setListEnergyMeasurementsState(ErrorState(error)),
        (result) => setListEnergyMeasurementsState(SuccessState<List<EnergyMeasurementEntity>>(result)));
  }

  @observable
  ControlState<List<EnergyMeasurementEntity>> listEnergyMeasurementsState = InitialState();

  @action
  setListEnergyMeasurementsState(ControlState<List<EnergyMeasurementEntity>> value) => listEnergyMeasurementsState = value;
}
