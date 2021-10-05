import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/core/usecase/usecase.dart';
import 'package:ufenergy/app/modules/login/domain/entities/user_entity.dart';
import 'package:ufenergy/app/modules/login/domain/repositories/user_repository.dart';

class LoginUsecase implements Usecase<void, UserEntity> {
  final IUserRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UserEntity user) async {
    return repository.login(user);
  }

}
