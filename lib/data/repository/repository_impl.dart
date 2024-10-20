import 'package:dartz/dartz.dart';
import 'package:first_project_advanced/data/data_source/remote_data_source.dart';
import 'package:first_project_advanced/data/mapper/mapper.dart';
import 'package:first_project_advanced/data/network/error_handler.dart';
import 'package:first_project_advanced/data/network/failure.dart';
import 'package:first_project_advanced/data/network/network_info.dart';
import 'package:first_project_advanced/data/network/requests.dart';
import 'package:first_project_advanced/domain/models/models.dart';
import 'package:first_project_advanced/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentiction>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its connecte to internet its safe to call api
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // success , return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure api error
          // return either left
          return Left(
            Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }
}
