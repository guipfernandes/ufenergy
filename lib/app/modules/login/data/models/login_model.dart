import 'package:ufenergy/app/modules/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required login,
    required password
  }) : super(
      login: login,
      password: password);

  UserModel.fromEntity(UserEntity user) : this(
      login: user.login,
      password: user.password);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      login: json['login'],
      password: json['password']);

  Map<String, dynamic> toJson() => {
    'login': login,
    'password': password
  };

}