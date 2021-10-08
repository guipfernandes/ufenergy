import 'package:ufenergy/app/modules/login/data/models/credentials_model.dart';

abstract class IUserDatasource {
  Future<void> login(CredentialsModel credentials);
}
