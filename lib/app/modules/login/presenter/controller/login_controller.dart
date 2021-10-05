import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
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
    final result = await loginUsecase(UserEntity(login: 'guilherme', password: '123456'));
    return result.fold((error) => setLoginState(ErrorState(error)), (result) {
      setLoginState(SuccessState(null));
      Modular.to.navigate(EnergyMetersModule.routeName);
    });
  }

  @observable
  ControlState loginState = InitialState();

  @action
  setLoginState(ControlState value) => loginState = value;
}
