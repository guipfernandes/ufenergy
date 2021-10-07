import 'package:flutter/material.dart';
import 'package:ufenergy/app/modules/login/presenter/widgets/login_form.dart';
import 'package:ufenergy/app/modules/login/presenter/widgets/login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LoginHeader(),
            SizedBox(height: 20),
            LoginForm()
          ],
        ),
      ),
    );
  }

}
