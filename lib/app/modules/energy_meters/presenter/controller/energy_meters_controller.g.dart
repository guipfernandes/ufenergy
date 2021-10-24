// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_meters_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EnergyMetersController on EnergyMetersControllerBase, Store {
  final _$listEnergyMetersStateAtom =
      Atom(name: 'EnergyMetersControllerBase.listEnergyMetersState');

  @override
  ControlState<List<EnergyMeterEntity>> get listEnergyMetersState {
    _$listEnergyMetersStateAtom.reportRead();
    return super.listEnergyMetersState;
  }

  @override
  set listEnergyMetersState(ControlState<List<EnergyMeterEntity>> value) {
    _$listEnergyMetersStateAtom.reportWrite(value, super.listEnergyMetersState,
        () {
      super.listEnergyMetersState = value;
    });
  }

  final _$updateLocalizationStateAtom =
      Atom(name: 'EnergyMetersControllerBase.updateLocalizationState');

  @override
  ControlState<void> get updateLocalizationState {
    _$updateLocalizationStateAtom.reportRead();
    return super.updateLocalizationState;
  }

  @override
  set updateLocalizationState(ControlState<void> value) {
    _$updateLocalizationStateAtom
        .reportWrite(value, super.updateLocalizationState, () {
      super.updateLocalizationState = value;
    });
  }

  final _$EnergyMetersControllerBaseActionController =
      ActionController(name: 'EnergyMetersControllerBase');

  @override
  dynamic setListEnergyMetersState(
      ControlState<List<EnergyMeterEntity>> value) {
    final _$actionInfo =
        _$EnergyMetersControllerBaseActionController.startAction(
            name: 'EnergyMetersControllerBase.setListEnergyMetersState');
    try {
      return super.setListEnergyMetersState(value);
    } finally {
      _$EnergyMetersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUpdateLocalizationState(ControlState<void> value) {
    final _$actionInfo =
        _$EnergyMetersControllerBaseActionController.startAction(
            name: 'EnergyMetersControllerBase.setUpdateLocalizationState');
    try {
      return super.setUpdateLocalizationState(value);
    } finally {
      _$EnergyMetersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listEnergyMetersState: ${listEnergyMetersState},
updateLocalizationState: ${updateLocalizationState}
    ''';
  }
}
