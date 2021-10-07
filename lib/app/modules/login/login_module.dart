import 'package:flutter_modular/flutter_modular.dart';
import 'package:ufenergy/app/core/api/client_http.dart';
import 'package:ufenergy/app/core/storage/prefs.dart';

import 'data/datasources/user_datasource_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'presenter/controller/login_controller.dart';
import 'presenter/pages/login_page.dart';

class LoginModule extends Module {
  static const String routeName = '/login';

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController(i())),
    Bind.lazySingleton((i) => LoginUsecase(i())),
    Bind.lazySingleton((i) => UserRepositoryImpl(i())),
    Bind.lazySingleton((i) => UserDatasourceImpl(i(), i())),
    Bind.lazySingleton((i) => ClientHttp()),
    Bind.lazySingleton((i) => Prefs()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage())
  ];
}
