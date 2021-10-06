import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/modules/login/data/datasources/user_datasource.dart';
import 'package:ufenergy/app/modules/login/data/models/login_model.dart';
import 'package:ufenergy/app/modules/login/domain/entities/user_entity.dart';
import 'package:ufenergy/app/modules/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  final IUserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, void>> login(UserEntity user) async {
    try {
      return Right(await datasource.login(UserModel.fromEntity(user)));
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    }
  }
}
