import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/core/utils/date_utils.dart';
import 'package:ufenergy/app/core/utils/string_utils.dart';
import 'package:ufenergy/app/core/widgets/toast_widget.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/usecases/get_energy_measurements_usecase.dart';
import 'package:ufenergy/app/modules/energy_meters/data/models/energy_meter_model.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/entities/energy_meter_entity.dart';
import 'package:ufenergy/app/modules/energy_meters/domain/usecases/get_energy_meters_usecase.dart';

part 'energy_measurements_controller.g.dart';

class EnergyMeasurementsController = EnergyMeasurementsControllerBase with _$EnergyMeasurementsController;

const DATE_TIME_FORMAT_TEXT_FIELD = "dd/MM/yyyy HH:mm";

const SAM_BIBILIOTECA_CENTRAL = 'SAM_BIBILIOTECA_CENTRAL';
const SAM_CENTRO_EVENTOS = 'SAM_CENTRO-EVENTOS';
const MED_GERACAO_BLOCO_B = 'MED_GERACAO_BLOCO_B';
const MED_GERACAO_CAE = 'MED_GERACAO_CAE';
const SAM_EMAC = 'SAM_EMAC';

abstract class EnergyMeasurementsControllerBase with Store {
  final GetEnergyMeasurementsUsecase getEnergyMeasurementsUsecase;
  final GetEnergyMetersUsecase getEnergyMetersUsecase;

  // TODO: Criar uma tabela no banco de dados que relacione os inversores
  final bibliotecaCentralIds = [1103001, 1104001, 1105001, 1106001, 1107001, 1108001];
  final centroEventosIds = [1093001, 1094001, 1095001, 1096001, 1097001, 1098001, 1099001, 1100001, 1101001, 1102001];
  final geracaoBlocoBIds = [2023001, 2037001];
  final geracaoCAEIds = [2020001, 2035001];
  final samEMACIds = [1089001, 1090001, 1091001, 1092001];

  EnergyMeasurementsControllerBase(this.getEnergyMeasurementsUsecase, this.getEnergyMetersUsecase) : super() {
    pipeline();
  }

  pipeline() {
    getEnergyMeters().then((energyMeters) {
      DateTime now = DateTime.now();
      energyMeterValue = energyMeters != null && energyMeters.isNotEmpty ? energyMeters.first.id : null;
      dateStartController.text = formatDateTime(now.subtract(Duration(days: 10)), DATE_TIME_FORMAT_TEXT_FIELD);
      dateEndController.text = formatDateTime(now, DATE_TIME_FORMAT_TEXT_FIELD);
      getEnergyMeasurements();
    });
  }

  getEnergyMeasurements() async {
    if (!validateSearch()) return;
    setListEnergyMeasurementsState(LoadingState());
    final result = await getEnergyMeasurementsUsecase(
        EnergyMeasurementsParams(
            energyMeterIds: getEnergyMetersToSearch(),
            startDate: dateStartFilter,
            endDate: dateEndFilter
        )
    );
    return result.fold(
        (error) => setListEnergyMeasurementsState(ErrorState(error)),
        (result) => setListEnergyMeasurementsState(
            SuccessState<List<EnergyMeasurementEntity>>(groupInvertersPowersIfNecessary(result))
        )
    );
  }

  bool validateSearch() {
    if (energyMeterValue == null || isEmpty(dateStartController.text) || isEmpty(dateEndController.text)) {
      showToast("Preencha todos os campos!");
      return false;
    }
    return true;
  }

  List<int> getEnergyMetersToSearch() {
    return invertersListIds.firstWhere((invs) => invs.contains(energyMeterValue), orElse: () => [energyMeterValue!]);
  }

  // TODO: Abstrair lógica para o backend, depois que criar uma tabela que relacione os inversores no banco
  List<EnergyMeasurementEntity> groupInvertersPowersIfNecessary(List<EnergyMeasurementEntity> result) {
    List<DateTime> dates = result.map((e) => e.date).toList();
    List<EnergyMeasurementEntity> energyMeasurements = dates.map((date) {
      List<EnergyMeasurementEntity> energyMeters = result.where((r) => r.date == date).toList();
      double activePower = energyMeters.fold<double>(0, (a, b) => a + b.activePower);
      double reactivePower = energyMeters.fold<double>(0, (a, b) => a + b.reactivePower);
      return EnergyMeasurementEntity(
          energyMeterId: energyMeters[0].energyMeterId,
          energyMeterName: energyMeters[0].energyMeterName,
          date: date,
          activePower: activePower,
          reactivePower: reactivePower);
    }).toList();
    return energyMeasurements;
  }

  Future<List<EnergyMeterEntity>?> getEnergyMeters() async {
    setListEnergyMetersState(LoadingState());
    final result = await getEnergyMetersUsecase(NoParams());
    List<EnergyMeterEntity> energyMeters = [];
    result.fold((error) => setListEnergyMetersState(ErrorState(error)), (result) {
      groupEnergyMeterInverters(result);
      energyMeters = result;
      setListEnergyMetersState(SuccessState<List<EnergyMeterEntity>>(result));
    });
    return energyMeters;
  }

  // TODO: Abstrair lógica para o banco de dados, criar uma tabela que relacione os inversores
  void groupEnergyMeterInverters(List<EnergyMeterEntity> energyMeters) {
    energyMeters.removeWhere((element) => invertersListIds.expand((e) => e).toList().contains(element.id));
    energyMeters.add(EnergyMeterModel(id: bibliotecaCentralIds[0], name: SAM_BIBILIOTECA_CENTRAL));
    energyMeters.add(EnergyMeterModel(id: centroEventosIds[0], name: SAM_CENTRO_EVENTOS));
    energyMeters.add(EnergyMeterModel(id: geracaoBlocoBIds[0], name: MED_GERACAO_BLOCO_B));
    energyMeters.add(EnergyMeterModel(id: geracaoCAEIds[0], name: MED_GERACAO_CAE));
    energyMeters.add(EnergyMeterModel(id: samEMACIds[0], name: SAM_EMAC));
  }

  List<List<int>> get invertersListIds => [bibliotecaCentralIds, centroEventosIds, geracaoBlocoBIds, geracaoCAEIds, samEMACIds];

  @observable
  ControlState<List<EnergyMeasurementEntity>> listEnergyMeasurementsState = InitialState();
  @action
  setListEnergyMeasurementsState(ControlState<List<EnergyMeasurementEntity>> value) => listEnergyMeasurementsState = value;

  @observable
  ControlState<List<EnergyMeterEntity>> listEnergyMetersState = InitialState();
  @action
  setListEnergyMetersState(ControlState<List<EnergyMeterEntity>> value) => listEnergyMetersState = value;

  @observable
  int? energyMeterValue;

  final dateStartController = TextEditingController();
  final dateEndController = TextEditingController();

  DateTime get dateStartFilter => parseDateTime(dateStartController.text, DATE_TIME_FORMAT_TEXT_FIELD);
  DateTime get dateEndFilter => parseDateTime(dateEndController.text, DATE_TIME_FORMAT_TEXT_FIELD);

}
