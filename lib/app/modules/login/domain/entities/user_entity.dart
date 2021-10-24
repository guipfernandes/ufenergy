import 'package:equatable/equatable.dart';

class CredentialsEntity extends Equatable {
  final String login;
  final String password;

  CredentialsEntity({
    required this.login,
    required this.password
  });

  @override
  List<Object?> get props => [
    login,
    password
  ];

}