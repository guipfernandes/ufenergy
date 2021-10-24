import 'package:dartz/dartz.dart';
import 'package:ufenergy/app/core/usecase/errors/exceptions.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';
import 'package:ufenergy/app/modules/login/data/datasources/user_datasource.dart';
import 'package:ufenergy/app/modules/login/data/models/credentials_model.dart';
import 'package:ufenergy/app/modules/login/domain/entities/user_entity.dart';
import 'package:ufenergy/app/modules/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  final IUserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, void>> login(CredentialsEntity credentials) async {
    try {
      return Right(await datasource.login(CredentialsModel.fromEntity(credentials)));
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    }
  }
}
