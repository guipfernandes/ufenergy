class UserModel {
  final String name;
  final String email;
  final String login;

  const UserModel({required this.name, required this.email, required this.login});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json['nome'],
      email: json['email'],
      login: json['login']);

  Map<String, dynamic> toJson() => {
    'nome': name,
    'email': email,
    'login': login
  };

}