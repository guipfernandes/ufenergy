// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_measurements_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EnergyMeasurementsController
    on EnergyMeasurementsControllerBase, Store {
  final _$listEnergyMeasurementsStateAtom = Atom(
      name: 'EnergyMeasurementsControllerBase.listEnergyMeasurementsState');

  @override
  ControlState<List<EnergyMeasurementEntity>> get listEnergyMeasurementsState {
    _$listEnergyMeasurementsStateAtom.reportRead();
    return super.listEnergyMeasurementsState;
  }

  @override
  set listEnergyMeasurementsState(
      ControlState<List<EnergyMeasurementEntity>> value) {
    _$listEnergyMeasurementsStateAtom
        .reportWrite(value, super.listEnergyMeasurementsState, () {
      super.listEnergyMeasurementsState = value;
    });
  }

  final _$listEnergyMetersStateAtom =
      Atom(name: 'EnergyMeasurementsControllerBase.listEnergyMetersState');

  @override
  ControlState<List<String>> get listEnergyMetersState {
    _$listEnergyMetersStateAtom.reportRead();
    return super.listEnergyMetersState;
  }

  @override
  set listEnergyMetersState(ControlState<List<String>> value) {
    _$listEnergyMetersStateAtom.reportWrite(value, super.listEnergyMetersState,
        () {
      super.listEnergyMetersState = value;
    });
  }

  final _$energyMeterValueAtom =
      Atom(name: 'EnergyMeasurementsControllerBase.energyMeterValue');

  @override
  String get energyMeterValue {
    _$energyMeterValueAtom.reportRead();
    return super.energyMeterValue;
  }

  @override
  set energyMeterValue(String value) {
    _$energyMeterValueAtom.reportWrite(value, super.energyMeterValue, () {
      super.energyMeterValue = value;
    });
  }

  final _$EnergyMeasurementsControllerBaseActionController =
      ActionController(name: 'EnergyMeasurementsControllerBase');

  @override
  dynamic setListEnergyMeasurementsState(
      ControlState<List<EnergyMeasurementEntity>> value) {
    final _$actionInfo =
        _$EnergyMeasurementsControllerBaseActionController.startAction(
            name:
                'EnergyMeasurementsControllerBase.setListEnergyMeasurementsState');
    try {
      return super.setListEnergyMeasurementsState(value);
    } finally {
      _$EnergyMeasurementsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setListEnergyMetersState(ControlState<List<String>> value) {
    final _$actionInfo =
        _$EnergyMeasurementsControllerBaseActionController.startAction(
            name: 'EnergyMeasurementsControllerBase.setListEnergyMetersState');
    try {
      return super.setListEnergyMetersState(value);
    } finally {
      _$EnergyMeasurementsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listEnergyMeasurementsState: ${listEnergyMeasurementsState},
listEnergyMetersState: ${listEnergyMetersState},
energyMeterValue: ${energyMeterValue}
    ''';
  }
}
