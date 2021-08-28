// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_meters_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EnergyMetersController on EnergyMetersControllerBase, Store {
  final _$stateAtom = Atom(name: 'EnergyMetersControllerBase.state');

  @override
  ControlState<List<EnergyMeterEntity>> get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ControlState<List<EnergyMeterEntity>> value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$EnergyMetersControllerBaseActionController =
      ActionController(name: 'EnergyMetersControllerBase');

  @override
  dynamic setState(ControlState<List<EnergyMeterEntity>> value) {
    final _$actionInfo = _$EnergyMetersControllerBaseActionController
        .startAction(name: 'EnergyMetersControllerBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$EnergyMetersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
