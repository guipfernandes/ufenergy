// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on LoginControllerBase, Store {
  final _$loginStateAtom = Atom(name: 'LoginControllerBase.loginState');

  @override
  ControlState<Object> get loginState {
    _$loginStateAtom.reportRead();
    return super.loginState;
  }

  @override
  set loginState(ControlState<Object> value) {
    _$loginStateAtom.reportWrite(value, super.loginState, () {
      super.loginState = value;
    });
  }

  final _$LoginControllerBaseActionController =
      ActionController(name: 'LoginControllerBase');

  @override
  dynamic setLoginState(ControlState<Object> value) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction(
        name: 'LoginControllerBase.setLoginState');
    try {
      return super.setLoginState(value);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginState: ${loginState}
    ''';
  }
}
