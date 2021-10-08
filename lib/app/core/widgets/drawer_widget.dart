
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/storage/prefs.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/core/widgets/loading_widget.dart';
import 'package:ufenergy/app/modules/energy_measurements/energy_measurements_module.dart';
import 'package:ufenergy/app/modules/energy_meters/energy_meters_module.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/pages/maps_page.dart';
import 'package:ufenergy/app/modules/login/data/models/user_model.dart';
import 'package:ufenergy/app/modules/login/login_module.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  bool isCurrentPath(String? pathRoute) {
    return ModalRoute.of(context)!.isCurrent && Modular.to.modulePath == pathRoute;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            buildMenuHeader(),
            buildMenuOption("Medidores", icon: AssetIcons.electric_meter_menu, routeName: EnergyMetersModule.routeName),
            buildMenuOption("Medições", icon: AssetIcons.chart_line, routeName: EnergyMeasurementsModule.routeName),
            buildMenuOption("Mapa", icon: AssetIcons.map_marked, routeName: EnergyMetersModule.routeName + MapsPage.routeName),
            Spacer(),
            buildMenuOption("Sair",
                icon: AssetIcons.logout,
                showDividerOnTop: true,
                onTap: () async {
                  await Prefs().remove(Prefs.JWT_TOKEN);
                  await Prefs().remove(Prefs.USER);
                  Modular.to.navigate(LoginModule.routeName);
                }
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuHeader() {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetIcons.logo, height: 50,),
          SizedBox(width: 16,),
          FutureBuilder<UserModel>(
            future: Prefs().get<Object>(Prefs.USER).then((value) => UserModel.fromJson(value)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return LoadingWidget();
              if (!snapshot.hasData) return Container();
              UserModel user = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(user.name,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(user.email,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white70),
                    ),
                  ),
                ],
              );
            }
          )
        ],
      ),
    );
  }

  Widget buildMenuOption(String title, {String? icon, String? routeName, VoidCallback? onTap, bool showDividerOnTop = false}) {
    final currentPath = isCurrentPath(routeName);
    return Column(
      children: [
        if (showDividerOnTop) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            thickness: 0.15,
            color: Colors.grey,
          ),
        ),
        ListTile(
          title: Text(title,
            style: TextStyle(color: currentPath ? Theme.of(context).colorScheme.primaryVariant : Colors.grey, fontSize: 16),
          ),
          leading: icon != null
              ? Image.asset(icon, width: 24, color: currentPath ? Theme.of(context).colorScheme.primaryVariant : Colors.grey)
              : Container(),
          onTap: () {
            if (routeName != null) {
              if (currentPath) {
                Modular.to.pop(context);
              } else {
                Scaffold.of(context).openEndDrawer();
                Modular.to.pushNamed(routeName);
              }
            } else if (onTap != null) {
              Scaffold.of(context).openEndDrawer();
              onTap();
            }
          },
        ),
        if (!showDividerOnTop) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            thickness: 0.15,
            color: currentPath ? Theme.of(context).colorScheme.primaryVariant : Colors.grey,
          ),
        )
      ],
    );
  }
}
