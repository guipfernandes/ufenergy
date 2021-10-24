import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/modules/login/domain/entities/user_entity.dart';

abstract class IUserRepository {
  Future<Either<Failure, void>> login(CredentialsEntity credentials);
}
