import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/theme/theme_data.dart';
import 'modules/energy_meters/energy_meters_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UFenerGy',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      themeMode: ThemeMode.light, // TODO: Adicionar lógica para alternar entre modo dark e light
      locale: const Locale("pt", "BR"),
      initialRoute: EnergyMetersModule.routeName,
    ).modular();
  }
}