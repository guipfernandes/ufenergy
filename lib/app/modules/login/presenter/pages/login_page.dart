import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/states/control_state.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/core/widgets/loading_button.dart';
import 'package:ufenergy/app/core/widgets/text_field_widget.dart';
import 'package:ufenergy/app/modules/login/presenter/controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  Color primaryLoginColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildHeader(context),
            SizedBox(height: 20),
            buildLoginForm()
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: 320,
        color: primaryLoginColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetIcons.logo, width: 100),
              SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    new TextSpan(text: 'UF', style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold)),
                    new TextSpan(
                        text: 'ener',
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: Theme.of(context).backgroundColor)),
                    new TextSpan(text: 'G', style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold)),
                    new TextSpan(
                        text: 'y',
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: Theme.of(context).backgroundColor)),
                  ],
                ),
              )
            ],
        )),
      ),
    );
  }

  Widget buildLoginForm() {
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
            color: primaryLoginColor,
            size: const Size(200, 50),
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
