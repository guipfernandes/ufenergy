import 'package:ufenergy/app/modules/login/domain/entities/user_entity.dart';

class CredentialsModel extends CredentialsEntity {
  CredentialsModel({
    required login,
    required password
  }) : super(
      login: login,
      password: password);

  CredentialsModel.fromEntity(CredentialsEntity credentials) : this(
      login: credentials.login,
      password: credentials.password);

  factory CredentialsModel.fromJson(Map<String, dynamic> json) => CredentialsModel(
      login: json['login'],
      password: json['senha']);

  Map<String, dynamic> toJson() => {
    'login': login,
    'senha': password
  };

}