import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/widgets/loading_button.dart';
import 'package:ufenergy/app/core/widgets/text_field_widget.dart';
import 'package:ufenergy/app/modules/login/presenter/controller/login_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ModularState<LoginForm, LoginController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Bem vindo!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            emailField(),
            SizedBox(height: 16),
            passwordField(),
            SizedBox(height: 24),
            buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFieldWidget(
        label: "E-mail",
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        currentFocus: _emailFocus,
        nextFocus: _passwordFocus,
        controller: controller.emailController,
        validate: true
    );
  }

  Widget passwordField() {
    return TextFieldWidget(
        label: "Senha",
        textCapitalization: TextCapitalization.none,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        currentFocus: _passwordFocus,
        controller: controller.passwordController,
        validate: true
    );
  }

  Widget buildLoginButton() {
    return Observer(
        builder: (_) {
          return LoadingButton(
              child: Text("Entrar", style: TextStyle(fontSize: 16)),
              loading: controller.loginState is LoadingState,
              color: Theme.of(context).colorScheme.background,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.login();
                }
              }
          );
        }
    );
  }
}
