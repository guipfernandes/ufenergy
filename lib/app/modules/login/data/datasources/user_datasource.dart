import 'package:ufenergy/app/modules/login/data/models/login_model.dart';

abstract class IUserDatasource {
  Future<void> login(UserModel user);
}
