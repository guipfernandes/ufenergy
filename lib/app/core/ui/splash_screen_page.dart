import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/storage/prefs.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/core/utils/string_utils.dart';
import 'package:ufenergy/app/core/widgets/app_name_widget.dart';
import 'package:ufenergy/app/modules/energy_meters/energy_meters_module.dart';
import 'package:ufenergy/app/modules/login/login_module.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      Prefs().get(Prefs.JWT_TOKEN).then((value) {
        if (!isEmpty(value)) {
          Modular.to.navigate(EnergyMetersModule.routeName);
        } else {
          Modular.to.navigate(LoginModule.routeName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetIcons.logo, width: 140,),
            AppNameWidget(),
          ],
        ),
      ),
    );
  }
}
