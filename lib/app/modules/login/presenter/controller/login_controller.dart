import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/core/widgets/toast_widget.dart';
import 'package:ufenergy/app/modules/energy_meters/energy_meters_module.dart';
import 'package:ufenergy/app/modules/login/domain/entities/user_entity.dart';
import 'package:ufenergy/app/modules/login/domain/usecases/login_usecase.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginUsecase loginUsecase;

  LoginControllerBase(this.loginUsecase) : super();

  Future<void> login() async {
    setLoginState(LoadingState());
    final result = await loginUsecase(UserEntity(login: emailController.text, password: passwordController.text));
    return result.fold((error) {
      setLoginState(ErrorState(error));
      handleError(error);
    }, (result) {
      setLoginState(SuccessState(null));
      Modular.to.navigate(EnergyMetersModule.routeName);
    });
  }

  handleError(Failure error) {
    if (error is ServerFailure) {
      if (error.message != null) {
        showToast(error.message!);
      } else {
        showToast("Falha ao comunicar com o servidor");
      }
    }
  }

  @observable
  ControlState loginState = InitialState();

  @action
  setLoginState(ControlState value) => loginState = value;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
}
