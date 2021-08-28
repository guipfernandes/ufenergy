import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  ServerException([this.message]);

  @override
  List<Object> get props => [];
}
