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
  String toString() {
    return '''
listEnergyMeasurementsState: ${listEnergyMeasurementsState}
    ''';
  }
}
