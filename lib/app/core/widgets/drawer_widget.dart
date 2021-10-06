import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/modules/energy_measurements/energy_measurements_module.dart';
import 'package:ufenergy/app/modules/energy_meters/energy_meters_module.dart';
import 'package:ufenergy/app/modules/energy_meters/presenter/pages/maps_page.dart';
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
            buildMenuOption("Sair", icon: AssetIcons.logout, routeName: LoginModule.routeName, showDividerOnTop: true, removeUntil: true),
          ],
        ),
      ),
    );
  }

  Widget buildMenuHeader() {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetIcons.logo, height: 50,),
          SizedBox(width: 16,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("Guilherme P. Fernandes",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white70),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("guilhermepinto@discente.ufg.br",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white70),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildMenuOption(String title, {String? icon, String? routeName, bool showDividerOnTop = false, bool removeUntil = false}) {
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
                removeUntil ? Modular.to.navigate(routeName) : Modular.to.pushNamed(routeName);
              }
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
