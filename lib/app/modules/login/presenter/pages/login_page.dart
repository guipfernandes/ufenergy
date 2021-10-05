import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/widgets/text_field_widget.dart';
import 'package:ufenergy/app/modules/login/presenter/controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldWidget(label: "Login"),
              TextFieldWidget(label: "Senha"),
              ElevatedButton(
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(25))),
                      fixedSize: const Size(130, 50)),
                  onPressed: () {
                    controller.login();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
